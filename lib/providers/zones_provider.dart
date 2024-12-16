import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sms_advanced/sms_advanced.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hoco/widgets/dialogs/editable_dialog_widget.dart';

import '../core/constants/global_keys.dart';
import '../core/constants/sms_codes.dart';
import '../core/utils/enums.dart';
import '../core/utils/extensions.dart';
import '../core/utils/helper.dart';
import '../injector.dart';
import '../models/device.dart';
import '../repository/sms_repository.dart';
import 'main_provider.dart';

class ZonesProvider extends ChangeNotifier {
  late MainProvider _mainProvider;
  List<String> zonesConditions = [];

  ZonesProvider(MainProvider? mainProvider) {
    if (mainProvider != null) {
      _mainProvider = mainProvider;
      zonesConditions = [
        _mainProvider.selectedDevice.zone1Condition,
        _mainProvider.selectedDevice.zone2Condition,
        _mainProvider.selectedDevice.zone3Condition,
        _mainProvider.selectedDevice.zone4Condition,
        _mainProvider.selectedDevice.zone5Condition,
      ];
    }
  }

  Future updateZoneNames(List<TextEditingController> zonesNameTECList) async {
    Navigator.pop(kNavigatorKey.currentContext!);
    showLoadingDialog();
    Device tempDevice = _mainProvider.selectedDevice.copyWith(
      zone1Name: zonesNameTECList[0].text,
      zone2Name: zonesNameTECList[1].text,
      zone3Name: zonesNameTECList[2].text,
      zone4Name: zonesNameTECList[3].text,
      zone5Name: zonesNameTECList[4].text,
    );
    await _mainProvider.updateDevice(tempDevice);
    toastGenerator(translate('zone_saved_successfully'));
    await hideLoadingDialog();
  }

  Future updateZoneCondition(
    int zoneIndex,
    String? newValue,
  ) async {
    if (newValue == null && zonesConditions[zoneIndex] == newValue) {
      return;
    }
    var smsCode = smsCodeGenerator(
      _mainProvider.selectedDevice.devicePassword,
      'Z${zoneIndex + 1}${ZoneConditionExt.code(newValue!)}',
    );
    final sendSMSResult = await injector<SMSRepository>().doSendSMS(
      message: smsCode,
      phoneNumber: _mainProvider.selectedDevice.devicePhone,
      smsCoolDownFinished: _mainProvider.smsCooldownFinished,
      isManager: _mainProvider.selectedDevice.isManager,
    );
    sendSMSResult.fold(
      (l) => toastGenerator(l),
      (r) async {
        _mainProvider.startSMSCooldown();
        Device tempDevice = _mainProvider.selectedDevice.copyWith(
          zone1Condition: zoneIndex == 0
              ? newValue
              : _mainProvider.selectedDevice.zone1Condition,
          zone2Condition: zoneIndex == 1
              ? newValue
              : _mainProvider.selectedDevice.zone2Condition,
          zone3Condition: zoneIndex == 2
              ? newValue
              : _mainProvider.selectedDevice.zone3Condition,
          zone4Condition: zoneIndex == 3
              ? newValue
              : _mainProvider.selectedDevice.zone4Condition,
          zone5Condition: zoneIndex == 4
              ? newValue
              : _mainProvider.selectedDevice.zone5Condition,
        );
        await _mainProvider.updateDevice(tempDevice);
        zonesConditions = [...zonesConditions];
        zonesConditions[zoneIndex] = newValue;
      },
    );
  }

  Future removeZoneFromDevice(int zoneIndex) async {
    var smsCode = smsCodeGenerator(
      _mainProvider.selectedDevice.devicePassword,
      'Z${zoneIndex + 1}T',
    );
    final sendSMSResult = await injector<SMSRepository>().doSendSMS(
      message: smsCode,
      phoneNumber: _mainProvider.selectedDevice.devicePhone,
      smsCoolDownFinished: _mainProvider.smsCooldownFinished,
      isManager: _mainProvider.selectedDevice.isManager,
    );
    sendSMSResult.fold(
      (l) => toastGenerator(l),
      (r) async {
        _mainProvider.startSMSCooldown();
      },
    );
  }

