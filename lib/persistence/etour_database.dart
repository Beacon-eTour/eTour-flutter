import 'dart:async';

import 'package:eTour_flutter/persistence/dao/beacon_info_dao.dart';
import 'package:eTour_flutter/persistence/dao/persistent_lozalized_string_dao.dart';
import 'package:eTour_flutter/persistence/dao/tour_dao.dart';
import 'package:eTour_flutter/persistence/model/persistent_beacon_info.dart';
import 'package:eTour_flutter/persistence/model/persistent_localized_string.dart';
import 'package:eTour_flutter/persistence/model/persistent_tour.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'etour_database.g.dart';

@Database(
    version: 1,
    entities: [PersistentBeaconInfo, PersistentTour, PersistentLocalizedString])
abstract class AppDatabase extends FloorDatabase {
  BeaconInfoDao get beaconInfoDao;
  TourDao get tourDao;
  LocalizedStringDao get localizedStringDao;
}
