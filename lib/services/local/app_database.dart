// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:hoco/core/constants/database_constants.dart';
import 'package:hoco/models/relay.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../models/app_settings.dart';
import '../../models/device.dart';
import 'DAOs/app_settings_dao.dart';
import 'DAOs/device_dao.dart';
import 'DAOs/relay_dao.dart';

part 'app_database.g.dart';

/// Floor database class
@Database(version: kDatabaseVersion, entities: [AppSettings, Device, Relay])
abstract class AppDatabase extends FloorDatabase {
  AppSettingsDAO get appSettingsDao;
  DeviceDAO get deviceDao;
  RelayDAO get relayDao;
}
