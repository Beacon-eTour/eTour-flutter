// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localizedString.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalizedString _$LocalizedStringFromJson(Map<String, dynamic> json) {
  return LocalizedString(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$LocalizedStringToJson(LocalizedString instance) =>
    <String, dynamic>{
      'value': instance.value,
    };
