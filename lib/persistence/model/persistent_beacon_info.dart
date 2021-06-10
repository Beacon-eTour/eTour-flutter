import 'package:floor/floor.dart';

@Entity(tableName: 'PersistentBeaconInfo')
class PersistentBeaconInfo {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? beaconId;
  final String? title;
  final String? shortDescription;
  final String? conditions;

  PersistentBeaconInfo(this.id, this.title, this.beaconId,
      this.shortDescription, this.conditions);
}
