import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:eTour_flutter/app_localizations.dart';
import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:eTour_flutter/constants/etour_text_styles.dart';
import 'package:eTour_flutter/cubit/current_info_page_cubit.dart';
import 'package:eTour_flutter/global/etour_app_bar.dart';
import 'package:eTour_flutter/global/etour_button.dart';
import 'package:eTour_flutter/global/etour_divider.dart';
import 'package:eTour_flutter/global/etour_gradient_border.dart';
import 'package:eTour_flutter/global/etour_switch.dart';
import 'package:eTour_flutter/helpers/app_version_helper.dart';
import 'package:eTour_flutter/helpers/shared_preferences_helper.dart';
import 'package:eTour_flutter/helpers/tour_helper.dart';
import 'package:eTour_flutter/main.dart';
import 'package:eTour_flutter/repository/tours_repository.dart';
import 'package:eTour_flutter/settings/about_web_view.dart';
import 'package:eTour_flutter/settings/language_selection.dart';
import 'package:eTour_flutter/settings/open_source_libraries_page.dart';
import 'package:eTour_flutter/settings/tour_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget getSettingsElementWithTranslationKeyAndAction(
        String translationKey, Function action) {
      return InkWell(
        onTap: action as void Function()?,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.translate(translationKey)!,
                style: ETourTextStyles.mediumItalicTitleWithColor(
                    ETourColors.brownViolet),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: ETourColors.orange,
                size: 12,
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: ETourColors.white,
        appBar: ETourAppBar(
          titleTranslationKey: 'settings_title',
          withBackButton: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  ETourDivider(),
                  getSettingsElementWithTranslationKeyAndAction(
                      'settings_tour_selection',
                      () => Get.to(() => TourSelectionPage())),
                  ETourDivider(),
                  getSettingsElementWithTranslationKeyAndAction(
                      'settings_language_selection',
                      () => Get.to(() => LanguageSelectionPage())),
                  ETourDivider(),
                  NotificationsElement(),
                  ETourDivider(),
                  getSettingsElementWithTranslationKeyAndAction(
                      'settings_give_feedback',
                      () => launch(AppLocalizations.of(context)!
                          .translate('feedbackUrl')!)),
                  ETourDivider(),
                  getSettingsElementWithTranslationKeyAndAction(
                      'settings_about_app', () => Get.to(() => AboutWebView())),
                  ETourDivider(),
                  getSettingsElementWithTranslationKeyAndAction(
                      'settings_open_source_libraries',
                      () => Get.to(() => OpenSourceLibrariesPage())),
                  ETourDivider(),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ETourButton(
                      titleTranslationKey: 'settings_reset_tour',
                      action: () async {
                        await ToursRepository().updateTours();
                        await TourHelper.resetTour();
                        await BlocProvider.of<CurrentInfoPageCubit>(context)
                            .setBasedOnCurrentBeaconId();
                        await Get.offAll(ETourBeaconHomePage());
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: FutureBuilder<String>(
                        future: AppVersionHelper.getFullVersionString(),
                        builder: (context, snapshot) {
                          return Text(
                            'App version ${snapshot.data ?? ''}',
                            style:
                                ETourTextStyles.regularRalewayCaptionWithColor(
                                    ETourColors.black),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
              ETourGradientBorder()
            ],
          ),
        ));
  }
}

class NotificationsElement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationsElementState();
}

class _NotificationsElementState extends State<NotificationsElement>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {});
    super.didChangeAppLifecycleState(state);
  }

  Future<bool> notificationsOnAndPermissionsGranted() async {
    return ((await notificationsOn() ?? false) &&
        await notificationPermissionGranted());
  }

  Future<bool?> notificationsOn() async {
    return await SharedPreferencesHelper.getBoolForKey(
        SharedPreferencesKeys.notificationsOn);
  }

  Future<bool> notificationPermissionGranted() async {
    return (await NotificationPermissions.getNotificationPermissionStatus()) ==
        PermissionStatus.granted;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
                AppLocalizations.of(context)!
                    .translate('settings_notifications')!,
                style: ETourTextStyles.mediumItalicTitleWithColor(
                    ETourColors.brownViolet)),
          ),
          FutureBuilder(
            future: notificationsOnAndPermissionsGranted(),
            builder: (context, snapshot) {
              return ETourSwitch(
                  value: snapshot.data as bool? ?? false,
                  onChanged: (value) async {
                    if (value && !(await notificationPermissionGranted())) {
                      AppSettings.openNotificationSettings();
                    }
                    await SharedPreferencesHelper.setBoolForKey(
                        value, SharedPreferencesKeys.notificationsOn);
                    setState(() {});
                  });
            },
          )
        ],
      ),
    );
  }
}
