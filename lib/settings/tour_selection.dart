import 'package:eTour_flutter/app_localizations.dart';
import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:eTour_flutter/constants/etour_text_styles.dart';
import 'package:eTour_flutter/cubit/current_info_page_cubit.dart';
import 'package:eTour_flutter/cubit/tour_selection_cubit.dart';
import 'package:eTour_flutter/cubit/tours_cubit.dart';
import 'package:eTour_flutter/global/etour_app_bar.dart';
import 'package:eTour_flutter/global/etour_button.dart';
import 'package:eTour_flutter/global/etour_gradient_border.dart';
import 'package:eTour_flutter/global/etour_loading_indicator.dart';
import 'package:eTour_flutter/global/etour_selection_tile.dart';
import 'package:eTour_flutter/helpers/notification_helper.dart';
import 'package:eTour_flutter/helpers/shared_preferences_helper.dart';
import 'package:eTour_flutter/helpers/tour_helper.dart';
import 'package:eTour_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class TourObject {
  final String? name;
  final String? id;

  TourObject(this.name, this.id);
}

class TourSelectionPage extends StatelessWidget {
  final bool isOnBoarding;

  const TourSelectionPage({Key? key, this.isOnBoarding = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TourSelectionCubit(),
        child: TourSelectionView(isOnBoarding: isOnBoarding));
  }
}

class TourSelectionView extends StatelessWidget {
  final bool? isOnBoarding;

  const TourSelectionView({Key? key, this.isOnBoarding}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget getElementForIndex(String index, String? name) {
      final indexInt = int.parse(index);
      final int? selectedTour =
          BlocProvider.of<TourSelectionCubit>(context).state;
      return ETourSelectionTile(
          onTap: () async {
            BlocProvider.of<TourSelectionCubit>(context).select(indexInt);
          },
          isSelected: indexInt == selectedTour,
          title: name);
    }

    Future<void> _setTourAndNavigate() async {
      await SharedPreferencesHelper.setBoolForKey(
          true, SharedPreferencesKeys.hasSeenIntroPages);
      await TourHelper.resetTour();
      BlocProvider.of<CurrentInfoPageCubit>(context)
          .setBasedOnCurrentBeaconId();
      await Get.offAll(ETourBeaconHomePage());
    }

    return Scaffold(
      backgroundColor: ETourColors.white,
      appBar: ETourAppBar(
        titleTranslationKey: 'settings_tour_selection',
        withBackButton: true,
      ),
      body: BlocBuilder<TourSelectionCubit, int?>(builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              ETourGradientBorder(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  primary: false,
                  shrinkWrap: true,
                  children: [
                    isOnBoarding!
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                future: SharedPreferencesHelper.getStringForKey(
                                    SharedPreferencesKeys.userName),
                                builder: (context, snapshot) {
                                  return Text(
                                      AppLocalizations.of(context)!
                                          .translate('on_boarding_hi')!
                                          .replaceAll(
                                              '%/XX',
                                              (snapshot.hasData)
                                                  ? ' ${snapshot.data}'
                                                  : ''),
                                      style: ETourTextStyles
                                          .mediumItalicTitleWithColor(
                                              ETourColors.brownViolet));
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    BlocBuilder<ToursCubit, ToursState>(
                      builder: (context, state) {
                        if (state is ToursLoading) {
                          return Center(child: ETourLoadingIndicator());
                        }
                        if (state is ToursLoaded) {
                          return ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: state.tourObjects.length,
                              itemBuilder: (BuildContext context, int index) {
                                return getElementForIndex(
                                    state.tourObjects[index].id!,
                                    state.tourObjects[index].name);
                              });
                        } else {
                          return Text(AppLocalizations.of(context)!
                              .translate('generic_error_description')!);
                        }
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ETourButton(
                        isEnabled: state != null,
                        titleTranslationKey: isOnBoarding!
                            ? 'on_boarding_take_me_to_tour'
                            : 'settings_apply',
                        action: isOnBoarding!
                            ? () async {
                                await NotificationHelper.initialize();
                                await _setTourAndNavigate();
                              }
                            : () async {
                                await _setTourAndNavigate();
                              })
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
