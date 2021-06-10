import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'helpers/app_localization_helper.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Default supported
  static final List<Locale> supportedLocales = [
    Locale('fi', ''),
    //Locale('sv', ''),
    Locale('en', '')
  ];
  // Default language names
  static final List<String> languageNames = [
    'suomi',
    //'svenska',
    'English (UK)'
  ];

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // Load the language JSON file from the "i18n" folder
    var jsonString = '';
    try {
      final directory = await getApplicationDocumentsDirectory();
      final internationalizationPath =
          '${directory.path}/${locale.languageCode}.json';
      jsonString = File(internationalizationPath).readAsStringSync();
    } catch (e) {
      jsonString =
          await rootBundle.loadString('i18n/${locale.languageCode}.json');
      print('error reading remotely loaded localizations file: $e');
    }

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String? translate(String? key) {
    return _localizedStrings[key!];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return AppLocalizationsLoader.shared.supportedLocales.contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
