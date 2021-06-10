// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beaconInfoResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeaconInfoResult _$BeaconInfoResultFromJson(Map<String, dynamic> json) {
  return BeaconInfoResult(
    (json['result'] as List<dynamic>?)
        ?.map((e) => BeaconInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BeaconInfoResultToJson(BeaconInfoResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
