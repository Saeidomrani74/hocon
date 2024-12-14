// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
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

  AppSettingsDAO? _appSettingsDaoInstance;

  DeviceDAO? _deviceDaoInstance;

  RelayDAO? _relayDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `app_settings` (`id` INTEGER NOT NULL, `appPassword` TEXT NOT NULL, `appVersion` TEXT NOT NULL, `showPassPage` INTEGER NOT NULL, `selectedDeviceIndex` INTEGER NOT NULL, `selectedThemePalette` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `device` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `deviceName` TEXT NOT NULL, `devicePassword` TEXT NOT NULL, `devicePhone` TEXT NOT NULL, `deviceModel` TEXT NOT NULL, `deviceState` TEXT NOT NULL, `isManager` INTEGER NOT NULL, `alarmTime` TEXT NOT NULL, `remoteAmount` INTEGER NOT NULL, `simChargeAmount` INTEGER NOT NULL, `antennaAmount` INTEGER NOT NULL, `batteryAmount` INTEGER NOT NULL, `cityPowerState` INTEGER NOT NULL, `gsmState` INTEGER NOT NULL, `speakerState` INTEGER NOT NULL, `networkState` INTEGER NOT NULL, `capsulMax` INTEGER NOT NULL, `capsulMin` INTEGER NOT NULL, `totalContactsAmount` INTEGER NOT NULL, `spyAmount` INTEGER NOT NULL, `chargePeriodictReport` INTEGER NOT NULL, `batteryPeriodictReport` INTEGER NOT NULL, `callOrder` INTEGER NOT NULL, `operator` TEXT NOT NULL, `deviceLang` TEXT NOT NULL, `deviceSimLang` TEXT NOT NULL, `silentOnSiren` INTEGER NOT NULL, `relayOnDingDong` INTEGER NOT NULL, `callOnPowerLoss` INTEGER NOT NULL, `manageWithContacts` INTEGER NOT NULL, `gsmStateVisibility` INTEGER NOT NULL, `remoteAmountVisibility` INTEGER NOT NULL, `antennaAmountVisibility` INTEGER NOT NULL, `contactsAmountVisibility` INTEGER NOT NULL, `networkStateVisibility` INTEGER NOT NULL, `batteryShapeVisibility` INTEGER NOT NULL, `zone1Visibility` INTEGER NOT NULL, `zone2Visibility` INTEGER NOT NULL, `zone3Visibility` INTEGER NOT NULL, `zone4Visibility` INTEGER NOT NULL, `zone5Visibility` INTEGER NOT NULL, `relay1Visibility` INTEGER NOT NULL, `relay2Visibility` INTEGER NOT NULL, `relay1SectionVisibility` INTEGER NOT NULL, `relay2SectionVisibility` INTEGER NOT NULL, `semiActiveVisibility` INTEGER NOT NULL, `silentVisibility` INTEGER NOT NULL, `spyVisibility` INTEGER NOT NULL, `relay1ActiveBtnVisibility` INTEGER NOT NULL, `relay2ActiveBtnVisibility` INTEGER NOT NULL, `relay1TriggerBtnVisibility` INTEGER NOT NULL, `relay2TriggerBtnVisibility` INTEGER NOT NULL, `zone1Name` TEXT NOT NULL, `zone1Condition` TEXT NOT NULL, `zone1State` INTEGER NOT NULL, `zone2Name` TEXT NOT NULL, `zone2Condition` TEXT NOT NULL, `zone2State` INTEGER NOT NULL, `zone3Name` TEXT NOT NULL, `zone3Condition` TEXT NOT NULL, `zone3State` INTEGER NOT NULL, `zone4Name` TEXT NOT NULL, `zone4Condition` TEXT NOT NULL, `zone4State` INTEGER NOT NULL, `zone5Name` TEXT NOT NULL, `zone5Condition` TEXT NOT NULL, `zone5State` INTEGER NOT NULL, `contact1Name` TEXT NOT NULL, `contact1Phone` TEXT NOT NULL, `contact1SMS` INTEGER NOT NULL, `contact1Call` INTEGER NOT NULL, `contact1Power` INTEGER NOT NULL, `contact1Speaker` INTEGER NOT NULL, `contact1SecretReport` INTEGER NOT NULL, `contact1Manager` INTEGER NOT NULL, `contact2Name` TEXT NOT NULL, `contact2Phone` TEXT NOT NULL, `contact2SMS` INTEGER NOT NULL, `contact2Call` INTEGER NOT NULL, `contact2Power` INTEGER NOT NULL, `contact2Speaker` INTEGER NOT NULL, `contact2SecretReport` INTEGER NOT NULL, `contact2Manager` INTEGER NOT NULL, `contact3Name` TEXT NOT NULL, `contact3Phone` TEXT NOT NULL, `contact3SMS` INTEGER NOT NULL, `contact3Call` INTEGER NOT NULL, `contact3Power` INTEGER NOT NULL, `contact3Speaker` INTEGER NOT NULL, `contact3SecretReport` INTEGER NOT NULL, `contact3Manager` INTEGER NOT NULL, `contact4Name` TEXT NOT NULL, `contact4Phone` TEXT NOT NULL, `contact4SMS` INTEGER NOT NULL, `contact4Call` INTEGER NOT NULL, `contact4Power` INTEGER NOT NULL, `contact4Speaker` INTEGER NOT NULL, `contact4SecretReport` INTEGER NOT NULL, `contact4Manager` INTEGER NOT NULL, `contact5Name` TEXT NOT NULL, `contact5Phone` TEXT NOT NULL, `contact5SMS` INTEGER NOT NULL, `contact5Call` INTEGER NOT NULL, `contact5Power` INTEGER NOT NULL, `contact5Speaker` INTEGER NOT NULL, `contact5SecretReport` INTEGER NOT NULL, `contact5Manager` INTEGER NOT NULL, `contact6Name` TEXT NOT NULL, `contact6Phone` TEXT NOT NULL, `contact6SMS` INTEGER NOT NULL, `contact6Call` INTEGER NOT NULL, `contact6Power` INTEGER NOT NULL, `contact6Speaker` INTEGER NOT NULL, `contact6SecretReport` INTEGER NOT NULL, `contact6Manager` INTEGER NOT NULL, `contact7Name` TEXT NOT NULL, `contact7Phone` TEXT NOT NULL, `contact7SMS` INTEGER NOT NULL, `contact7Call` INTEGER NOT NULL, `contact7Power` INTEGER NOT NULL, `contact7Speaker` INTEGER NOT NULL, `contact7SecretReport` INTEGER NOT NULL, `contact7Manager` INTEGER NOT NULL, `contact8Name` TEXT NOT NULL, `contact8Phone` TEXT NOT NULL, `contact8SMS` INTEGER NOT NULL, `contact8Call` INTEGER NOT NULL, `contact8Power` INTEGER NOT NULL, `contact8Speaker` INTEGER NOT NULL, `contact8SecretReport` INTEGER NOT NULL, `contact8Manager` INTEGER NOT NULL, `contact9Name` TEXT NOT NULL, `contact9Phone` TEXT NOT NULL, `contact9SMS` INTEGER NOT NULL, `contact9Call` INTEGER NOT NULL, `contact9Power` INTEGER NOT NULL, `contact9Speaker` INTEGER NOT NULL, `contact9SecretReport` INTEGER NOT NULL, `contact9Manager` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `relay` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `device_id` INTEGER NOT NULL, `relayName` TEXT NOT NULL, `relayTriggerTime` TEXT NOT NULL, `relayState` INTEGER NOT NULL, FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AppSettingsDAO get appSettingsDao {
    return _appSettingsDaoInstance ??=
        _$AppSettingsDAO(database, changeListener);
  }

  @override
  DeviceDAO get deviceDao {
    return _deviceDaoInstance ??= _$DeviceDAO(database, changeListener);
  }

  @override
  RelayDAO get relayDao {
    return _relayDaoInstance ??= _$RelayDAO(database, changeListener);
  }
}

