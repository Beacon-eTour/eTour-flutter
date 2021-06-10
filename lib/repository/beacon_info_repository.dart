import 'package:dio/dio.dart';
import 'package:eTour_flutter/helpers/shared_preferences_helper.dart';
import 'package:eTour_flutter/networking/api_client.dart';
import 'package:eTour_flutter/networking/api_client_helper.dart';
import 'package:eTour_flutter/networking/model/baseModel.dart';
import 'package:eTour_flutter/networking/model/beaconInfo.dart';
import 'package:eTour_flutter/networking/model/beaconInfoResult.dart';
import 'package:eTour_flutter/networking/server_error.dart';
import 'package:eTour_flutter/persistence/db_helper.dart';
import 'package:eTour_flutter/persistence/model/persistent_beacon_info.dart';

class BeaconInfoRepository {
  Future<BaseModel> getBeaconInfos(String tourId) async {
    final beaconInfoDao = await DatabaseHelper.getBeaconInfoDao();
    List<PersistentBeaconInfo> beaconInfoResponse;
    try {
      beaconInfoResponse = await beaconInfoDao.getBeaconInfosById(tourId);
    } catch (error) {
      final dioError = error as DioError;
      return BaseModel()..setException(ServerError.withError(error: dioError));
    }
    return BaseModel()..data = beaconInfoResponse;
  }

  Future<BaseModel<List<BeaconInfo>>> getBeaconInfo(String beaconId) async {
    final apiClient = ApiClient(await ApiClientHelper.getDio());
    BeaconInfoResult beaconInfoResponse;
    List<BeaconInfo>? beaconInfo;
    try {
      final currentTourId = await SharedPreferencesHelper.getIntForKey(
          SharedPreferencesKeys.tourId);
      beaconInfoResponse = await apiClient.getBeaconInfo(
          tourId: currentTourId.toString(), beaconId: beaconId);
      beaconInfo = beaconInfoResponse.result;
    } catch (error) {
      final dioError = error as DioError;
      return BaseModel()..setException(ServerError.withError(error: dioError));
    }
    return BaseModel()..data = beaconInfo;
  }
}
