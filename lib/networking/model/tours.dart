import 'package:eTour_flutter/networking/model/tour.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tours.g.dart';

@JsonSerializable()
class Tours {
  final List<Tour>? results;

  Tours(this.results);
  factory Tours.fromJson(Map<String, dynamic> json) => _$ToursFromJson(json);
}
