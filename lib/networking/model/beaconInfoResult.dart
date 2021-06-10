import 'package:eTour_flutter/networking/model/beaconInfo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'beaconInfoResult.g.dart';

@JsonSerializable()
class BeaconInfoResult {
  //final List<BeaconInfo> result;
  final List<BeaconInfo>? result;

  BeaconInfoResult(this.result);

  factory BeaconInfoResult.fromJson(Map<String, dynamic> json) =>
      _$BeaconInfoResultFromJson(json);
}