class _$AppSettingsDAO extends AppSettingsDAO {
  _$AppSettingsDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _appSettingsInsertionAdapter = InsertionAdapter(
            database,
            'app_settings',
            (AppSettings item) => <String, Object?>{
                  'id': item.id,
                  'appPassword': item.appPassword,
                  'appVersion': item.appVersion,
                  'showPassPage': item.showPassPage ? 1 : 0,
                  'selectedDeviceIndex': item.selectedDeviceIndex,
                  'selectedThemePalette': item.selectedThemePalette
                }),
        _appSettingsUpdateAdapter = UpdateAdapter(
            database,
            'app_settings',
            ['id'],
            (AppSettings item) => <String, Object?>{
                  'id': item.id,
                  'appPassword': item.appPassword,
                  'appVersion': item.appVersion,
                  'showPassPage': item.showPassPage ? 1 : 0,
                  'selectedDeviceIndex': item.selectedDeviceIndex,
                  'selectedThemePalette': item.selectedThemePalette
                }),
        _appSettingsDeletionAdapter = DeletionAdapter(
            database,
            'app_settings',
            ['id'],
            (AppSettings item) => <String, Object?>{
                  'id': item.id,
                  'appPassword': item.appPassword,
                  'appVersion': item.appVersion,
                  'showPassPage': item.showPassPage ? 1 : 0,
                  'selectedDeviceIndex': item.selectedDeviceIndex,
                  'selectedThemePalette': item.selectedThemePalette
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AppSettings> _appSettingsInsertionAdapter;

  final UpdateAdapter<AppSettings> _appSettingsUpdateAdapter;

  final DeletionAdapter<AppSettings> _appSettingsDeletionAdapter;

  @override
  Future<AppSettings?> getAppSettings() async {
    return _queryAdapter.query('SELECT * FROM app_settings WHERE id = 1',
        mapper: (Map<String, Object?> row) => AppSettings(
            id: row['id'] as int,
            appPassword: row['appPassword'] as String,
            appVersion: row['appVersion'] as String,
            showPassPage: (row['showPassPage'] as int) != 0,
            selectedDeviceIndex: row['selectedDeviceIndex'] as int,
            selectedThemePalette: row['selectedThemePalette'] as int));
  }

  @override
  Future<void> insertAppSettings(AppSettings appSettings) async {
    await _appSettingsInsertionAdapter.insert(
        appSettings, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateAppSettings(AppSettings appSettings) async {
    await _appSettingsUpdateAdapter.update(
        appSettings, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteAppSettings(AppSettings appSettings) async {
    await _appSettingsDeletionAdapter.delete(appSettings);
  }
}

class _$DeviceDAO extends DeviceDAO {
  _$DeviceDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _deviceInsertionAdapter = InsertionAdapter(
            database,
            'device',
            (Device item) => <String, Object?>{
                  'id': item.id,
                  'deviceName': item.deviceName,
                  'devicePassword': item.devicePassword,
                  'devicePhone': item.devicePhone,
                  'deviceModel': item.deviceModel,
                  'deviceState': item.deviceState,
                  'isManager': item.isManager ? 1 : 0,
                  'alarmTime': item.alarmTime,
                  'remoteAmount': item.remoteAmount,
                  'simChargeAmount': item.simChargeAmount,
                  'antennaAmount': item.antennaAmount,
                  'batteryAmount': item.batteryAmount,
                  'cityPowerState': item.cityPowerState ? 1 : 0,
                  'gsmState': item.gsmState ? 1 : 0,
                  'speakerState': item.speakerState ? 1 : 0,
                  'networkState': item.networkState ? 1 : 0,
                  'capsulMax': item.capsulMax,
                  'capsulMin': item.capsulMin,
                  'totalContactsAmount': item.totalContactsAmount,
                  'spyAmount': item.spyAmount,
                  'chargePeriodictReport': item.chargePeriodictReport,
                  'batteryPeriodictReport': item.batteryPeriodictReport,
                  'callOrder': item.callOrder,
                  'operator': item.operator,
                  'deviceLang': item.deviceLang,
                  'deviceSimLang': item.deviceSimLang,
                  'silentOnSiren': item.silentOnSiren ? 1 : 0,
                  'relayOnDingDong': item.relayOnDingDong ? 1 : 0,
                  'callOnPowerLoss': item.callOnPowerLoss ? 1 : 0,
                  'manageWithContacts': item.manageWithContacts ? 1 : 0,
                  'gsmStateVisibility': item.gsmStateVisibility ? 1 : 0,
                  'remoteAmountVisibility': item.remoteAmountVisibility ? 1 : 0,
                  'antennaAmountVisibility':
                      item.antennaAmountVisibility ? 1 : 0,
                  'contactsAmountVisibility':
                      item.contactsAmountVisibility ? 1 : 0,
                  'networkStateVisibility': item.networkStateVisibility ? 1 : 0,
                  'batteryShapeVisibility': item.batteryShapeVisibility ? 1 : 0,
                  'zone1Visibility': item.zone1Visibility ? 1 : 0,
                  'zone2Visibility': item.zone2Visibility ? 1 : 0,
                  'zone3Visibility': item.zone3Visibility ? 1 : 0,
                  'zone4Visibility': item.zone4Visibility ? 1 : 0,
                  'zone5Visibility': item.zone5Visibility ? 1 : 0,
                  'relay1Visibility': item.relay1Visibility ? 1 : 0,
                  'relay2Visibility': item.relay2Visibility ? 1 : 0,
                  'relay1SectionVisibility':
                      item.relay1SectionVisibility ? 1 : 0,
                  'relay2SectionVisibility':
                      item.relay2SectionVisibility ? 1 : 0,
                  'semiActiveVisibility': item.semiActiveVisibility ? 1 : 0,
                  'silentVisibility': item.silentVisibility ? 1 : 0,
                  'spyVisibility': item.spyVisibility ? 1 : 0,
                  'relay1ActiveBtnVisibility':
                      item.relay1ActiveBtnVisibility ? 1 : 0,
                  'relay2ActiveBtnVisibility':
                      item.relay2ActiveBtnVisibility ? 1 : 0,
                  'relay1TriggerBtnVisibility':
                      item.relay1TriggerBtnVisibility ? 1 : 0,
                  'relay2TriggerBtnVisibility':
                      item.relay2TriggerBtnVisibility ? 1 : 0,
                  'zone1Name': item.zone1Name,
                  'zone1Condition': item.zone1Condition,
                  'zone1State': item.zone1State ? 1 : 0,
                  'zone2Name': item.zone2Name,
                  'zone2Condition': item.zone2Condition,
                  'zone2State': item.zone2State ? 1 : 0,
                  'zone3Name': item.zone3Name,
                  'zone3Condition': item.zone3Condition,
                  'zone3State': item.zone3State ? 1 : 0,
                  'zone4Name': item.zone4Name,
                  'zone4Condition': item.zone4Condition,
                  'zone4State': item.zone4State ? 1 : 0,
                  'zone5Name': item.zone5Name,
                  'zone5Condition': item.zone5Condition,
                  'zone5State': item.zone5State ? 1 : 0,
                  'contact1Name': item.contact1Name,
                  'contact1Phone': item.contact1Phone,
                  'contact1SMS': item.contact1SMS ? 1 : 0,
                  'contact1Call': item.contact1Call ? 1 : 0,
                  'contact1Power': item.contact1Power ? 1 : 0,
                  'contact1Speaker': item.contact1Speaker ? 1 : 0,
                  'contact1SecretReport': item.contact1SecretReport ? 1 : 0,
                  'contact1Manager': item.contact1Manager ? 1 : 0,
                  'contact2Name': item.contact2Name,
                  'contact2Phone': item.contact2Phone,
                  'contact2SMS': item.contact2SMS ? 1 : 0,
                  'contact2Call': item.contact2Call ? 1 : 0,
                  'contact2Power': item.contact2Power ? 1 : 0,
                  'contact2Speaker': item.contact2Speaker ? 1 : 0,
                  'contact2SecretReport': item.contact2SecretReport ? 1 : 0,
                  'contact2Manager': item.contact2Manager ? 1 : 0,
                  'contact3Name': item.contact3Name,
                  'contact3Phone': item.contact3Phone,
                  'contact3SMS': item.contact3SMS ? 1 : 0,
                  'contact3Call': item.contact3Call ? 1 : 0,
                  'contact3Power': item.contact3Power ? 1 : 0,
                  'contact3Speaker': item.contact3Speaker ? 1 : 0,
                  'contact3SecretReport': item.contact3SecretReport ? 1 : 0,
                  'contact3Manager': item.contact3Manager ? 1 : 0,
                  'contact4Name': item.contact4Name,
                  'contact4Phone': item.contact4Phone,
                  'contact4SMS': item.contact4SMS ? 1 : 0,
                  'contact4Call': item.contact4Call ? 1 : 0,
                  'contact4Power': item.contact4Power ? 1 : 0,
                  'contact4Speaker': item.contact4Speaker ? 1 : 0,
                  'contact4SecretReport': item.contact4SecretReport ? 1 : 0,
                  'contact4Manager': item.contact4Manager ? 1 : 0,
                  'contact5Name': item.contact5Name,
                  'contact5Phone': item.contact5Phone,
                  'contact5SMS': item.contact5SMS ? 1 : 0,
                  'contact5Call': item.contact5Call ? 1 : 0,
                  'contact5Power': item.contact5Power ? 1 : 0,
                  'contact5Speaker': item.contact5Speaker ? 1 : 0,
                  'contact5SecretReport': item.contact5SecretReport ? 1 : 0,
                  'contact5Manager': item.contact5Manager ? 1 : 0,
                  'contact6Name': item.contact6Name,
                  'contact6Phone': item.contact6Phone,
                  'contact6SMS': item.contact6SMS ? 1 : 0,
                  'contact6Call': item.contact6Call ? 1 : 0,
                  'contact6Power': item.contact6Power ? 1 : 0,
                  'contact6Speaker': item.contact6Speaker ? 1 : 0,
                  'contact6SecretReport': item.contact6SecretReport ? 1 : 0,
                  'contact6Manager': item.contact6Manager ? 1 : 0,
                  'contact7Name': item.contact7Name,
                  'contact7Phone': item.contact7Phone,
                  'contact7SMS': item.contact7SMS ? 1 : 0,
                  'contact7Call': item.contact7Call ? 1 : 0,
                  'contact7Power': item.contact7Power ? 1 : 0,
                  'contact7Speaker': item.contact7Speaker ? 1 : 0,
                  'contact7SecretReport': item.contact7SecretReport ? 1 : 0,
                  'contact7Manager': item.contact7Manager ? 1 : 0,
                  'contact8Name': item.contact8Name,
                  'contact8Phone': item.contact8Phone,
                  'contact8SMS': item.contact8SMS ? 1 : 0,
                  'contact8Call': item.contact8Call ? 1 : 0,
                  'contact8Power': item.contact8Power ? 1 : 0,
                  'contact8Speaker': item.contact8Speaker ? 1 : 0,
                  'contact8SecretReport': item.contact8SecretReport ? 1 : 0,
                  'contact8Manager': item.contact8Manager ? 1 : 0,
                  'contact9Name': item.contact9Name,
                  'contact9Phone': item.contact9Phone,
                  'contact9SMS': item.contact9SMS ? 1 : 0,
                  'contact9Call': item.contact9Call ? 1 : 0,
                  'contact9Power': item.contact9Power ? 1 : 0,
                  'contact9Speaker': item.contact9Speaker ? 1 : 0,
                  'contact9SecretReport': item.contact9SecretReport ? 1 : 0,
                  'contact9Manager': item.contact9Manager ? 1 : 0
                }),
        _deviceUpdateAdapter = UpdateAdapter(
            database,
            'device',
            ['id'],
            (Device item) => <String, Object?>{
                  'id': item.id,
                  'deviceName': item.deviceName,
                  'devicePassword': item.devicePassword,
                  'devicePhone': item.devicePhone,
                  'deviceModel': item.deviceModel,
                  'deviceState': item.deviceState,
                  'isManager': item.isManager ? 1 : 0,
                  'alarmTime': item.alarmTime,
                  'remoteAmount': item.remoteAmount,
                  'simChargeAmount': item.simChargeAmount,
                  'antennaAmount': item.antennaAmount,
                  'batteryAmount': item.batteryAmount,
                  'cityPowerState': item.cityPowerState ? 1 : 0,
                  'gsmState': item.gsmState ? 1 : 0,
                  'speakerState': item.speakerState ? 1 : 0,
                  'networkState': item.networkState ? 1 : 0,
                  'capsulMax': item.capsulMax,
                  'capsulMin': item.capsulMin,
                  'totalContactsAmount': item.totalContactsAmount,
                  'spyAmount': item.spyAmount,
                  'chargePeriodictReport': item.chargePeriodictReport,
                  'batteryPeriodictReport': item.batteryPeriodictReport,
                  'callOrder': item.callOrder,
                  'operator': item.operator,
                  'deviceLang': item.deviceLang,
                  'deviceSimLang': item.deviceSimLang,
                  'silentOnSiren': item.silentOnSiren ? 1 : 0,
                  'relayOnDingDong': item.relayOnDingDong ? 1 : 0,
                  'callOnPowerLoss': item.callOnPowerLoss ? 1 : 0,
                  'manageWithContacts': item.manageWithContacts ? 1 : 0,
                  'gsmStateVisibility': item.gsmStateVisibility ? 1 : 0,
                  'remoteAmountVisibility': item.remoteAmountVisibility ? 1 : 0,
                  'antennaAmountVisibility':
                      item.antennaAmountVisibility ? 1 : 0,
                  'contactsAmountVisibility':
                      item.contactsAmountVisibility ? 1 : 0,
                  'networkStateVisibility': item.networkStateVisibility ? 1 : 0,
                  'batteryShapeVisibility': item.batteryShapeVisibility ? 1 : 0,
                  'zone1Visibility': item.zone1Visibility ? 1 : 0,
                  'zone2Visibility': item.zone2Visibility ? 1 : 0,
                  'zone3Visibility': item.zone3Visibility ? 1 : 0,
                  'zone4Visibility': item.zone4Visibility ? 1 : 0,
                  'zone5Visibility': item.zone5Visibility ? 1 : 0,
                  'relay1Visibility': item.relay1Visibility ? 1 : 0,
                  'relay2Visibility': item.relay2Visibility ? 1 : 0,
                  'relay1SectionVisibility':
                      item.relay1SectionVisibility ? 1 : 0,
                  'relay2SectionVisibility':
                      item.relay2SectionVisibility ? 1 : 0,
                  'semiActiveVisibility': item.semiActiveVisibility ? 1 : 0,
                  'silentVisibility': item.silentVisibility ? 1 : 0,
                  'spyVisibility': item.spyVisibility ? 1 : 0,
                  'relay1ActiveBtnVisibility':
                      item.relay1ActiveBtnVisibility ? 1 : 0,
                  'relay2ActiveBtnVisibility':
                      item.relay2ActiveBtnVisibility ? 1 : 0,
                  'relay1TriggerBtnVisibility':
                      item.relay1TriggerBtnVisibility ? 1 : 0,
                  'relay2TriggerBtnVisibility':
                      item.relay2TriggerBtnVisibility ? 1 : 0,
                  'zone1Name': item.zone1Name,
                  'zone1Condition': item.zone1Condition,
                  'zone1State': item.zone1State ? 1 : 0,
                  'zone2Name': item.zone2Name,
                  'zone2Condition': item.zone2Condition,
                  'zone2State': item.zone2State ? 1 : 0,
                  'zone3Name': item.zone3Name,
                  'zone3Condition': item.zone3Condition,
                  'zone3State': item.zone3State ? 1 : 0,
                  'zone4Name': item.zone4Name,
                  'zone4Condition': item.zone4Condition,
                  'zone4State': item.zone4State ? 1 : 0,
                  'zone5Name': item.zone5Name,
                  'zone5Condition': item.zone5Condition,
                  'zone5State': item.zone5State ? 1 : 0,
                  'contact1Name': item.contact1Name,
                  'contact1Phone': item.contact1Phone,
                  'contact1SMS': item.contact1SMS ? 1 : 0,
                  'contact1Call': item.contact1Call ? 1 : 0,
                  'contact1Power': item.contact1Power ? 1 : 0,
                  'contact1Speaker': item.contact1Speaker ? 1 : 0,
                  'contact1SecretReport': item.contact1SecretReport ? 1 : 0,
                  'contact1Manager': item.contact1Manager ? 1 : 0,
                  'contact2Name': item.contact2Name,
                  'contact2Phone': item.contact2Phone,
                  'contact2SMS': item.contact2SMS ? 1 : 0,
                  'contact2Call': item.contact2Call ? 1 : 0,
                  'contact2Power': item.contact2Power ? 1 : 0,
                  'contact2Speaker': item.contact2Speaker ? 1 : 0,
                  'contact2SecretReport': item.contact2SecretReport ? 1 : 0,
                  'contact2Manager': item.contact2Manager ? 1 : 0,
                  'contact3Name': item.contact3Name,
                  'contact3Phone': item.contact3Phone,
                  'contact3SMS': item.contact3SMS ? 1 : 0,
                  'contact3Call': item.contact3Call ? 1 : 0,
                  'contact3Power': item.contact3Power ? 1 : 0,
                  'contact3Speaker': item.contact3Speaker ? 1 : 0,
                  'contact3SecretReport': item.contact3SecretReport ? 1 : 0,
                  'contact3Manager': item.contact3Manager ? 1 : 0,
                  'contact4Name': item.contact4Name,
                  'contact4Phone': item.contact4Phone,
                  'contact4SMS': item.contact4SMS ? 1 : 0,
                  'contact4Call': item.contact4Call ? 1 : 0,
                  'contact4Power': item.contact4Power ? 1 : 0,
                  'contact4Speaker': item.contact4Speaker ? 1 : 0,
                  'contact4SecretReport': item.contact4SecretReport ? 1 : 0,
                  'contact4Manager': item.contact4Manager ? 1 : 0,
                  'contact5Name': item.contact5Name,
                  'contact5Phone': item.contact5Phone,
                  'contact5SMS': item.contact5SMS ? 1 : 0,
                  'contact5Call': item.contact5Call ? 1 : 0,
                  'contact5Power': item.contact5Power ? 1 : 0,
                  'contact5Speaker': item.contact5Speaker ? 1 : 0,
                  'contact5SecretReport': item.contact5SecretReport ? 1 : 0,
                  'contact5Manager': item.contact5Manager ? 1 : 0,
                  'contact6Name': item.contact6Name,
                  'contact6Phone': item.contact6Phone,
                  'contact6SMS': item.contact6SMS ? 1 : 0,
                  'contact6Call': item.contact6Call ? 1 : 0,
                  'contact6Power': item.contact6Power ? 1 : 0,
                  'contact6Speaker': item.contact6Speaker ? 1 : 0,
                  'contact6SecretReport': item.contact6SecretReport ? 1 : 0,
                  'contact6Manager': item.contact6Manager ? 1 : 0,
                  'contact7Name': item.contact7Name,
                  'contact7Phone': item.contact7Phone,
                  'contact7SMS': item.contact7SMS ? 1 : 0,
                  'contact7Call': item.contact7Call ? 1 : 0,
                  'contact7Power': item.contact7Power ? 1 : 0,
                  'contact7Speaker': item.contact7Speaker ? 1 : 0,
                  'contact7SecretReport': item.contact7SecretReport ? 1 : 0,
                  'contact7Manager': item.contact7Manager ? 1 : 0,
                  'contact8Name': item.contact8Name,
                  'contact8Phone': item.contact8Phone,
                  'contact8SMS': item.contact8SMS ? 1 : 0,
                  'contact8Call': item.contact8Call ? 1 : 0,
                  'contact8Power': item.contact8Power ? 1 : 0,
                  'contact8Speaker': item.contact8Speaker ? 1 : 0,
                  'contact8SecretReport': item.contact8SecretReport ? 1 : 0,
                  'contact8Manager': item.contact8Manager ? 1 : 0,
                  'contact9Name': item.contact9Name,
                  'contact9Phone': item.contact9Phone,
                  'contact9SMS': item.contact9SMS ? 1 : 0,
                  'contact9Call': item.contact9Call ? 1 : 0,
                  'contact9Power': item.contact9Power ? 1 : 0,
                  'contact9Speaker': item.contact9Speaker ? 1 : 0,
                  'contact9SecretReport': item.contact9SecretReport ? 1 : 0,
                  'contact9Manager': item.contact9Manager ? 1 : 0
                }),
        _deviceDeletionAdapter = DeletionAdapter(
            database,
            'device',
            ['id'],
            (Device item) => <String, Object?>{
                  'id': item.id,
                  'deviceName': item.deviceName,
                  'devicePassword': item.devicePassword,
                  'devicePhone': item.devicePhone,
                  'deviceModel': item.deviceModel,
                  'deviceState': item.deviceState,
                  'isManager': item.isManager ? 1 : 0,
                  'alarmTime': item.alarmTime,
                  'remoteAmount': item.remoteAmount,
                  'simChargeAmount': item.simChargeAmount,
                  'antennaAmount': item.antennaAmount,
                  'batteryAmount': item.batteryAmount,
                  'cityPowerState': item.cityPowerState ? 1 : 0,
                  'gsmState': item.gsmState ? 1 : 0,
                  'speakerState': item.speakerState ? 1 : 0,
                  'networkState': item.networkState ? 1 : 0,
                  'capsulMax': item.capsulMax,
                  'capsulMin': item.capsulMin,
                  'totalContactsAmount': item.totalContactsAmount,
                  'spyAmount': item.spyAmount,
                  'chargePeriodictReport': item.chargePeriodictReport,
                  'batteryPeriodictReport': item.batteryPeriodictReport,
                  'callOrder': item.callOrder,
                  'operator': item.operator,
                  'deviceLang': item.deviceLang,
                  'deviceSimLang': item.deviceSimLang,
                  'silentOnSiren': item.silentOnSiren ? 1 : 0,
                  'relayOnDingDong': item.relayOnDingDong ? 1 : 0,
                  'callOnPowerLoss': item.callOnPowerLoss ? 1 : 0,
                  'manageWithContacts': item.manageWithContacts ? 1 : 0,
                  'gsmStateVisibility': item.gsmStateVisibility ? 1 : 0,
                  'remoteAmountVisibility': item.remoteAmountVisibility ? 1 : 0,
                  'antennaAmountVisibility':
                      item.antennaAmountVisibility ? 1 : 0,
                  'contactsAmountVisibility':
                      item.contactsAmountVisibility ? 1 : 0,
                  'networkStateVisibility': item.networkStateVisibility ? 1 : 0,
                  'batteryShapeVisibility': item.batteryShapeVisibility ? 1 : 0,
                  'zone1Visibility': item.zone1Visibility ? 1 : 0,
                  'zone2Visibility': item.zone2Visibility ? 1 : 0,
                  'zone3Visibility': item.zone3Visibility ? 1 : 0,
                  'zone4Visibility': item.zone4Visibility ? 1 : 0,
                  'zone5Visibility': item.zone5Visibility ? 1 : 0,
                  'relay1Visibility': item.relay1Visibility ? 1 : 0,
                  'relay2Visibility': item.relay2Visibility ? 1 : 0,
                  'relay1SectionVisibility':
                      item.relay1SectionVisibility ? 1 : 0,
                  'relay2SectionVisibility':
                      item.relay2SectionVisibility ? 1 : 0,
                  'semiActiveVisibility': item.semiActiveVisibility ? 1 : 0,
                  'silentVisibility': item.silentVisibility ? 1 : 0,
                  'spyVisibility': item.spyVisibility ? 1 : 0,
                  'relay1ActiveBtnVisibility':
                      item.relay1ActiveBtnVisibility ? 1 : 0,
                  'relay2ActiveBtnVisibility':
                      item.relay2ActiveBtnVisibility ? 1 : 0,
                  'relay1TriggerBtnVisibility':
                      item.relay1TriggerBtnVisibility ? 1 : 0,
                  'relay2TriggerBtnVisibility':
                      item.relay2TriggerBtnVisibility ? 1 : 0,
                  'zone1Name': item.zone1Name,
                  'zone1Condition': item.zone1Condition,
                  'zone1State': item.zone1State ? 1 : 0,
                  'zone2Name': item.zone2Name,
                  'zone2Condition': item.zone2Condition,
                  'zone2State': item.zone2State ? 1 : 0,
                  'zone3Name': item.zone3Name,
                  'zone3Condition': item.zone3Condition,
                  'zone3State': item.zone3State ? 1 : 0,
                  'zone4Name': item.zone4Name,
                  'zone4Condition': item.zone4Condition,
                  'zone4State': item.zone4State ? 1 : 0,
                  'zone5Name': item.zone5Name,
                  'zone5Condition': item.zone5Condition,
                  'zone5State': item.zone5State ? 1 : 0,
                  'contact1Name': item.contact1Name,
                  'contact1Phone': item.contact1Phone,
                  'contact1SMS': item.contact1SMS ? 1 : 0,
                  'contact1Call': item.contact1Call ? 1 : 0,
                  'contact1Power': item.contact1Power ? 1 : 0,
                  'contact1Speaker': item.contact1Speaker ? 1 : 0,
                  'contact1SecretReport': item.contact1SecretReport ? 1 : 0,
                  'contact1Manager': item.contact1Manager ? 1 : 0,
                  'contact2Name': item.contact2Name,
                  'contact2Phone': item.contact2Phone,
                  'contact2SMS': item.contact2SMS ? 1 : 0,
                  'contact2Call': item.contact2Call ? 1 : 0,
                  'contact2Power': item.contact2Power ? 1 : 0,
                  'contact2Speaker': item.contact2Speaker ? 1 : 0,
                  'contact2SecretReport': item.contact2SecretReport ? 1 : 0,
                  'contact2Manager': item.contact2Manager ? 1 : 0,
                  'contact3Name': item.contact3Name,
                  'contact3Phone': item.contact3Phone,
                  'contact3SMS': item.contact3SMS ? 1 : 0,
                  'contact3Call': item.contact3Call ? 1 : 0,
                  'contact3Power': item.contact3Power ? 1 : 0,
                  'contact3Speaker': item.contact3Speaker ? 1 : 0,
                  'contact3SecretReport': item.contact3SecretReport ? 1 : 0,
                  'contact3Manager': item.contact3Manager ? 1 : 0,
                  'contact4Name': item.contact4Name,
                  'contact4Phone': item.contact4Phone,
                  'contact4SMS': item.contact4SMS ? 1 : 0,
                  'contact4Call': item.contact4Call ? 1 : 0,
                  'contact4Power': item.contact4Power ? 1 : 0,
                  'contact4Speaker': item.contact4Speaker ? 1 : 0,
                  'contact4SecretReport': item.contact4SecretReport ? 1 : 0,
                  'contact4Manager': item.contact4Manager ? 1 : 0,
                  'contact5Name': item.contact5Name,
                  'contact5Phone': item.contact5Phone,
                  'contact5SMS': item.contact5SMS ? 1 : 0,
                  'contact5Call': item.contact5Call ? 1 : 0,
                  'contact5Power': item.contact5Power ? 1 : 0,
                  'contact5Speaker': item.contact5Speaker ? 1 : 0,
                  'contact5SecretReport': item.contact5SecretReport ? 1 : 0,
                  'contact5Manager': item.contact5Manager ? 1 : 0,
                  'contact6Name': item.contact6Name,
                  'contact6Phone': item.contact6Phone,
                  'contact6SMS': item.contact6SMS ? 1 : 0,
                  'contact6Call': item.contact6Call ? 1 : 0,
                  'contact6Power': item.contact6Power ? 1 : 0,
                  'contact6Speaker': item.contact6Speaker ? 1 : 0,
                  'contact6SecretReport': item.contact6SecretReport ? 1 : 0,
                  'contact6Manager': item.contact6Manager ? 1 : 0,
                  'contact7Name': item.contact7Name,
                  'contact7Phone': item.contact7Phone,
                  'contact7SMS': item.contact7SMS ? 1 : 0,
                  'contact7Call': item.contact7Call ? 1 : 0,
                  'contact7Power': item.contact7Power ? 1 : 0,
                  'contact7Speaker': item.contact7Speaker ? 1 : 0,
                  'contact7SecretReport': item.contact7SecretReport ? 1 : 0,
                  'contact7Manager': item.contact7Manager ? 1 : 0,
                  'contact8Name': item.contact8Name,
                  'contact8Phone': item.contact8Phone,
                  'contact8SMS': item.contact8SMS ? 1 : 0,
                  'contact8Call': item.contact8Call ? 1 : 0,
                  'contact8Power': item.contact8Power ? 1 : 0,
                  'contact8Speaker': item.contact8Speaker ? 1 : 0,
                  'contact8SecretReport': item.contact8SecretReport ? 1 : 0,
                  'contact8Manager': item.contact8Manager ? 1 : 0,
                  'contact9Name': item.contact9Name,
                  'contact9Phone': item.contact9Phone,
                  'contact9SMS': item.contact9SMS ? 1 : 0,
                  'contact9Call': item.contact9Call ? 1 : 0,
                  'contact9Power': item.contact9Power ? 1 : 0,
                  'contact9Speaker': item.contact9Speaker ? 1 : 0,
                  'contact9SecretReport': item.contact9SecretReport ? 1 : 0,
                  'contact9Manager': item.contact9Manager ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Device> _deviceInsertionAdapter;

  final UpdateAdapter<Device> _deviceUpdateAdapter;

  final DeletionAdapter<Device> _deviceDeletionAdapter;

  @override
  Future<Device?> getDevice(int id) async {
    return _queryAdapter.query('SELECT * FROM device WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Device(
            id: row['id'] as int?,
            deviceName: row['deviceName'] as String,
            devicePassword: row['devicePassword'] as String,
            devicePhone: row['devicePhone'] as String,
            deviceModel: row['deviceModel'] as String,
            deviceState: row['deviceState'] as String,
            isManager: (row['isManager'] as int) != 0,
            alarmTime: row['alarmTime'] as String,
            remoteAmount: row['remoteAmount'] as int,
            simChargeAmount: row['simChargeAmount'] as int,
            antennaAmount: row['antennaAmount'] as int,
            batteryAmount: row['batteryAmount'] as int,
            cityPowerState: (row['cityPowerState'] as int) != 0,
            gsmState: (row['gsmState'] as int) != 0,
            speakerState: (row['speakerState'] as int) != 0,
            networkState: (row['networkState'] as int) != 0,
            capsulMax: row['capsulMax'] as int,
            capsulMin: row['capsulMin'] as int,
            totalContactsAmount: row['totalContactsAmount'] as int,
            spyAmount: row['spyAmount'] as int,
            chargePeriodictReport: row['chargePeriodictReport'] as int,
            batteryPeriodictReport: row['batteryPeriodictReport'] as int,
            callOrder: row['callOrder'] as int,
            operator: row['operator'] as String,
            deviceLang: row['deviceLang'] as String,
            deviceSimLang: row['deviceSimLang'] as String,
            silentOnSiren: (row['silentOnSiren'] as int) != 0,
            relayOnDingDong: (row['relayOnDingDong'] as int) != 0,
            callOnPowerLoss: (row['callOnPowerLoss'] as int) != 0,
            manageWithContacts: (row['manageWithContacts'] as int) != 0,
            gsmStateVisibility: (row['gsmStateVisibility'] as int) != 0,
            remoteAmountVisibility: (row['remoteAmountVisibility'] as int) != 0,
            antennaAmountVisibility:
                (row['antennaAmountVisibility'] as int) != 0,
            contactsAmountVisibility:
                (row['contactsAmountVisibility'] as int) != 0,
            batteryShapeVisibility: (row['batteryShapeVisibility'] as int) != 0,
            networkStateVisibility: (row['networkStateVisibility'] as int) != 0,
            zone1Visibility: (row['zone1Visibility'] as int) != 0,
            zone2Visibility: (row['zone2Visibility'] as int) != 0,
            zone3Visibility: (row['zone3Visibility'] as int) != 0,
            zone4Visibility: (row['zone4Visibility'] as int) != 0,
            zone5Visibility: (row['zone5Visibility'] as int) != 0,
            relay1Visibility: (row['relay1Visibility'] as int) != 0,
            relay2Visibility: (row['relay2Visibility'] as int) != 0,
            relay1SectionVisibility:
                (row['relay1SectionVisibility'] as int) != 0,
            relay2SectionVisibility:
                (row['relay2SectionVisibility'] as int) != 0,
            semiActiveVisibility: (row['semiActiveVisibility'] as int) != 0,
            silentVisibility: (row['silentVisibility'] as int) != 0,
            spyVisibility: (row['spyVisibility'] as int) != 0,
            relay1ActiveBtnVisibility:
                (row['relay1ActiveBtnVisibility'] as int) != 0,
            relay2ActiveBtnVisibility:
                (row['relay2ActiveBtnVisibility'] as int) != 0,
            relay1TriggerBtnVisibility:
                (row['relay1TriggerBtnVisibility'] as int) != 0,
            relay2TriggerBtnVisibility:
                (row['relay2TriggerBtnVisibility'] as int) != 0,
            zone1Name: row['zone1Name'] as String,
            zone1Condition: row['zone1Condition'] as String,
            zone1State: (row['zone1State'] as int) != 0,
            zone2Name: row['zone2Name'] as String,
            zone2Condition: row['zone2Condition'] as String,
            zone2State: (row['zone2State'] as int) != 0,
            zone3Name: row['zone3Name'] as String,
            zone3Condition: row['zone3Condition'] as String,
            zone3State: (row['zone3State'] as int) != 0,
            zone4Name: row['zone4Name'] as String,
            zone4Condition: row['zone4Condition'] as String,
            zone4State: (row['zone4State'] as int) != 0,
            zone5Name: row['zone5Name'] as String,
            zone5Condition: row['zone5Condition'] as String,
            zone5State: (row['zone5State'] as int) != 0,
            contact1Name: row['contact1Name'] as String,
            contact1Phone: row['contact1Phone'] as String,
            contact1SMS: (row['contact1SMS'] as int) != 0,
            contact1Call: (row['contact1Call'] as int) != 0,
            contact1Power: (row['contact1Power'] as int) != 0,
            contact1Speaker: (row['contact1Speaker'] as int) != 0,
            contact1SecretReport: (row['contact1SecretReport'] as int) != 0,
            contact1Manager: (row['contact1Manager'] as int) != 0,
            contact2Name: row['contact2Name'] as String,
            contact2Phone: row['contact2Phone'] as String,
            contact2SMS: (row['contact2SMS'] as int) != 0,
            contact2Call: (row['contact2Call'] as int) != 0,
            contact2Power: (row['contact2Power'] as int) != 0,
            contact2Speaker: (row['contact2Speaker'] as int) != 0,
            contact2SecretReport: (row['contact2SecretReport'] as int) != 0,
            contact2Manager: (row['contact2Manager'] as int) != 0,
            contact3Name: row['contact3Name'] as String,
            contact3Phone: row['contact3Phone'] as String,
            contact3SMS: (row['contact3SMS'] as int) != 0,
            contact3Call: (row['contact3Call'] as int) != 0,
            contact3Power: (row['contact3Power'] as int) != 0,
            contact3Speaker: (row['contact3Speaker'] as int) != 0,
            contact3SecretReport: (row['contact3SecretReport'] as int) != 0,
            contact3Manager: (row['contact3Manager'] as int) != 0,
            contact4Name: row['contact4Name'] as String,
            contact4Phone: row['contact4Phone'] as String,
            contact4SMS: (row['contact4SMS'] as int) != 0,
            contact4Call: (row['contact4Call'] as int) != 0,
            contact4Power: (row['contact4Power'] as int) != 0,
            contact4Speaker: (row['contact4Speaker'] as int) != 0,
            contact4SecretReport: (row['contact4SecretReport'] as int) != 0,
            contact4Manager: (row['contact4Manager'] as int) != 0,
            contact5Name: row['contact5Name'] as String,
            contact5Phone: row['contact5Phone'] as String,
            contact5SMS: (row['contact5SMS'] as int) != 0,
            contact5Call: (row['contact5Call'] as int) != 0,
            contact5Power: (row['contact5Power'] as int) != 0,
            contact5Speaker: (row['contact5Speaker'] as int) != 0,
            contact5SecretReport: (row['contact5SecretReport'] as int) != 0,
            contact5Manager: (row['contact5Manager'] as int) != 0,
            contact6Name: row['contact6Name'] as String,
            contact6Phone: row['contact6Phone'] as String,
            contact6SMS: (row['contact6SMS'] as int) != 0,
            contact6Call: (row['contact6Call'] as int) != 0,
            contact6Power: (row['contact6Power'] as int) != 0,
            contact6Speaker: (row['contact6Speaker'] as int) != 0,
            contact6SecretReport: (row['contact6SecretReport'] as int) != 0,
            contact6Manager: (row['contact6Manager'] as int) != 0,
            contact7Name: row['contact7Name'] as String,
            contact7Phone: row['contact7Phone'] as String,
            contact7SMS: (row['contact7SMS'] as int) != 0,
            contact7Call: (row['contact7Call'] as int) != 0,
            contact7Power: (row['contact7Power'] as int) != 0,
            contact7Speaker: (row['contact7Speaker'] as int) != 0,
            contact7SecretReport: (row['contact7SecretReport'] as int) != 0,
            contact7Manager: (row['contact7Manager'] as int) != 0,
            contact8Name: row['contact8Name'] as String,
            contact8Phone: row['contact8Phone'] as String,
            contact8SMS: (row['contact8SMS'] as int) != 0,
            contact8Call: (row['contact8Call'] as int) != 0,
            contact8Power: (row['contact8Power'] as int) != 0,
            contact8Speaker: (row['contact8Speaker'] as int) != 0,
            contact8SecretReport: (row['contact8SecretReport'] as int) != 0,
            contact8Manager: (row['contact8Manager'] as int) != 0,
            contact9Name: row['contact9Name'] as String,
            contact9Phone: row['contact9Phone'] as String,
            contact9SMS: (row['contact9SMS'] as int) != 0,
            contact9Call: (row['contact9Call'] as int) != 0,
            contact9Power: (row['contact9Power'] as int) != 0,
            contact9Speaker: (row['contact9Speaker'] as int) != 0,
            contact9SecretReport: (row['contact9SecretReport'] as int) != 0,
            contact9Manager: (row['contact9Manager'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<List<Device?>> getAllDevices() async {
    return _queryAdapter.queryList('SELECT * FROM device',
        mapper: (Map<String, Object?> row) => Device(
            id: row['id'] as int?,
            deviceName: row['deviceName'] as String,
            devicePassword: row['devicePassword'] as String,
            devicePhone: row['devicePhone'] as String,
            deviceModel: row['deviceModel'] as String,
            deviceState: row['deviceState'] as String,
            isManager: (row['isManager'] as int) != 0,
            alarmTime: row['alarmTime'] as String,
            remoteAmount: row['remoteAmount'] as int,
            simChargeAmount: row['simChargeAmount'] as int,
            antennaAmount: row['antennaAmount'] as int,
            batteryAmount: row['batteryAmount'] as int,
            cityPowerState: (row['cityPowerState'] as int) != 0,
            gsmState: (row['gsmState'] as int) != 0,
            speakerState: (row['speakerState'] as int) != 0,
            networkState: (row['networkState'] as int) != 0,
            capsulMax: row['capsulMax'] as int,
            capsulMin: row['capsulMin'] as int,
            totalContactsAmount: row['totalContactsAmount'] as int,
            spyAmount: row['spyAmount'] as int,
            chargePeriodictReport: row['chargePeriodictReport'] as int,
            batteryPeriodictReport: row['batteryPeriodictReport'] as int,
            callOrder: row['callOrder'] as int,
            operator: row['operator'] as String,
            deviceLang: row['deviceLang'] as String,
            deviceSimLang: row['deviceSimLang'] as String,
            silentOnSiren: (row['silentOnSiren'] as int) != 0,
            relayOnDingDong: (row['relayOnDingDong'] as int) != 0,
            callOnPowerLoss: (row['callOnPowerLoss'] as int) != 0,
            manageWithContacts: (row['manageWithContacts'] as int) != 0,
            gsmStateVisibility: (row['gsmStateVisibility'] as int) != 0,
            remoteAmountVisibility: (row['remoteAmountVisibility'] as int) != 0,
            antennaAmountVisibility:
                (row['antennaAmountVisibility'] as int) != 0,
            contactsAmountVisibility:
                (row['contactsAmountVisibility'] as int) != 0,
            batteryShapeVisibility: (row['batteryShapeVisibility'] as int) != 0,
            networkStateVisibility: (row['networkStateVisibility'] as int) != 0,
            zone1Visibility: (row['zone1Visibility'] as int) != 0,
            zone2Visibility: (row['zone2Visibility'] as int) != 0,
            zone3Visibility: (row['zone3Visibility'] as int) != 0,
            zone4Visibility: (row['zone4Visibility'] as int) != 0,
            zone5Visibility: (row['zone5Visibility'] as int) != 0,
            relay1Visibility: (row['relay1Visibility'] as int) != 0,
            relay2Visibility: (row['relay2Visibility'] as int) != 0,
            relay1SectionVisibility:
                (row['relay1SectionVisibility'] as int) != 0,
            relay2SectionVisibility:
                (row['relay2SectionVisibility'] as int) != 0,
            semiActiveVisibility: (row['semiActiveVisibility'] as int) != 0,
            silentVisibility: (row['silentVisibility'] as int) != 0,
            spyVisibility: (row['spyVisibility'] as int) != 0,
            relay1ActiveBtnVisibility:
                (row['relay1ActiveBtnVisibility'] as int) != 0,
            relay2ActiveBtnVisibility:
                (row['relay2ActiveBtnVisibility'] as int) != 0,
            relay1TriggerBtnVisibility:
                (row['relay1TriggerBtnVisibility'] as int) != 0,
            relay2TriggerBtnVisibility:
                (row['relay2TriggerBtnVisibility'] as int) != 0,
            zone1Name: row['zone1Name'] as String,
            zone1Condition: row['zone1Condition'] as String,
            zone1State: (row['zone1State'] as int) != 0,
            zone2Name: row['zone2Name'] as String,
            zone2Condition: row['zone2Condition'] as String,
            zone2State: (row['zone2State'] as int) != 0,
            zone3Name: row['zone3Name'] as String,
            zone3Condition: row['zone3Condition'] as String,
            zone3State: (row['zone3State'] as int) != 0,
            zone4Name: row['zone4Name'] as String,
            zone4Condition: row['zone4Condition'] as String,
            zone4State: (row['zone4State'] as int) != 0,
            zone5Name: row['zone5Name'] as String,
            zone5Condition: row['zone5Condition'] as String,
            zone5State: (row['zone5State'] as int) != 0,
            contact1Name: row['contact1Name'] as String,
            contact1Phone: row['contact1Phone'] as String,
            contact1SMS: (row['contact1SMS'] as int) != 0,
            contact1Call: (row['contact1Call'] as int) != 0,
            contact1Power: (row['contact1Power'] as int) != 0,
            contact1Speaker: (row['contact1Speaker'] as int) != 0,
            contact1SecretReport: (row['contact1SecretReport'] as int) != 0,
            contact1Manager: (row['contact1Manager'] as int) != 0,
            contact2Name: row['contact2Name'] as String,
            contact2Phone: row['contact2Phone'] as String,
            contact2SMS: (row['contact2SMS'] as int) != 0,
            contact2Call: (row['contact2Call'] as int) != 0,
            contact2Power: (row['contact2Power'] as int) != 0,
            contact2Speaker: (row['contact2Speaker'] as int) != 0,
            contact2SecretReport: (row['contact2SecretReport'] as int) != 0,
            contact2Manager: (row['contact2Manager'] as int) != 0,
            contact3Name: row['contact3Name'] as String,
            contact3Phone: row['contact3Phone'] as String,
            contact3SMS: (row['contact3SMS'] as int) != 0,
            contact3Call: (row['contact3Call'] as int) != 0,
            contact3Power: (row['contact3Power'] as int) != 0,
            contact3Speaker: (row['contact3Speaker'] as int) != 0,
            contact3SecretReport: (row['contact3SecretReport'] as int) != 0,
            contact3Manager: (row['contact3Manager'] as int) != 0,
            contact4Name: row['contact4Name'] as String,
            contact4Phone: row['contact4Phone'] as String,
            contact4SMS: (row['contact4SMS'] as int) != 0,
            contact4Call: (row['contact4Call'] as int) != 0,
            contact4Power: (row['contact4Power'] as int) != 0,
            contact4Speaker: (row['contact4Speaker'] as int) != 0,
            contact4SecretReport: (row['contact4SecretReport'] as int) != 0,
            contact4Manager: (row['contact4Manager'] as int) != 0,
            contact5Name: row['contact5Name'] as String,
            contact5Phone: row['contact5Phone'] as String,
            contact5SMS: (row['contact5SMS'] as int) != 0,
            contact5Call: (row['contact5Call'] as int) != 0,
            contact5Power: (row['contact5Power'] as int) != 0,
            contact5Speaker: (row['contact5Speaker'] as int) != 0,
            contact5SecretReport: (row['contact5SecretReport'] as int) != 0,
            contact5Manager: (row['contact5Manager'] as int) != 0,
            contact6Name: row['contact6Name'] as String,
            contact6Phone: row['contact6Phone'] as String,
            contact6SMS: (row['contact6SMS'] as int) != 0,
            contact6Call: (row['contact6Call'] as int) != 0,
            contact6Power: (row['contact6Power'] as int) != 0,
            contact6Speaker: (row['contact6Speaker'] as int) != 0,
            contact6SecretReport: (row['contact6SecretReport'] as int) != 0,
            contact6Manager: (row['contact6Manager'] as int) != 0,
            contact7Name: row['contact7Name'] as String,
            contact7Phone: row['contact7Phone'] as String,
            contact7SMS: (row['contact7SMS'] as int) != 0,
            contact7Call: (row['contact7Call'] as int) != 0,
            contact7Power: (row['contact7Power'] as int) != 0,
            contact7Speaker: (row['contact7Speaker'] as int) != 0,
            contact7SecretReport: (row['contact7SecretReport'] as int) != 0,
            contact7Manager: (row['contact7Manager'] as int) != 0,
            contact8Name: row['contact8Name'] as String,
            contact8Phone: row['contact8Phone'] as String,
            contact8SMS: (row['contact8SMS'] as int) != 0,
            contact8Call: (row['contact8Call'] as int) != 0,
            contact8Power: (row['contact8Power'] as int) != 0,
            contact8Speaker: (row['contact8Speaker'] as int) != 0,
            contact8SecretReport: (row['contact8SecretReport'] as int) != 0,
            contact8Manager: (row['contact8Manager'] as int) != 0,
            contact9Name: row['contact9Name'] as String,
            contact9Phone: row['contact9Phone'] as String,
            contact9SMS: (row['contact9SMS'] as int) != 0,
            contact9Call: (row['contact9Call'] as int) != 0,
            contact9Power: (row['contact9Power'] as int) != 0,
            contact9Speaker: (row['contact9Speaker'] as int) != 0,
            contact9SecretReport: (row['contact9SecretReport'] as int) != 0,
            contact9Manager: (row['contact9Manager'] as int) != 0));
  }

  @override
  Future<int> insertDevice(Device device) {
    return _deviceInsertionAdapter.insertAndReturnId(
        device, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateDevice(Device device) {
    return _deviceUpdateAdapter.updateAndReturnChangedRows(
        device, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteDevice(Device device) async {
    await _deviceDeletionAdapter.delete(device);
  }
}

class _$RelayDAO extends RelayDAO {
  _$RelayDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _relayInsertionAdapter = InsertionAdapter(
            database,
            'relay',
            (Relay item) => <String, Object?>{
                  'id': item.id,
                  'device_id': item.deviceId,
                  'relayName': item.relayName,
                  'relayTriggerTime': item.relayTriggerTime,
                  'relayState': item.relayState ? 1 : 0
                }),
        _relayUpdateAdapter = UpdateAdapter(
            database,
            'relay',
            ['id'],
            (Relay item) => <String, Object?>{
                  'id': item.id,
                  'device_id': item.deviceId,
                  'relayName': item.relayName,
                  'relayTriggerTime': item.relayTriggerTime,
                  'relayState': item.relayState ? 1 : 0
                }),
        _relayDeletionAdapter = DeletionAdapter(
            database,
            'relay',
            ['id'],
            (Relay item) => <String, Object?>{
                  'id': item.id,
                  'device_id': item.deviceId,
                  'relayName': item.relayName,
                  'relayTriggerTime': item.relayTriggerTime,
                  'relayState': item.relayState ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Relay> _relayInsertionAdapter;

  final UpdateAdapter<Relay> _relayUpdateAdapter;

  final DeletionAdapter<Relay> _relayDeletionAdapter;

  @override
  Future<List<Relay?>> getRelays(int deviceId) async {
    return _queryAdapter.queryList('SELECT * FROM relay WHERE device_id = ?1',
        mapper: (Map<String, Object?> row) => Relay(
            id: row['id'] as int?,
            deviceId: row['device_id'] as int,
            relayName: row['relayName'] as String,
            relayTriggerTime: row['relayTriggerTime'] as String,
            relayState: (row['relayState'] as int) != 0),
        arguments: [deviceId]);
  }

  @override
  Future<int> insertRelay(Relay relay) {
    return _relayInsertionAdapter.insertAndReturnId(
        relay, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateRelay(Relay relay) {
    return _relayUpdateAdapter.updateAndReturnChangedRows(
        relay, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteRelay(Relay relay) async {
    await _relayDeletionAdapter.delete(relay);
  }
}
