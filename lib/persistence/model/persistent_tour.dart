import 'package:floor/floor.dart';

@Entity(tableName: 'PersistentTour')
class PersistentTour {
  @primaryKey
  final String? id;
  final String? mapUrl;
  final String? beaconInfoIds;
  final String? beaconIds;
  final String? feedbackUrl;
  final String? introVideoUrl;

  PersistentTour(this.id, this.mapUrl, this.beaconInfoIds, this.beaconIds,
      this.feedbackUrl, this.introVideoUrl);
}
