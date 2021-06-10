import 'package:eTour_flutter/persistence/model/persistent_beacon_info.dart';
import 'package:floor/floor.dart';

@dao
abstract class BeaconInfoDao {
  /*
  * Get all [beaconInfo]s
  */
  @Query('SELECT * FROM PersistentBeaconInfo')
  Future<List<PersistentBeaconInfo>> getBeaconInfos();

  /*
  * Get list of beaconInfos by id
  */
  @Query('SELECT * FROM PersistentBeaconInfo WHERE id = :id')
  Future<List<PersistentBeaconInfo>> getBeaconInfosById(String id);

  /*
  * Add a [beaconInfo] if it doesn't exist in the database
  */
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<int> insertBeaconInfo(PersistentBeaconInfo beaconInfo);

  /*
  * Update [beaconInfo]
  */
  @update
  Future<void> updateBeaconInfo(PersistentBeaconInfo beaconInfo);

  /*
  * Update or insert the [beaconInfo]
  */
  @transaction
  Future<void> upsert(PersistentBeaconInfo beaconInfo) async {
    final insertId = await insertBeaconInfo(beaconInfo);
    if (insertId == null) {
      await updateBeaconInfo(beaconInfo);
    }
  }

  @delete
  Future<void> deleteBeaconInfo(PersistentBeaconInfo beaconInfo);

  /*
  * Delete beaconInfo by [id]
  */
  @Query('DELETE FROM PersistentBeaconInfo WHERE id = :id')
  Future<void> deleteById(String id);

  /*
  * Truncate PersistentBeaconInfo table
  */
  @Query('DELETE FROM PersistentBeaconInfo')
  Future<void> truncate();
}
