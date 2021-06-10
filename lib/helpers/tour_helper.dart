import 'package:eTour_flutter/helpers/native_event_handler.dart';
import 'package:eTour_flutter/helpers/shared_preferences_helper.dart';

class TourHelper {
  static Future<void> resetTour() async {
    await SharedPreferencesHelper.setBoolForKey(
        false, SharedPreferencesKeys.hasSeenIntroVideo);
    await SharedPreferencesHelper.removeForKey(
        SharedPreferencesKeys.tourStartedAtTimestamp);
    await SharedPreferencesHelper.removeForKey(
        SharedPreferencesKeys.seenBeaconInfoIds);
    NativeEventHandler.instance.currentBeaconInfoId = null;
    NativeEventHandler.instance.currentBeaconId = null;
  }
}
