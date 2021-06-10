import 'package:json_annotation/json_annotation.dart';

part 'tour.g.dart';

@JsonSerializable()
class Tour {
  final Map<String, dynamic>? name;
  final String? groupId;
  final String? mapUrl;
  final String? feedbackUrl;
  final String? introVideoUrl;
  final List<int>? beaconInfoIds;
  final List<String>? beaconIds;

  Tour(this.name, this.groupId, this.mapUrl, this.beaconInfoIds,
      this.feedbackUrl, this.introVideoUrl, this.beaconIds);
  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);
}
