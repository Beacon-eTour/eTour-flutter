// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'etour_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BeaconInfoDao? _beaconInfoDaoInstance;

  TourDao? _tourDaoInstance;

  LocalizedStringDao? _localizedStringDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PersistentBeaconInfo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `beaconId` TEXT, `title` TEXT, `shortDescription` TEXT, `conditions` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PersistentTour` (`id` TEXT, `mapUrl` TEXT, `beaconInfoIds` TEXT, `beaconIds` TEXT, `feedbackUrl` TEXT, `introVideoUrl` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PersistentLocalizedString` (`id` TEXT, `value` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BeaconInfoDao get beaconInfoDao {
    return _beaconInfoDaoInstance ??= _$BeaconInfoDao(database, changeListener);
  }

  @override
  TourDao get tourDao {
    return _tourDaoInstance ??= _$TourDao(database, changeListener);
  }

  @override
  LocalizedStringDao get localizedStringDao {
    return _localizedStringDaoInstance ??=
        _$LocalizedStringDao(database, changeListener);
  }
}

class _$BeaconInfoDao extends BeaconInfoDao {
  _$BeaconInfoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _persistentBeaconInfoInsertionAdapter = InsertionAdapter(
            database,
            'PersistentBeaconInfo',
            (PersistentBeaconInfo item) => <String, Object?>{
                  'id': item.id,
                  'beaconId': item.beaconId,
                  'title': item.title,
                  'shortDescription': item.shortDescription,
                  'conditions': item.conditions
                }),
        _persistentBeaconInfoUpdateAdapter = UpdateAdapter(
            database,
            'PersistentBeaconInfo',
            ['id'],
            (PersistentBeaconInfo item) => <String, Object?>{
                  'id': item.id,
                  'beaconId': item.beaconId,
                  'title': item.title,
                  'shortDescription': item.shortDescription,
                  'conditions': item.conditions
                }),
        _persistentBeaconInfoDeletionAdapter = DeletionAdapter(
            database,
            'PersistentBeaconInfo',
            ['id'],
            (PersistentBeaconInfo item) => <String, Object?>{
                  'id': item.id,
                  'beaconId': item.beaconId,
                  'title': item.title,
                  'shortDescription': item.shortDescription,
                  'conditions': item.conditions
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PersistentBeaconInfo>
      _persistentBeaconInfoInsertionAdapter;

  final UpdateAdapter<PersistentBeaconInfo> _persistentBeaconInfoUpdateAdapter;

  final DeletionAdapter<PersistentBeaconInfo>
      _persistentBeaconInfoDeletionAdapter;

  @override
  Future<List<PersistentBeaconInfo>> getBeaconInfos() async {
    return _queryAdapter.queryList('SELECT * FROM PersistentBeaconInfo',
        mapper: (Map<String, Object?> row) => PersistentBeaconInfo(
            row['id'] as int?,
            row['title'] as String?,
            row['beaconId'] as String?,
            row['shortDescription'] as String?,
            row['conditions'] as String?));
  }

  @override
  Future<List<PersistentBeaconInfo>> getBeaconInfosById(String id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PersistentBeaconInfo WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PersistentBeaconInfo(
            row['id'] as int?,
            row['title'] as String?,
            row['beaconId'] as String?,
            row['shortDescription'] as String?,
            row['conditions'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM PersistentBeaconInfo WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> truncate() async {
    await _queryAdapter.queryNoReturn('DELETE FROM PersistentBeaconInfo');
  }

  @override
  Future<int> insertBeaconInfo(PersistentBeaconInfo beaconInfo) {
    return _persistentBeaconInfoInsertionAdapter.insertAndReturnId(
        beaconInfo, OnConflictStrategy.ignore);
  }

  @override
  Future<void> updateBeaconInfo(PersistentBeaconInfo beaconInfo) async {
    await _persistentBeaconInfoUpdateAdapter.update(
        beaconInfo, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBeaconInfo(PersistentBeaconInfo beaconInfo) async {
    await _persistentBeaconInfoDeletionAdapter.delete(beaconInfo);
  }

  @override
  Future<void> upsert(PersistentBeaconInfo beaconInfo) async {
    if (database is sqflite.Transaction) {
      await super.upsert(beaconInfo);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.beaconInfoDao.upsert(beaconInfo);
      });
    }
  }
}

class _$TourDao extends TourDao {
  _$TourDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _persistentTourInsertionAdapter = InsertionAdapter(
            database,
            'PersistentTour',
            (PersistentTour item) => <String, Object?>{
                  'id': item.id,
                  'mapUrl': item.mapUrl,
                  'beaconInfoIds': item.beaconInfoIds,
                  'beaconIds': item.beaconIds,
                  'feedbackUrl': item.feedbackUrl,
                  'introVideoUrl': item.introVideoUrl
                }),
        _persistentTourUpdateAdapter = UpdateAdapter(
            database,
            'PersistentTour',
            ['id'],
            (PersistentTour item) => <String, Object?>{
                  'id': item.id,
                  'mapUrl': item.mapUrl,
                  'beaconInfoIds': item.beaconInfoIds,
                  'beaconIds': item.beaconIds,
                  'feedbackUrl': item.feedbackUrl,
                  'introVideoUrl': item.introVideoUrl
                }),
        _persistentTourDeletionAdapter = DeletionAdapter(
            database,
            'PersistentTour',
            ['id'],
            (PersistentTour item) => <String, Object?>{
                  'id': item.id,
                  'mapUrl': item.mapUrl,
                  'beaconInfoIds': item.beaconInfoIds,
                  'beaconIds': item.beaconIds,
                  'feedbackUrl': item.feedbackUrl,
                  'introVideoUrl': item.introVideoUrl
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PersistentTour> _persistentTourInsertionAdapter;

  final UpdateAdapter<PersistentTour> _persistentTourUpdateAdapter;

  final DeletionAdapter<PersistentTour> _persistentTourDeletionAdapter;

  @override
  Future<List<PersistentTour>> getTours() async {
    return _queryAdapter.queryList('SELECT * FROM PersistentTour',
        mapper: (Map<String, Object?> row) => PersistentTour(
            row['id'] as String?,
            row['mapUrl'] as String?,
            row['beaconInfoIds'] as String?,
            row['beaconIds'] as String?,
            row['feedbackUrl'] as String?,
            row['introVideoUrl'] as String?));
  }

  @override
  Future<PersistentTour?> getTour(String id) async {
    return _queryAdapter.query('SELECT * FROM PersistentTour WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PersistentTour(
            row['id'] as String?,
            row['mapUrl'] as String?,
            row['beaconInfoIds'] as String?,
            row['beaconIds'] as String?,
            row['feedbackUrl'] as String?,
            row['introVideoUrl'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM PersistentTour WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> truncate() async {
    await _queryAdapter.queryNoReturn('DELETE FROM PersistentTour');
  }

  @override
  Future<int> insertTour(PersistentTour tour) {
    return _persistentTourInsertionAdapter.insertAndReturnId(
        tour, OnConflictStrategy.ignore);
  }

  @override
  Future<void> updateTour(PersistentTour tour) async {
    await _persistentTourUpdateAdapter.update(tour, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTour(PersistentTour agent) async {
    await _persistentTourDeletionAdapter.delete(agent);
  }

  @override
  Future<void> upsert(PersistentTour tour) async {
    if (database is sqflite.Transaction) {
      await super.upsert(tour);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.tourDao.upsert(tour);
      });
    }
  }
}

class _$LocalizedStringDao extends LocalizedStringDao {
  _$LocalizedStringDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _persistentLocalizedStringInsertionAdapter = InsertionAdapter(
            database,
            'PersistentLocalizedString',
            (PersistentLocalizedString item) =>
                <String, Object?>{'id': item.id, 'value': item.value}),
        _persistentLocalizedStringUpdateAdapter = UpdateAdapter(
            database,
            'PersistentLocalizedString',
            ['id'],
            (PersistentLocalizedString item) =>
                <String, Object?>{'id': item.id, 'value': item.value}),
        _persistentLocalizedStringDeletionAdapter = DeletionAdapter(
            database,
            'PersistentLocalizedString',
            ['id'],
            (PersistentLocalizedString item) =>
                <String, Object?>{'id': item.id, 'value': item.value});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PersistentLocalizedString>
      _persistentLocalizedStringInsertionAdapter;

  final UpdateAdapter<PersistentLocalizedString>
      _persistentLocalizedStringUpdateAdapter;

  final DeletionAdapter<PersistentLocalizedString>
      _persistentLocalizedStringDeletionAdapter;

  @override
  Future<List<PersistentLocalizedString>> getLocalizedStrings() async {
    return _queryAdapter.queryList('SELECT * FROM PersistentLocalizedString',
        mapper: (Map<String, Object?> row) => PersistentLocalizedString(
            row['id'] as String?, row['value'] as String?));
  }

  @override
  Future<PersistentLocalizedString?> getLocalizedStringById(String id) async {
    return _queryAdapter.query(
        'SELECT * FROM PersistentLocalizedString WHERE id = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => PersistentLocalizedString(
            row['id'] as String?, row['value'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM PersistentLocalizedString WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> truncate() async {
    await _queryAdapter.queryNoReturn('DELETE FROM PersistentLocalizedString');
  }

  @override
  Future<int> insertLocalizedString(PersistentLocalizedString localizedString) {
    return _persistentLocalizedStringInsertionAdapter.insertAndReturnId(
        localizedString, OnConflictStrategy.ignore);
  }

  @override
  Future<void> updateLocalizedString(
      PersistentLocalizedString localizedString) async {
    await _persistentLocalizedStringUpdateAdapter.update(
        localizedString, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteLocalizedString(
      PersistentLocalizedString localizedString) async {
    await _persistentLocalizedStringDeletionAdapter.delete(localizedString);
  }

  @override
  Future<void> upsert(PersistentLocalizedString localizedString) async {
    if (database is sqflite.Transaction) {
      await super.upsert(localizedString);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.localizedStringDao.upsert(localizedString);
      });
    }
  }
}
