// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tours _$ToursFromJson(Map<String, dynamic> json) {
  return Tours(
    (json['results'] as List<dynamic>?)
        ?.map((e) => Tour.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ToursToJson(Tours instance) => <String, dynamic>{
      'results': instance.results,
    };
