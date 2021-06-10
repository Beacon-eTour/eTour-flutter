// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tour _$TourFromJson(Map<String, dynamic> json) {
  return Tour(
    json['name'] as Map<String, dynamic>?,
    json['groupId'] as String?,
    json['mapUrl'] as String?,
    (json['beaconInfoIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
    json['feedbackUrl'] as String?,
    json['introVideoUrl'] as String?,
    (json['beaconIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$TourToJson(Tour instance) => <String, dynamic>{
      'name': instance.name,
      'groupId': instance.groupId,
      'mapUrl': instance.mapUrl,
      'feedbackUrl': instance.feedbackUrl,
      'introVideoUrl': instance.introVideoUrl,
      'beaconInfoIds': instance.beaconInfoIds,
      'beaconIds': instance.beaconIds,
    };
