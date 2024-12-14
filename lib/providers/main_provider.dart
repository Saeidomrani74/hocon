import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_listener/flutter_sms_listener.dart';
import 'package:supercharged/supercharged.dart';

import '../core/constants/constants.dart';
import '../injector.dart';
import '../models/app_settings.dart';
import '../models/device.dart';
import '../models/relay.dart';
import '../repository/cache_repository.dart';

class MainProvider extends ChangeNotifier {
  List<Device> devices = <Device>[];
  List<Relay> relays = <Relay>[];
  late Device selectedDevice;
  late AppSettings appSettings;
  //SharedPreferences? _sharedPreferences;
  bool smsCooldownFinished = true;
  FlutterSmsListener smsListener = FlutterSmsListener();
  int get deviceListLength => devices.length;

  void setSelectedDevice() {
    selectedDevice = devices[appSettings.selectedDeviceIndex];
  }

  Future insertAppSettings(AppSettings newAppSettings) async {
    appSettings = newAppSettings;
    await injector<CacheRepository>().insertAppSettings(newAppSettings);
    notifyListeners();
    /* await initSP();
    appSettings = newValue;
    String json = jsonEncode(newValue);
    await _sharedPreferences!.setString(APP_SETTING, json); */
  }

  Future insertDevice(Device device) async {
    devices.add(device);
    await injector<CacheRepository>().insertDevice(device);
    notifyListeners();
    /* await initSP();
    deviceList.add(device);
    var json = jsonEncode(deviceList);
    await _sharedPreferences!.setString(DEVICE_DETAIL_LIST, json);
    notifyListeners(); */
  }

  Future insertRelay(Relay relay) async {
    relays.add(relay);
    await injector<CacheRepository>().insertRelay(relay);
    /* await initSP();
    deviceList.add(device);
    var json = jsonEncode(deviceList);
    await _sharedPreferences!.setString(DEVICE_DETAIL_LIST, json);
    notifyListeners(); */
  }

  Future updateAppSettings(AppSettings newAppSettings) async {
    appSettings = newAppSettings;
    await injector<CacheRepository>().updateAppSettings(newAppSettings);
    notifyListeners();
    /* await initSP();
    appSettings = newValue;
    String json = jsonEncode(newValue);
    await _sharedPreferences!.setString(APP_SETTING, json); */
  }

  Future updateDevice(Device device) async {
    // await initSP();
    devices[devices.indexOf(selectedDevice)] = device;
    setSelectedDevice();
    await injector<CacheRepository>().updateDevice(device);
    /* var json = jsonEncode(deviceList);
    await _sharedPreferences!.setString(DEVICE_DETAIL_LIST, json); */
    notifyListeners();
  }

  Future updateRelay(Relay relay) async {
    await injector<CacheRepository>().updateRelay(relay);
    await getAllRelays();
  }

  Future removeDevice(int index) async {
    appSettings = appSettings.copyWith(selectedDeviceIndex: 0);
    selectedDevice = devices[0];
    await injector<CacheRepository>().updateAppSettings(appSettings);
    for (int i = 0; i < relays.length; i++) {
      await injector<CacheRepository>().deleteRelay(relays[i]);
    }
    await injector<CacheRepository>().deleteDevice(devices[index]);
    devices.removeAt(index);
    /* var json = jsonEncode(deviceList);
    await _sharedPreferences!.setString(DEVICE_DETAIL_LIST, json); */
    notifyListeners();
  }

  Future getAppSettings() async {
    appSettings = await injector<CacheRepository>().getAppSettings() ??
        const AppSettings();
    notifyListeners();
    /* await initSP();
    String? jsonFromSP = _sharedPreferences!.getString(key);
    if (jsonFromSP != null) {
      String tempJsonAppSettings = jsonDecode(jsonFromSP) as String;
      appSettings = AppSettings.fromJson(tempJsonAppSettings);
    } else {
      appSettings = const AppSettings();
    }
    notifyListeners(); */
  }

  Future getAllDevices() async {
    final tempDevices = await injector<CacheRepository>().getAllDevices();
    if (tempDevices.isNotEmpty) {
      devices.clear();
      for (var device in tempDevices) {
        if (device != null) {
          devices.add(device);
        }
      }
    }
    /* await initSP();
    String? jsonFromSP = _sharedPreferences!.getString(key);
    if (jsonFromSP != null) {
      var tempJsonDeviceList = jsonDecode(jsonFromSP);
      List<Device> tempDeviceList = List.empty(growable: true);
      for (final String item in tempJsonDeviceList) {
        tempDeviceList.add(Device.fromJson(item));
      }
      deviceList = tempDeviceList;
    } else {
      deviceList = [
        const Device(zones: [], relays: [], contacts: []),
      ];
    }
    notifyListeners(); */
  }

  Future getAllRelays() async {
    final tempRelays = await injector<CacheRepository>().getRelays(
      selectedDevice.id!,
    );
    if (tempRelays.isNotEmpty) {
      relays.clear();
      for (var relay in tempRelays) {
        if (relay != null) {
          relays = [...relays];
          relays.add(relay);
        }
      }
      notifyListeners();
    }
  }

  /* Future initSP() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  } */

  void startSMSCooldown() {
    smsCooldownFinished = false;
    Timer(kSMSCooldown.seconds, () {
      smsCooldownFinished = true;
    });
  }
}