  Future getZonesFromDevice(TextEditingController inquiryDialogTEC) async {
    var smsCode = smsCodeGenerator(
      _mainProvider.selectedDevice.devicePassword,
      kZoneInquiryCode,
    );
    final sendSMSResult = await injector<SMSRepository>().doSendSMS(
      message: smsCode,
      phoneNumber: _mainProvider.selectedDevice.devicePhone,
      smsCoolDownFinished: _mainProvider.smsCooldownFinished,
      isManager: _mainProvider.selectedDevice.isManager,
    );
    sendSMSResult.fold(
      (l) => toastGenerator(l),
      (r) async {
        _mainProvider.startSMSCooldown();
        if (Platform.isAndroid) {
          rootScaffoldMessengerKey.currentState!.hideCurrentSnackBar();
          snackbarGenerator(
            translate('waiting_for_inquiry'),
          );
          _mainProvider.smsListener.onSmsReceived!.listen(
            (SmsMessage message) async => _processRecievedZonesSMS(
              message,
            ),
          );
        } else if (Platform.isIOS) {
          await dialogGenerator(
            translate('inquiry_sms_content'),
            '',
            contentWidget: EditableDialogWidget(
              controller: inquiryDialogTEC,
              textDirection: TextDirection.ltr,
              contentText: translate('inquiry_sms_content_description'),
              hintText: translate('inquiry_sms_content'),
              maxLength: 500,
            ),
            onPressCancel: () {
              inquiryDialogTEC.clear();
              Navigator.pop(kNavigatorKey.currentContext!);
            },
            onPressAccept: () async {
              await _processRecievedZonesSMS(
                SmsMessage(
                  _mainProvider.selectedDevice.devicePhone,
                  inquiryDialogTEC.text,
                ),
              );
              inquiryDialogTEC.clear();
              Navigator.pop(kNavigatorKey.currentContext!);
            },
          );
        }
      },
    );
  }

  Future _processRecievedZonesSMS(SmsMessage message) async {
    if (message.address == null ||
        !message.address!.contains(
          _mainProvider.selectedDevice.devicePhone.substring(1),
        ) ||
        message.body == null) {
      return;
    }
    String messageBody = message.body!;
    List<int> detectionSymbols = _countDetectionSymbols(messageBody);
    List<String> zonesConditions = [
      _mainProvider.selectedDevice.zone1Condition,
      _mainProvider.selectedDevice.zone2Condition,
      _mainProvider.selectedDevice.zone3Condition,
      _mainProvider.selectedDevice.zone4Condition,
      _mainProvider.selectedDevice.zone5Condition,
    ];
    for (int y = 0; y < detectionSymbols.length; y++) {
      if (y + 1 != detectionSymbols.length) {
        String tempSubString = messageBody.substring(
          detectionSymbols[y],
          detectionSymbols[y + 1],
        );
        int indexOfZoneList = tempSubString.contains('1')
            ? 0
            : tempSubString.contains('2')
                ? 1
                : tempSubString.contains('3')
                    ? 2
                    : tempSubString.contains('4')
                        ? 3
                        : tempSubString.contains('5')
                            ? 4
                            : 0;
        String tZoneCondition = tempSubString.contains('N')
            ? ZoneCondition.normalyClose.value
            : tempSubString.contains('O')
                ? ZoneCondition.normalyOpen.value
                : tempSubString.contains('H')
                    ? ZoneCondition.fullHour.value
                    : tempSubString.contains('D')
                        ? ZoneCondition.dingDong.value
                        : tempSubString.contains('G')
                            ? ZoneCondition.guard.value
                            : ZoneCondition.normalyClose.value;
        zonesConditions[indexOfZoneList] = tZoneCondition;
      } else {
        String tempSubString = messageBody.substring(detectionSymbols[y]);
        int indexOfZoneList = tempSubString.contains('1')
            ? 0
            : tempSubString.contains('2')
                ? 1
                : tempSubString.contains('3')
                    ? 2
                    : tempSubString.contains('4')
                        ? 3
                        : tempSubString.contains('5')
                            ? 4
                            : 0;
        String tZoneCondition = tempSubString.contains('N')
            ? ZoneCondition.normalyClose.value
            : tempSubString.contains('O')
                ? ZoneCondition.normalyOpen.value
                : tempSubString.contains('H')
                    ? ZoneCondition.fullHour.value
                    : tempSubString.contains('D')
                        ? ZoneCondition.dingDong.value
                        : tempSubString.contains('G')
                            ? ZoneCondition.guard.value
                            : ZoneCondition.normalyClose.value;
        zonesConditions[indexOfZoneList] = tZoneCondition;
      }
    }
    await _mainProvider.updateDevice(
      _mainProvider.selectedDevice.copyWith(
        zone1Condition: zonesConditions[0],
        zone2Condition: zonesConditions[1],
        zone3Condition: zonesConditions[2],
        zone4Condition: zonesConditions[3],
        zone5Condition: zonesConditions[4],
      ),
    );
    rootScaffoldMessengerKey.currentState!.hideCurrentSnackBar();
  }

  List<int> _countDetectionSymbols(String messageBody) {
    List<int> detectionSymbols = [];
    for (int i = 0; i < messageBody.length; i++) {
      if (messageBody[i] == '*') {
        detectionSymbols.add(i);
      }
    }
    return detectionSymbols;
  }
}
