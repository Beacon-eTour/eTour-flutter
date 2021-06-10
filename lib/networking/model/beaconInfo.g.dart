// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beaconInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeaconInfo _$BeaconInfoFromJson(Map<String, dynamic> json) {
  return BeaconInfo(
    (json['location'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    (json['notification'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    (json['conditions'] as List<dynamic>?)?.map((e) => e as int).toList(),
    json['isExit'] as bool?,
    json['id'] as int?,
  );
}

Map<String, dynamic> _$BeaconInfoToJson(BeaconInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location': instance.location,
      'notification': instance.notification,
      'conditions': instance.conditions,
      'isExit': instance.isExit,
    };
