import 'package:eTour_flutter/cubit/language_cubit.dart';
import 'package:eTour_flutter/persistence/db_helper.dart';
import 'package:eTour_flutter/persistence/model/persistent_localized_string.dart';
import 'package:eTour_flutter/persistence/model/persistent_tour.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TourLocalizationHelper {
  static Future<String?> getLocalizedTourName(PersistentTour tour) async {
    String? groupName = '';
    try {
      final localizationsDao = await DatabaseHelper.getLocalizationDao();
      PersistentLocalizedString? persistentLocalizedString =
          await localizationsDao.getLocalizedStringById("tour" +
              tour.id! +
              Get.context!.read<LanguageCubit>().state!.languageCode);
      if (persistentLocalizedString == null) {
        persistentLocalizedString =
            await localizationsDao.getLocalizedStringById(
                "tour" + tour.id! + "fi"); // fallback to Finnish
      }
      if (persistentLocalizedString != null) {
        groupName = persistentLocalizedString.value;
      }
    } catch (e) {
      print(e);
      return groupName;
    }
    return groupName;
  }
}
