import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKeys {
  static String hasSeenIntroPages = 'hasSeenIntroPages';
  static String languageIndex = 'languageIndex';
  static String notificationsOn = 'notificationsOn';
  static String userName = 'userName';
  static String tourId = 'tourId';
  static String tourStartedAtTimestamp = 'tourStartedAtTimestamp';
  static String seenBeaconInfoIds = 'seenBeaconInfoIds';
  static String hasSeenIntroVideo = 'hasSeenIntroVideo';
}

class SharedPreferencesHelper {
  static Future<void> setStringForKey(String value, String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getStringForKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> setStringListForKey(
      List<String?> value, String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value as List<String>);
  }

  static Future<List<String>?> getStringListForKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  static Future<void> setBoolForKey(bool value, String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool?> getBoolForKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> setIntForKey(int value, String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static Future<int?> getIntForKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> removeForKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
