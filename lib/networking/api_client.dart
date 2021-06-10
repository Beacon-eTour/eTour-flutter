import 'package:dio/dio.dart';
import 'package:eTour_flutter/constants/etour_config.dart';
import 'package:eTour_flutter/networking/model/beaconInfoResult.dart';
import 'package:eTour_flutter/networking/model/localization.dart';
import 'package:eTour_flutter/networking/model/tours.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) {
    return _ApiClient(dio, baseUrl: ETourConfig.baseUrl);
  }

  /*
  * Get localizations
  */
  @GET('/api/localizations')
  Future<Localization>? getLocalizations();

  /*
  * Get tours
  */
  @GET('/api/tours')
  Future<Tours> getTours();

  /*
  * Get beconInfos by [tourId]
  */
  @GET('/api/beacon_info')
  Future<BeaconInfoResult> getBeaconInfo(
      {@Query('groupId') String? tourId, @Query('beaconId') String? beaconId});
}
