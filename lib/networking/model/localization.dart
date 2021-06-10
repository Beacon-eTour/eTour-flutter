import 'package:json_annotation/json_annotation.dart';

part 'localization.g.dart';

@JsonSerializable()
class Localization {
  final Map<String, dynamic>? results;

  Localization(this.results);
  factory Localization.fromJson(Map<String, dynamic> json) =>
      _$LocalizationFromJson(json);
}
