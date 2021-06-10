import 'package:eTour_flutter/cubit/current_info_page_cubit.dart';
import 'package:eTour_flutter/helpers/notification_localizations_helper.dart';
import 'package:eTour_flutter/helpers/shared_preferences_helper.dart';
import 'package:eTour_flutter/helpers/tour_helper.dart';
import 'package:eTour_flutter/networking/model/beaconInfo.dart';
import 'package:eTour_flutter/repository/beacon_info_repository.dart';
import 'package:eTour_flutter/repository/tours_repository.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NativeEventHandler {
  String? currentBeaconInfoId;
  String? currentBeaconId;
  NativeEventHandler._privateConstructor();
  static final NativeEventHandler _instance =
      NativeEventHandler._privateConstructor();
  static NativeEventHandler get instance => _instance;

  Future<void> _scheduleNotification(
      BeaconInfo beaconInfo, List<String?> seenBeaconInfoIds) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('1', 'etourChannel', 'default',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.show(
        0,
        NotificationLocalizationsHelper.getLocalizedText(beaconInfo.location!),
        NotificationLocalizationsHelper.getLocalizedText(
            beaconInfo.notification!),
        platformChannelSpecifics,
        payload: 'item ${beaconInfo.id}');
  }

  Future<void> resetTourIfNeeded() async {
    final tourStartedAtTimestamp = await SharedPreferencesHelper.getIntForKey(
        SharedPreferencesKeys.tourStartedAtTimestamp);
    final now = DateTime.now().millisecondsSinceEpoch;
    if (tourStartedAtTimestamp == null) {
      // Set tour started timestamp
      await SharedPreferencesHelper.setIntForKey(
          now, SharedPreferencesKeys.tourStartedAtTimestamp);
    } else if (DateTime.fromMillisecondsSinceEpoch(now).isAfter(
        DateTime.fromMillisecondsSinceEpoch(tourStartedAtTimestamp)
            .add(Duration(hours: 2)))) {
      // If tour started more than 2 hours ago, remove data
      await ToursRepository().updateTours();
      await TourHelper.resetTour();
    }
  }

  Future<bool> isPartOfCurrentTour(String beaconIdString) async {
    final toursRepository = ToursRepository();
    final currentTourBeaconIdList =
        await toursRepository.getCurrentTourBeaconIdList();
    if (!currentTourBeaconIdList // If beaconId not part of the current tour, do nothing
        .contains(beaconIdString)) {
      return false;
    }
    return true;
  }

  Future<List<BeaconInfo>?> getBeaconInfos(String currentBeaconId) async {
    final beaconInfoRepository = BeaconInfoRepository();
    final beaconInfoResponse =
        await beaconInfoRepository.getBeaconInfo(currentBeaconId);
    if (beaconInfoResponse.getException() != null) {
      print(beaconInfoResponse.getException()!.getErrorMessage());
      return null;
    }

    return beaconInfoResponse.data;
  }

  BeaconInfo? getBeaconInfoToShow(
      {required List<BeaconInfo> beaconInfos,
      List<String?>? seenBeaconInfoIds}) {
    BeaconInfo? beaconInfoWithNoConditions;
    BeaconInfo? beaconInfoWithConditionsMet;
    beaconInfos.forEach((beaconInfo) {
      if (beaconInfo.conditions == null || beaconInfo.conditions!.isEmpty) {
        beaconInfoWithNoConditions = beaconInfo;
      } else {
        beaconInfoWithConditionsMet = beaconInfo;
      }
      beaconInfo.conditions?.forEach((condition) {
        if (!seenBeaconInfoIds!.contains(condition.toString())) {
          beaconInfoWithConditionsMet = null;
        }
      });
    });
    if (beaconInfoWithConditionsMet != null) {
      return beaconInfoWithConditionsMet;
    }
    return beaconInfoWithNoConditions;
  }

  Future<void> nativeEventHandler(dynamic beaconId) async {
    if (Get.context == null ||
        currentBeaconId == beaconId.toString() ||
        (await SharedPreferencesHelper.getIntForKey(
                SharedPreferencesKeys.tourId)) ==
            null) {
      return;
    }
    final beaconIdString = beaconId.toString();
    if (beaconIdString == '') return;
    if (!(await isPartOfCurrentTour(beaconIdString))) return;

    await resetTourIfNeeded();

    final beaconInfos = await getBeaconInfos(beaconIdString);
    if (beaconInfos == null || beaconInfos.isEmpty) return;
    final seenBeaconInfoIds =
        (await SharedPreferencesHelper.getStringListForKey(
                SharedPreferencesKeys.seenBeaconInfoIds)) ??
            [];

    final shouldShowBeaconInfo = getBeaconInfoToShow(
        beaconInfos: beaconInfos, seenBeaconInfoIds: seenBeaconInfoIds);
    if (shouldShowBeaconInfo == null) return;
    currentBeaconId = beaconId.toString();
    currentBeaconInfoId = shouldShowBeaconInfo.id.toString();

    if ((await SharedPreferencesHelper.getBoolForKey(
            SharedPreferencesKeys.notificationsOn) ??
        true)) {
      _scheduleNotification(shouldShowBeaconInfo, seenBeaconInfoIds);
    }

    if (!seenBeaconInfoIds.contains(currentBeaconInfoId)) {
      seenBeaconInfoIds.add(currentBeaconInfoId!);
      await SharedPreferencesHelper.setStringListForKey(
          seenBeaconInfoIds, SharedPreferencesKeys.seenBeaconInfoIds);
    }

    final toursRepository = ToursRepository();
    if (shouldShowBeaconInfo.isExit!) {
      final beaconInfoIds =
          await toursRepository.getCurrentTourBeaconInfoIdList();
      // Compare lenghts, could also sort and compare lists to ensure
      if (beaconInfoIds.length != seenBeaconInfoIds.length) {
        Get.context!
            .read<CurrentInfoPageCubit>()
            .setCurrentInfoPage(currentBeaconInfoId, true);
        return;
      }
    }

    Get.context!
        .read<CurrentInfoPageCubit>()
        .setCurrentInfoPage(currentBeaconInfoId, false);
  }

  void nativeEventErrorHandler(dynamic error) =>
      print('Received error: ${error.message}');
}
