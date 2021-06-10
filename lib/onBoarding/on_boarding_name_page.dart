import 'package:eTour_flutter/app_localizations.dart';
import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:eTour_flutter/constants/etour_text_styles.dart';
import 'package:eTour_flutter/global/etour_button.dart';
import 'package:eTour_flutter/global/etour_divider.dart';
import 'package:eTour_flutter/helpers/shared_preferences_helper.dart';
import 'package:eTour_flutter/settings/tour_selection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingNamePage extends StatelessWidget {
  final nameEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ETourColors.white,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Text(
                  AppLocalizations.of(context)!.translate('on_boarding_welcome')!,
                  style: ETourTextStyles.semiboldItalicTitleWithColor(
                      ETourColors.brownViolet)),
              SizedBox(
                height: 16,
              ),
              ETourDivider(
                withPadding: false,
              ),
              SizedBox(
                height: 16,
              ),
              Text(AppLocalizations.of(context)!.translate('on_boarding_name')!,
                  style: ETourTextStyles.mediumItalicTitleWithColor(
                      ETourColors.brownViolet)),
              SizedBox(
                height: 16,
              ),
              TextField(
                  textCapitalization: TextCapitalization.words,
                  cursorColor: ETourColors.orange,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      borderSide: BorderSide(color: ETourColors.brownViolet),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      borderSide: BorderSide(color: ETourColors.orange),
                    ),
                  ),
                  controller: nameEditingController),
              SizedBox(
                height: 16,
              ),
              ETourDivider(
                withPadding: false,
              ),
              SizedBox(
                height: 16,
              ),
              ETourButton(
                titleTranslationKey: 'generic_continue',
                action: () async {
                  await SharedPreferencesHelper.setStringForKey(
                      nameEditingController.text,
                      SharedPreferencesKeys.userName);
                  Get.to(() => TourSelectionPage(
                        isOnBoarding: true,
                      ));
                },
              )
            ],
          ),
        ));
  }
}
