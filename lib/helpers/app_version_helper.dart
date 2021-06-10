import 'package:package_info/package_info.dart';

class AppVersionHelper {
  static Future<String> getFullVersionString() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      return '${packageInfo.version} (${packageInfo.buildNumber})';
    } catch (e) {
      print('Error while getting version string $e');
      return '';
    }
  }
}
