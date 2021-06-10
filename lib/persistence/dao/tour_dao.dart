import 'package:eTour_flutter/persistence/model/persistent_tour.dart';
import 'package:floor/floor.dart';

@dao
abstract class TourDao {
  /*
  * Get all [tours]s in descending order by phone number
  */
  @Query('SELECT * FROM PersistentTour')
  Future<List<PersistentTour>> getTours();

  /*
  * Add a [tour] if it doesn't exist in the database
  */
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<int> insertTour(PersistentTour tour);

  /*
  * Update [tour]
  */
  @update
  Future<void> updateTour(PersistentTour tour);

  /*
  * Update or insert the [beaconInfo]
  */
  @transaction
  Future<void> upsert(PersistentTour tour) async {
    final insertId = await insertTour(tour);
    if (insertId == null) {
      await updateTour(tour);
    }
  }

  @delete
  Future<void> deleteTour(PersistentTour agent);

  /*
  * Get tour by id
  */
  @Query('SELECT * FROM PersistentTour WHERE id = :id')
  Future<PersistentTour?> getTour(String id);

  /*
  * Delete tour by [id]
  */
  @Query('DELETE FROM PersistentTour WHERE id = :id')
  Future<void> deleteById(String id);

  /*
  * Truncate PersistentBeaconInfo table
  */
  @Query('DELETE FROM PersistentTour')
  Future<void> truncate();
}
