import 'package:eTour_flutter/persistence/dao/beacon_info_dao.dart';
import 'package:eTour_flutter/persistence/dao/persistent_lozalized_string_dao.dart';
import 'package:eTour_flutter/persistence/dao/tour_dao.dart';
import 'package:eTour_flutter/persistence/etour_database.dart';

class DatabaseHelper {
  static Future<AppDatabase> getVakioDatabase() async {
    return await $FloorAppDatabase.databaseBuilder('etourdatabase.db').build();
  }

  static Future<BeaconInfoDao> getBeaconInfoDao() async {
    final database = await getVakioDatabase();
    return database.beaconInfoDao;
  }

  static Future<TourDao> getTourDao() async {
    final database = await getVakioDatabase();
    return database.tourDao;
  }

  static Future<LocalizedStringDao> getLocalizationDao() async {
    final database = await getVakioDatabase();
    return database.localizedStringDao;
  }

  static Future<void> clearDatabase() async {
    final database = await getVakioDatabase();
    final beaconInfoDao = database.beaconInfoDao;

    await beaconInfoDao.truncate();
  }
}
