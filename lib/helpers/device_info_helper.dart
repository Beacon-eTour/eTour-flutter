import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceInfoHelper {
  static Future<String> getManufacturer() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.manufacturer;
    } else if (Platform.isIOS) {
      return 'Apple';
    }
    return '';
  }

  static Future<String> getModel() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      final deviceInfo = DeviceInfoPlugin();
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.model;
    }
    return '';
  }

  static String getSystemLocaleName() {
    return Platform.localeName;
  }
}
