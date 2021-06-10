import 'package:json_annotation/json_annotation.dart';

part 'beaconInfo.g.dart';

@JsonSerializable()
class BeaconInfo {
  final int? id;
  final Map<String, String>? location;
  final Map<String, String>? notification;
  final List<int>? conditions;
  final bool? isExit;

  BeaconInfo(
      this.location, this.notification, this.conditions, this.isExit, this.id);

  factory BeaconInfo.fromJson(Map<String, dynamic> json) =>
      _$BeaconInfoFromJson(json);
}
