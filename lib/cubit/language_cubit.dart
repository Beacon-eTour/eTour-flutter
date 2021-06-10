import 'package:bloc/bloc.dart';
import 'package:eTour_flutter/cubit/current_info_page_cubit.dart';
import 'package:eTour_flutter/helpers/app_localization_helper.dart';
import 'package:eTour_flutter/helpers/device_info_helper.dart';
import 'package:eTour_flutter/helpers/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale?> {
  LanguageCubit() : super(null) {
    _fetchLocale();
  }

  void _fetchLocale() async {
    final supportedLocales = AppLocalizationsLoader.shared.supportedLocales;
    final languageIndex = await SharedPreferencesHelper.getIntForKey(
        SharedPreferencesKeys.languageIndex);
    if (languageIndex == null || languageIndex >= supportedLocales.length) {
      final deviceLocaleCode =
          DeviceInfoHelper.getSystemLocaleName().split('_').first;
      final supportedLangugeCodes = AppLocalizationsLoader
          .shared.supportedLocales
          .map((e) => e.languageCode);
      if (state !=
              supportedLocales[
                  supportedLangugeCodes.toList().indexOf(deviceLocaleCode)] &&
          supportedLangugeCodes.contains(deviceLocaleCode)) {
        await SharedPreferencesHelper.setIntForKey(
            supportedLangugeCodes.toList().indexOf(deviceLocaleCode),
            SharedPreferencesKeys.languageIndex);
        emit(supportedLocales[
            supportedLangugeCodes.toList().indexOf(deviceLocaleCode)]);
      } else {
        await SharedPreferencesHelper.setIntForKey(
            AppLocalizationsLoader.shared.supportedLocales
                .indexOf(supportedLocales.first),
            SharedPreferencesKeys.languageIndex);
        emit(supportedLocales.first);
      }
    } else {
      emit(supportedLocales[languageIndex]);
    }
  }

  void changeLanguage(Locale? locale) async {
    final languageIndex = await SharedPreferencesHelper.getIntForKey(
        SharedPreferencesKeys.languageIndex);
    if (AppLocalizationsLoader.shared.supportedLocales.contains(locale) &&
        languageIndex != null) {
      await SharedPreferencesHelper.setIntForKey(
          AppLocalizationsLoader.shared.supportedLocales.indexOf(locale!),
          SharedPreferencesKeys.languageIndex);
      emit(locale);
      // TODO maybe not the best approach to call this here, have to reload the info page somehow anyway
      Get.context?.read<CurrentInfoPageCubit>().setBasedOnCurrentBeaconId();
    }
  }
}
