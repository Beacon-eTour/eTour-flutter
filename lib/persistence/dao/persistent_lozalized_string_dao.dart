import 'package:eTour_flutter/persistence/model/persistent_localized_string.dart';
import 'package:floor/floor.dart';

@dao
abstract class LocalizedStringDao {
  /*
  * Get all [LocalizedString]s
  */
  @Query('SELECT * FROM PersistentLocalizedString')
  Future<List<PersistentLocalizedString>> getLocalizedStrings();

  /*
  * Get LocalizedString by id and key
  */
  @Query('SELECT * FROM PersistentLocalizedString WHERE id = :id LIMIT 1')
  Future<PersistentLocalizedString?> getLocalizedStringById(String id);

  /*
  * Add a [LocalizedString] if it doesn't exist in the database
  */
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<int> insertLocalizedString(PersistentLocalizedString localizedString);

  /*
  * Update [LocalizedString]
  */
  @update
  Future<void> updateLocalizedString(PersistentLocalizedString localizedString);

  /*
  * Update or insert the [LocalizedString]
  */
  @transaction
  Future<void> upsert(PersistentLocalizedString localizedString) async {
    final insertId = await insertLocalizedString(localizedString);
    if (insertId == null) {
      await updateLocalizedString(localizedString);
    }
  }

  @delete
  Future<void> deleteLocalizedString(PersistentLocalizedString localizedString);

  /*
  * Delete LocalizedString by [id]
  */
  @Query('DELETE FROM PersistentLocalizedString WHERE id = :id')
  Future<void> deleteById(String id);

  /*
  * Truncate PersistentLocalizedString table
  */
  @Query('DELETE FROM PersistentLocalizedString')
  Future<void> truncate();
}
