import 'package:eTour_flutter/cubit/language_cubit.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationLocalizationsHelper {
  static getLocalizedText(Map<String, String> localizedString) {
    final currentLanguageCode =
        Get.context?.read<LanguageCubit>().state?.languageCode;
    String? translated = localizedString[currentLanguageCode];
    if (translated == null) {
      translated = localizedString["fi"] ?? ''; // Fallback to Finnish
    }
    return translated;
  }
}
