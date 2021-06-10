import 'package:json_annotation/json_annotation.dart';

part 'localizedString.g.dart';

@JsonSerializable()
class LocalizedString {
  final Map<String, String>? value;
  LocalizedString(this.value);

  factory LocalizedString.fromJson(Map<String, dynamic> json) =>
      _$LocalizedStringFromJson(json);
}
