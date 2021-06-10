import 'dart:convert';
import 'dart:io';

import 'package:eTour_flutter/app_localizations.dart';
import 'package:eTour_flutter/networking/api_client.dart';
import 'package:eTour_flutter/networking/api_client_helper.dart';
import 'package:eTour_flutter/networking/model/localization.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AppLocalizationsLoader {
  static final AppLocalizationsLoader shared = AppLocalizationsLoader();
  List<Locale> supportedLocales = [];
  List<String> languageNames = [];

  static Future<bool> loadAndSaveLocalizations() async {
    final apiClient = ApiClient(await ApiClientHelper.getDio());
    Localization? localizationsResponse;
    try {
      final documentsPath = (await getApplicationDocumentsDirectory()).path;
      localizationsResponse = await apiClient.getLocalizations();
      localizationsResponse?.results?.keys.forEach((key) {
        AppLocalizationsLoader.shared.supportedLocales.add(Locale(key, ''));
        AppLocalizationsLoader.shared.languageNames
            .add(localizationsResponse?.results?[key]['language_name']);
        // write localizations in files
        final jsonEncoded = jsonEncode(localizationsResponse?.results?[key]);
        final localizationFile = File('$documentsPath/$key.json');
        localizationFile.writeAsStringSync(jsonEncoded);
      });
    } catch (error) {
      AppLocalizationsLoader.shared.supportedLocales =
          AppLocalizations.supportedLocales;
      AppLocalizationsLoader.shared.languageNames =
          AppLocalizations.languageNames;
      print(error);
      return false;
    }

    return true;
  }
}
