import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../config/routes/app_routes.dart';
import '../core/constants/global_keys.dart';
import '../core/utils/enums.dart';
import '../core/utils/extensions.dart';
import '../core/utils/helper.dart';
import '../injector.dart';
import '../models/device.dart';
import '../models/relay.dart';
import '../repository/sms_repository.dart';
import 'main_provider.dart';

class SetupProvider extends ChangeNotifier {
  late MainProvider _mainProvider;
  String _deviceModelDropDownValue = DeviceModels.series300.value;
  Operators _selectedOperator = Operators.none;

  /// Getters
  String get deviceModelDropDownValue => _deviceModelDropDownValue;
  Operators get selectedOperator => _selectedOperator;

  /// Setters
  set deviceModelDropDownValue(String value) {
    _deviceModelDropDownValue = value;
    notifyListeners();
  }

  set selectedOperator(Operators operator) {
    _selectedOperator = operator;
    notifyListeners();
  }

  /// Constructor
  SetupProvider(MainProvider? mainProvider) {
    if (mainProvider != null) {
      _mainProvider = mainProvider;
    }
  }

  String? _validateSetupFields(String devicePhone) {
    if (devicePhone.length != 11 || devicePhone.contains(' ')) {
      return translate('phone_number_wrong');
    }
    if (selectedOperator == Operators.none) {
      return translate('choose_operator_desc');
    }
    return null;
  }

  Future updateDeviceAfterSetup(
    String devicePhone,
  ) async {
    String? validation = _validateSetupFields(devicePhone);
    if (validation != null) {
      toastGenerator(validation);
      return;
    }
    closeSoftKeyboard();
    var smsCode = smsCodeGenerator(
      _mainProvider.selectedDevice.devicePassword,
      selectedOperator.code,
    );
    final sendSMSResult = await injector<SMSRepository>().doSendSMS(
      message: smsCode,
      phoneNumber: devicePhone,
      smsCoolDownFinished: _mainProvider.smsCooldownFinished,
      isManager: _mainProvider.selectedDevice.isManager,
      showConfirmDialog: false,
    );
    sendSMSResult.fold(
      (l) => toastGenerator(l),
      (r) async {
        _mainProvider.startSMSCooldown();
        Device tempDevice = _mainProvider.selectedDevice.copyWith(
          devicePhone: devicePhone,
          deviceModel: deviceModelDropDownValue,
          operator: selectedOperator.value,
        );
        await _mainProvider.updateDevice(tempDevice);
        if (deviceModelDropDownValue == DeviceModels.series300.value) {
          for (int i = 0; i < 2; i++) {
            await _mainProvider.insertRelay(
              Relay(
                deviceId: _mainProvider.selectedDevice.id!,
                relayName: RelaysExt.getRelaysList()[i].value,
              ),
            );
          }
        } else {
          for (int i = 0; i < RelaysExt.getRelaysList().length; i++) {
            await _mainProvider.insertRelay(
              Relay(
                deviceId: _mainProvider.selectedDevice.id!,
                relayName: RelaysExt.getRelaysList()[i].value,
              ),
            );
          }
        }
        await _mainProvider.getAllRelays();
        Navigator.popAndPushNamed(
          kNavigatorKey.currentContext!,
          AppRoutes.homeRoute,
        );
        Navigator.pushNamed(
          kNavigatorKey.currentContext!,
          AppRoutes.contactsRoute,
        );
        toastGenerator(translate('insert_contacts_desc'));
      },
    );
  }

  void autoDetectOperator(String value) {
    if (value.length == 3) {
      String preCode = value.substring(0, 3);
      if (preCode == '091' || preCode == '099') {
        selectedOperator = Operators.mci;
      } else if (preCode == '093' || preCode == '090') {
        selectedOperator = Operators.irancell;
      } else if (preCode == '092') {
        selectedOperator = Operators.rightel;
      } else {
        selectedOperator = Operators.none;
      }
    }
  }
}
