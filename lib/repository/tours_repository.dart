import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eTour_flutter/helpers/shared_preferences_helper.dart';
import 'package:eTour_flutter/networking/api_client.dart';
import 'package:eTour_flutter/networking/api_client_helper.dart';
import 'package:eTour_flutter/networking/model/baseModel.dart';
import 'package:eTour_flutter/networking/model/tour.dart';
import 'package:eTour_flutter/networking/model/tours.dart';
import 'package:eTour_flutter/networking/server_error.dart';
import 'package:eTour_flutter/persistence/db_helper.dart';
import 'package:eTour_flutter/persistence/model/persistent_localized_string.dart';
import 'package:eTour_flutter/persistence/model/persistent_tour.dart';

class ToursRepository {
  Future<List<PersistentTour>> getTours() async {
    final tourDao = await DatabaseHelper.getTourDao();
    return await tourDao.getTours();
  }

  Future<String?> getCurrenTourMapUrl() async {
    final tourDao = await DatabaseHelper.getTourDao();
    final currentTourId = await SharedPreferencesHelper.getIntForKey(
        SharedPreferencesKeys.tourId);
    final tour = await (tourDao.getTour(currentTourId.toString()));
    return tour?.mapUrl;
  }

  Future<String?> getCurrenTourIntroVideoUrl() async {
    final tourDao = await DatabaseHelper.getTourDao();
    final currentTourId = await SharedPreferencesHelper.getIntForKey(
        SharedPreferencesKeys.tourId);
    final tour = await (tourDao.getTour(currentTourId.toString()));
    return tour?.introVideoUrl;
  }

  Future<String?> getCurrenTourFeedbackUrl() async {
    final tourDao = await DatabaseHelper.getTourDao();
    final currentTourId = await SharedPreferencesHelper.getIntForKey(
        SharedPreferencesKeys.tourId);
    final tour = await (tourDao.getTour(currentTourId.toString()));
    return tour?.feedbackUrl;
  }

  Future<List<int>> getCurrentTourBeaconInfoIdList() async {
    final tourDao = await DatabaseHelper.getTourDao();
    final currentTourId = await SharedPreferencesHelper.getIntForKey(
        SharedPreferencesKeys.tourId);
    final tour = await (tourDao.getTour(currentTourId.toString()));
    return List.from(json.decode(tour!.beaconInfoIds!));
  }

  Future<List<String>> getCurrentTourBeaconIdList() async {
    final tourDao = await DatabaseHelper.getTourDao();
    final currentTourId = await SharedPreferencesHelper.getIntForKey(
        SharedPreferencesKeys.tourId);
    final tour = await (tourDao.getTour(currentTourId.toString()));
    return List.from(json.decode(tour!.beaconIds!));
  }

  Future<BaseModel<void>> updateTours() async {
    final apiClient = ApiClient(await ApiClientHelper.getDio());
    final tourDao = await DatabaseHelper.getTourDao();
    final localizationsDao = await DatabaseHelper.getLocalizationDao();
    Tours tourResponse;
    try {
      tourResponse = await apiClient.getTours();
    } catch (error) {
      final dioError = error as DioError;
      return BaseModel()..setException(ServerError.withError(error: dioError));
    }
    await Future.forEach(tourResponse.results!, (Tour tour) async {
      final persistentTour = PersistentTour(
          tour.groupId,
          tour.mapUrl,
          json.encode(tour.beaconInfoIds),
          json.encode(tour.beaconIds),
          tour.feedbackUrl,
          tour.introVideoUrl);
      await tourDao.upsert(persistentTour);
      await Future.forEach(tour.name!.entries, (dynamic localization) async {
        final persistentLocalization = (PersistentLocalizedString(
            "tour" + tour.groupId! + localization.key, localization.value));
        await localizationsDao.insertLocalizedString(persistentLocalization);
      });
    });
    return BaseModel()..data = tourResponse;
  }
}
