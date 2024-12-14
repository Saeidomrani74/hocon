import '../models/app_settings.dart';
import '../models/device.dart';
import '../models/relay.dart';
import '../services/local/app_database.dart';

class CacheRepository {
  final AppDatabase _appDatabase;
  const CacheRepository(this._appDatabase);

  Future<void> deleteAppSettings(AppSettings appSettings) async {
    return await _appDatabase.appSettingsDao.deleteAppSettings(appSettings);
  }

  Future<AppSettings?> getAppSettings() async {
    return await _appDatabase.appSettingsDao.getAppSettings();
  }

  Future<void> insertAppSettings(AppSettings appSettings) async {
    return await _appDatabase.appSettingsDao.insertAppSettings(appSettings);
  }

  Future<void> updateAppSettings(AppSettings appSettings) async {
    return await _appDatabase.appSettingsDao.updateAppSettings(appSettings);
  }

  Future<void> deleteDevice(Device device) async {
    return await _appDatabase.deviceDao.deleteDevice(device);
  }

  Future<Device?> getDevice(int id) async {
    return await _appDatabase.deviceDao.getDevice(id);
  }

  Future<List<Device?>> getAllDevices() async {
    return await _appDatabase.deviceDao.getAllDevices();
  }

  Future<int> insertDevice(Device device) async {
    return await _appDatabase.deviceDao.insertDevice(device);
  }

  Future<int> updateDevice(Device device) async {
    return await _appDatabase.deviceDao.updateDevice(device);
  }

  Future<void> deleteRelay(Relay relay) async {
    return await _appDatabase.relayDao.deleteRelay(relay);
  }

  Future<List<Relay?>> getRelays(int deviceId) async {
    return await _appDatabase.relayDao.getRelays(deviceId);
  }

  Future<int> insertRelay(Relay relay) async {
    return await _appDatabase.relayDao.insertRelay(relay);
  }

  Future<int> updateRelay(Relay relay) async {
    return await _appDatabase.relayDao.updateRelay(relay);
  }
}
