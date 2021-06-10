import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:eTour_flutter/cubit/current_info_page_cubit.dart';
import 'package:eTour_flutter/cubit/language_cubit.dart';
import 'package:eTour_flutter/cubit/language_selection_cubit.dart';
import 'package:eTour_flutter/global/etour_app_bar.dart';
import 'package:eTour_flutter/global/etour_selection_tile.dart';
import 'package:eTour_flutter/helpers/app_localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LanguageSelectionCubit(),
      child: LanguageSelectionPageView(),
    );
  }
}

class LanguageSelectionPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ETourColors.white,
      appBar: ETourAppBar(
        titleTranslationKey: 'settings_language_selection',
        withBackButton: true,
      ),
      body: BlocBuilder<LanguageSelectionCubit, int?>(
        builder: (context, pageState) {
          return BlocBuilder<LanguageCubit, Locale?>(
            builder: (context, state) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: [
                      ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: AppLocalizationsLoader
                              .shared.supportedLocales.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ETourSelectionTile(
                                onTap: () {
                                  BlocProvider.of<LanguageSelectionCubit>(
                                          context)
                                      .select(index);
                                  BlocProvider.of<LanguageCubit>(context)
                                      .changeLanguage(AppLocalizationsLoader
                                          .shared.supportedLocales[index]);
                                  BlocProvider.of<CurrentInfoPageCubit>(context)
                                      .setBasedOnCurrentBeaconId();
                                },
                                isSelected: index ==
                                    AppLocalizationsLoader
                                        .shared.supportedLocales
                                        .indexOf(BlocProvider.of<LanguageCubit>(
                                                context)
                                            .state!),
                                title: AppLocalizationsLoader
                                    .shared.languageNames[index]);
                          }),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
