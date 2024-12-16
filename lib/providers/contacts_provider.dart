import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sms_advanced/sms_advanced.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hoco/widgets/dialogs/editable_dialog_widget.dart';
import 'package:supercharged/supercharged.dart';

import '../core/constants/constants.dart';
import '../core/constants/global_keys.dart';
import '../core/constants/sms_codes.dart';
import '../core/utils/helper.dart';
import '../core/utils/validators.dart';
import '../injector.dart';
import '../models/device.dart';
import '../repository/sms_repository.dart';
import 'main_provider.dart';

class ContactsProvider extends ChangeNotifier {
  late MainProvider _mainProvider;
  bool isEditMode = false;
  List<List<bool?>> localData = List.generate(
    9,
    (index) => <bool?>[]..length = 6,
  );
  final List<int> _contactsIndexsWithNumber = [];

  ContactsProvider(MainProvider? mainProvider) {
    if (mainProvider != null) {
      _mainProvider = mainProvider;
    }
  }

  void updateCheckbox(
    String currentContactPhone,
    bool? newCheckBoxValue,
    int currentContactIndex,
    int checkBoxIndex,
  ) {
    String? validationContactPhone = Validators.isTextEmpty(
      currentContactPhone,
    );
    if (validationContactPhone != null || newCheckBoxValue == null) {
      return;
    }
    if (!isEditMode) isEditMode = true;
    localData[currentContactIndex][checkBoxIndex] = newCheckBoxValue;
    notifyListeners();
  }

  Future deleteContact(int contactIndex) async {
    var smsCode = smsCodeGenerator(
      _mainProvider.selectedDevice.devicePassword,
      'P${contactIndex + 1}D',
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
        await _mainProvider.updateDevice(
          _generateFreshContactBasedOnIndex(
              contactIndex, _mainProvider.selectedDevice),
        );
      },
    );
  }

  Device _generateFreshContactBasedOnIndex(int contactIndex, Device device) {
    late Device tempDevice = device;
    if (contactIndex == 0) {
      tempDevice = tempDevice.copyWith(
        contact1Name: kContact1Name,
        contact1Phone: '',
        contact1Call: false,
        contact1Manager: false,
        contact1Power: false,
        contact1SMS: false,
        contact1SecretReport: false,
        contact1Speaker: false,
      );
    } else if (contactIndex == 1) {
      tempDevice = tempDevice.copyWith(
        contact2Name: kContact2Name,
        contact2Phone: '',
        contact2Call: false,
        contact2Manager: false,
        contact2Power: false,
        contact2SMS: false,
        contact2SecretReport: false,
        contact2Speaker: false,
      );
    } else if (contactIndex == 2) {
      tempDevice = tempDevice.copyWith(
        contact3Name: kContact3Name,
        contact3Phone: '',
        contact3Call: false,
        contact3Manager: false,
        contact3Power: false,
        contact3SMS: false,
        contact3SecretReport: false,
        contact3Speaker: false,
      );
    } else if (contactIndex == 3) {
      tempDevice = tempDevice.copyWith(
        contact4Name: kContact4Name,
        contact4Phone: '',
        contact4Call: false,
        contact4Manager: false,
        contact4Power: false,
        contact4SMS: false,
        contact4SecretReport: false,
        contact4Speaker: false,
      );
    } else if (contactIndex == 4) {
      tempDevice = tempDevice.copyWith(
        contact5Name: kContact5Name,
        contact5Phone: '',
        contact5Call: false,
        contact5Manager: false,
        contact5Power: false,
        contact5SMS: false,
        contact5SecretReport: false,
        contact5Speaker: false,
      );
    } else if (contactIndex == 5) {
      tempDevice = tempDevice.copyWith(
        contact6Name: kContact6Name,
        contact6Phone: '',
        contact6Call: false,
        contact6Manager: false,
        contact6Power: false,
        contact6SMS: false,
        contact6SecretReport: false,
        contact6Speaker: false,
      );
    } else if (contactIndex == 6) {
      tempDevice = tempDevice.copyWith(
        contact7Name: kContact7Name,
        contact7Phone: '',
        contact7Call: false,
        contact7Manager: false,
        contact7Power: false,
        contact7SMS: false,
        contact7SecretReport: false,
        contact7Speaker: false,
      );
    } else if (contactIndex == 7) {
      tempDevice = tempDevice.copyWith(
        contact8Name: kContact8Name,
        contact8Phone: '',
        contact8Call: false,
        contact8Manager: false,
        contact8Power: false,
        contact8SMS: false,
        contact8SecretReport: false,
        contact8Speaker: false,
      );
    } else if (contactIndex == 8) {
      tempDevice = tempDevice.copyWith(
        contact9Name: kContact9Name,
        contact9Phone: '',
        contact9Call: false,
        contact9Manager: false,
        contact9Power: false,
        contact9SMS: false,
        contact9SecretReport: false,
        contact9Speaker: false,
      );
    }
    return tempDevice;
  }

  Future updateContacts(
    List<TextEditingController> contactsPhoneTECList,
    List<TextEditingController> contactsNameTECList,
  ) async {
    _findContactsWithNumber(contactsPhoneTECList);
    if (_contactsIndexsWithNumber.isEmpty) {
      /// No contact inserted
      return;
    }
    StringBuffer smsCode = StringBuffer();
    if (_contactsIndexsWithNumber.length < 8) {
      /// Less than 8 contact editted
      smsCode.write(_generateSMSCode(contactsPhoneTECList));
      Device tempDevice = _generateNewDevice(
        contactsPhoneTECList,
        contactsNameTECList,
      );
      await _updateContactsInLocalAndDevice(smsCode.toString(), tempDevice);
    } else {
      //More than 7 contact editted so we send 2 message to device with sms cooldown
      smsCode.write(
        _generateSMSCode(contactsPhoneTECList, moreThan6ContactEditted: true),
      );
      String finalSMS = smsCodeGenerator(
        _mainProvider.selectedDevice.devicePassword,
        '${smsCode.toString()}#',
      );
      final sendSMSResult = await injector<SMSRepository>().doSendSMS(
        message: finalSMS,
        phoneNumber: _mainProvider.selectedDevice.devicePhone,
        smsCoolDownFinished: _mainProvider.smsCooldownFinished,
        isManager: _mainProvider.selectedDevice.isManager,
      );
      sendSMSResult.fold(
        (l) => toastGenerator(l),
        (r) async {
          _mainProvider.startSMSCooldown();
          showLoadingDialog(
            msg: translate('long_contacts_desc'),
          );
          await Future.delayed(kSMSCooldown.seconds, () async {
            smsCode.clear();
            smsCode.write(
              _generateSMSCode(
                contactsPhoneTECList,
                isGeneratingSecondPart: true,
              ),
            );
            Device tempDevice = _generateNewDevice(
              contactsPhoneTECList,
              contactsNameTECList,
            );
            await _updateContactsInLocalAndDevice(
              smsCode.toString(),
              tempDevice,
              showConfirmDialog: false,
            );
          });
          await hideLoadingDialog();
        },
      );
    }
  }

  Device _generateNewDevice(
    List<TextEditingController> contactsPhoneTECList,
    List<TextEditingController> contactsNameTECList,
  ) {
    return _mainProvider.selectedDevice.copyWith(
      contact1Name: contactsNameTECList[0].text.isEmpty
          ? _mainProvider.selectedDevice.contact1Name
          : contactsNameTECList[0].text,
      contact1Phone: _contactsIndexsWithNumber.contains(0)
          ? contactsPhoneTECList[0].text
          : _mainProvider.selectedDevice.contact1Phone,
      contact1Call: contactsPhoneTECList[0].text.isNotEmpty
          ? localData[0][0]!
          : contactsPhoneTECList[0].text.isNotEmpty,
      contact1Manager: contactsPhoneTECList[0].text.isNotEmpty
          ? localData[0][5]!
          : contactsPhoneTECList[0].text.isNotEmpty,
      contact1Power: contactsPhoneTECList[0].text.isNotEmpty
          ? localData[0][2]!
          : contactsPhoneTECList[0].text.isNotEmpty,
      contact1SMS: contactsPhoneTECList[0].text.isNotEmpty
          ? localData[0][1]!
          : contactsPhoneTECList[0].text.isNotEmpty,
      contact1SecretReport: contactsPhoneTECList[0].text.isNotEmpty
          ? localData[0][4]!
          : contactsPhoneTECList[0].text.isNotEmpty,
      contact1Speaker: contactsPhoneTECList[0].text.isNotEmpty
          ? localData[0][3]!
          : contactsPhoneTECList[0].text.isNotEmpty,
      contact2Name: contactsNameTECList[1].text.isEmpty
          ? _mainProvider.selectedDevice.contact1Name
          : contactsNameTECList[1].text,
      contact2Phone: _contactsIndexsWithNumber.contains(1)
          ? contactsPhoneTECList[1].text
          : _mainProvider.selectedDevice.contact1Phone,
      contact2Call: contactsPhoneTECList[1].text.isNotEmpty
          ? localData[1][0]!
          : contactsPhoneTECList[1].text.isNotEmpty,
      contact2Manager: contactsPhoneTECList[1].text.isNotEmpty
          ? localData[1][5]!
          : contactsPhoneTECList[1].text.isNotEmpty,
      contact2Power: contactsPhoneTECList[1].text.isNotEmpty
          ? localData[1][2]!
          : contactsPhoneTECList[1].text.isNotEmpty,
      contact2SMS: contactsPhoneTECList[1].text.isNotEmpty
          ? localData[1][1]!
          : contactsPhoneTECList[1].text.isNotEmpty,
      contact2SecretReport: contactsPhoneTECList[1].text.isNotEmpty
          ? localData[1][4]!
          : contactsPhoneTECList[1].text.isNotEmpty,
      contact2Speaker: contactsPhoneTECList[1].text.isNotEmpty
          ? localData[1][3]!
          : contactsPhoneTECList[1].text.isNotEmpty,
      contact3Name: contactsNameTECList[2].text.isEmpty
          ? _mainProvider.selectedDevice.contact1Name
          : contactsNameTECList[2].text,
      contact3Phone: _contactsIndexsWithNumber.contains(2)
          ? contactsPhoneTECList[2].text
          : _mainProvider.selectedDevice.contact1Phone,
      contact3Call: contactsPhoneTECList[2].text.isNotEmpty
          ? localData[2][0]!
          : contactsPhoneTECList[2].text.isNotEmpty,
      contact3Manager: contactsPhoneTECList[2].text.isNotEmpty
          ? localData[2][5]!
          : contactsPhoneTECList[2].text.isNotEmpty,
      contact3Power: contactsPhoneTECList[2].text.isNotEmpty
          ? localData[2][2]!
          : contactsPhoneTECList[2].text.isNotEmpty,
      contact3SMS: contactsPhoneTECList[2].text.isNotEmpty
          ? localData[2][1]!
          : contactsPhoneTECList[2].text.isNotEmpty,
      contact3SecretReport: contactsPhoneTECList[2].text.isNotEmpty
          ? localData[2][4]!
          : contactsPhoneTECList[2].text.isNotEmpty,
      contact3Speaker: contactsPhoneTECList[2].text.isNotEmpty
          ? localData[2][3]!
          : contactsPhoneTECList[2].text.isNotEmpty,
      contact4Name: contactsNameTECList[3].text.isEmpty
          ? _mainProvider.selectedDevice.contact1Name
          : contactsNameTECList[3].text,
      contact4Phone: _contactsIndexsWithNumber.contains(3)
          ? contactsPhoneTECList[3].text
          : _mainProvider.selectedDevice.contact1Phone,
      contact4Call: contactsPhoneTECList[3].text.isNotEmpty
          ? localData[3][0]!
          : contactsPhoneTECList[3].text.isNotEmpty,
      contact4Manager: contactsPhoneTECList[3].text.isNotEmpty
          ? localData[3][5]!
          : contactsPhoneTECList[3].text.isNotEmpty,
      contact4Power: contactsPhoneTECList[3].text.isNotEmpty
          ? localData[3][2]!
          : contactsPhoneTECList[3].text.isNotEmpty,
      contact4SMS: contactsPhoneTECList[3].text.isNotEmpty
          ? localData[3][1]!
          : contactsPhoneTECList[3].text.isNotEmpty,
      contact4SecretReport: contactsPhoneTECList[3].text.isNotEmpty
          ? localData[3][4]!
          : contactsPhoneTECList[3].text.isNotEmpty,
      contact4Speaker: contactsPhoneTECList[3].text.isNotEmpty
          ? localData[3][3]!
          : contactsPhoneTECList[3].text.isNotEmpty,
      contact5Name: contactsNameTECList[4].text.isEmpty
          ? _mainProvider.selectedDevice.contact1Name
          : contactsNameTECList[4].text,
      contact5Phone: _contactsIndexsWithNumber.contains(4)
          ? contactsPhoneTECList[4].text
          : _mainProvider.selectedDevice.contact1Phone,
      contact5Call: contactsPhoneTECList[4].text.isNotEmpty
          ? localData[4][0]!
          : contactsPhoneTECList[4].text.isNotEmpty,
      contact5Manager: contactsPhoneTECList[4].text.isNotEmpty
          ? localData[4][5]!
          : contactsPhoneTECList[4].text.isNotEmpty,
      contact5Power: contactsPhoneTECList[4].text.isNotEmpty
          ? localData[4][2]!
          : contactsPhoneTECList[4].text.isNotEmpty,
      contact5SMS: contactsPhoneTECList[4].text.isNotEmpty
          ? localData[4][1]!
          : contactsPhoneTECList[4].text.isNotEmpty,
      contact5SecretReport: contactsPhoneTECList[4].text.isNotEmpty
          ? localData[4][4]!
          : contactsPhoneTECList[4].text.isNotEmpty,
      contact5Speaker: contactsPhoneTECList[4].text.isNotEmpty
          ? localData[4][3]!
          : contactsPhoneTECList[4].text.isNotEmpty,
      contact6Name: contactsNameTECList[5].text.isEmpty
          ? _mainProvider.selectedDevice.contact1Name
          : contactsNameTECList[5].text,
      contact6Phone: _contactsIndexsWithNumber.contains(5)
          ? contactsPhoneTECList[5].text
          : _mainProvider.selectedDevice.contact1Phone,
      contact6Call: contactsPhoneTECList[5].text.isNotEmpty
          ? localData[5][0]!
          : contactsPhoneTECList[5].text.isNotEmpty,
      contact6Manager: contactsPhoneTECList[5].text.isNotEmpty
          ? localData[5][5]!
          : contactsPhoneTECList[5].text.isNotEmpty,
      contact6Power: contactsPhoneTECList[5].text.isNotEmpty
          ? localData[5][2]!
          : contactsPhoneTECList[5].text.isNotEmpty,
      contact6SMS: contactsPhoneTECList[5].text.isNotEmpty
          ? localData[5][1]!
          : contactsPhoneTECList[5].text.isNotEmpty,
      contact6SecretReport: contactsPhoneTECList[5].text.isNotEmpty
          ? localData[5][4]!
          : contactsPhoneTECList[5].text.isNotEmpty,
      contact6Speaker: contactsPhoneTECList[5].text.isNotEmpty
          ? localData[5][3]!
          : contactsPhoneTECList[5].text.isNotEmpty,
      contact7Name: contactsNameTECList[6].text.isEmpty
          ? _mainProvider.selectedDevice.contact1Name
          : contactsNameTECList[6].text,
      contact7Phone: _contactsIndexsWithNumber.contains(6)
          ? contactsPhoneTECList[6].text
          : _mainProvider.selectedDevice.contact1Phone,
      contact7Call: contactsPhoneTECList[6].text.isNotEmpty
          ? localData[6][0]!
          : contactsPhoneTECList[6].text.isNotEmpty,
      contact7Manager: contactsPhoneTECList[6].text.isNotEmpty
          ? localData[6][5]!
          : contactsPhoneTECList[6].text.isNotEmpty,
      contact7Power: contactsPhoneTECList[6].text.isNotEmpty
          ? localData[6][2]!
          : contactsPhoneTECList[6].text.isNotEmpty,
      contact7SMS: contactsPhoneTECList[6].text.isNotEmpty
          ? localData[6][1]!
          : contactsPhoneTECList[6].text.isNotEmpty,
      contact7SecretReport: contactsPhoneTECList[6].text.isNotEmpty
          ? localData[6][4]!
          : contactsPhoneTECList[6].text.isNotEmpty,
      contact7Speaker: contactsPhoneTECList[6].text.isNotEmpty
          ? localData[6][3]!
          : contactsPhoneTECList[6].text.isNotEmpty,
      contact8Name: contactsNameTECList[7].text.isEmpty
          ? _mainProvider.selectedDevice.contact1Name
          : contactsNameTECList[7].text,
      contact8Phone: _contactsIndexsWithNumber.contains(7)
          ? contactsPhoneTECList[7].text
          : _mainProvider.selectedDevice.contact1Phone,
      contact8Call: contactsPhoneTECList[7].text.isNotEmpty
          ? localData[7][0]!
          : contactsPhoneTECList[7].text.isNotEmpty,
      contact8Manager: contactsPhoneTECList[7].text.isNotEmpty
          ? localData[7][5]!
          : contactsPhoneTECList[7].text.isNotEmpty,
      contact8Power: contactsPhoneTECList[7].text.isNotEmpty
          ? localData[7][2]!
          : contactsPhoneTECList[7].text.isNotEmpty,
      contact8SMS: contactsPhoneTECList[7].text.isNotEmpty
          ? localData[7][1]!
          : contactsPhoneTECList[7].text.isNotEmpty,
      contact8SecretReport: contactsPhoneTECList[7].text.isNotEmpty
          ? localData[7][4]!
          : contactsPhoneTECList[7].text.isNotEmpty,
      contact8Speaker: contactsPhoneTECList[7].text.isNotEmpty
          ? localData[7][3]!
          : contactsPhoneTECList[7].text.isNotEmpty,
      contact9Name: contactsNameTECList[8].text.isEmpty
          ? _mainProvider.selectedDevice.contact1Name
          : contactsNameTECList[8].text,
      contact9Phone: _contactsIndexsWithNumber.contains(8)
          ? contactsPhoneTECList[8].text
          : _mainProvider.selectedDevice.contact1Phone,
      contact9Call: contactsPhoneTECList[8].text.isNotEmpty
          ? localData[8][0]!
          : contactsPhoneTECList[8].text.isNotEmpty,
      contact9Manager: contactsPhoneTECList[8].text.isNotEmpty
          ? localData[8][5]!
          : contactsPhoneTECList[8].text.isNotEmpty,
      contact9Power: contactsPhoneTECList[8].text.isNotEmpty
          ? localData[8][2]!
          : contactsPhoneTECList[8].text.isNotEmpty,
      contact9SMS: contactsPhoneTECList[8].text.isNotEmpty
          ? localData[8][1]!
          : contactsPhoneTECList[8].text.isNotEmpty,
      contact9SecretReport: contactsPhoneTECList[8].text.isNotEmpty
          ? localData[8][4]!
          : contactsPhoneTECList[8].text.isNotEmpty,
      contact9Speaker: contactsPhoneTECList[8].text.isNotEmpty
          ? localData[8][3]!
          : contactsPhoneTECList[8].text.isNotEmpty,
    );
  }

  void _findContactsWithNumber(
    List<TextEditingController> contactsPhoneTECList,
  ) {
    _contactsIndexsWithNumber.clear();
    for (int i = 0; i < contactsPhoneTECList.length; i++) {
      if (contactsPhoneTECList[i].text.isNotEmpty) {
        _contactsIndexsWithNumber.add(i);
      }
    }
  }

  String _generateSMSCode(
    List<TextEditingController> contactsPhoneTECList, {
    bool moreThan6ContactEditted = false,
    bool isGeneratingSecondPart = false,
  }) {
    StringBuffer smsCode = StringBuffer();
    for (int j = isGeneratingSecondPart ? 7 : 0;
        j < (moreThan6ContactEditted ? 7 : _contactsIndexsWithNumber.length);
        j++) {
      smsCode.write(
        'P${_contactsIndexsWithNumber[j] + 1}H${contactsPhoneTECList[_contactsIndexsWithNumber[j]].text}',
      );
      if (contactsPhoneTECList[_contactsIndexsWithNumber[j]].text.isNotEmpty) {
        if (localData[_contactsIndexsWithNumber[j]][0]!) smsCode.write('D');
        if (localData[_contactsIndexsWithNumber[j]][1]!) smsCode.write('S');
        if (localData[_contactsIndexsWithNumber[j]][4]!) smsCode.write('R');
        if (localData[_contactsIndexsWithNumber[j]][2]!) smsCode.write('P');
        if (localData[_contactsIndexsWithNumber[j]][3]!) smsCode.write('C');
        if (localData[_contactsIndexsWithNumber[j]][5]!) smsCode.write('A');
      }
      //If no item checked then we add call and sms
      if (!localData[_contactsIndexsWithNumber[j]].contains(true) &&
          contactsPhoneTECList[_contactsIndexsWithNumber[j]].text.isNotEmpty) {
        smsCode.write('DS');
        localData[_contactsIndexsWithNumber[j]][0] = true;
        localData[_contactsIndexsWithNumber[j]][1] = true;
      }
      if (j + 1 != _contactsIndexsWithNumber.length) {
        smsCode.write('*');
      }
    }
    return smsCode.toString();
  }

  Future _updateContactsInLocalAndDevice(
    String smsCode,
    Device newDevice, {
    bool showConfirmDialog = true,
  }) async {
    String finalSMS = smsCodeGenerator(
      _mainProvider.selectedDevice.devicePassword,
      '$smsCode#',
    );
    final sendSMSResult = await injector<SMSRepository>().doSendSMS(
      message: finalSMS,
      phoneNumber: _mainProvider.selectedDevice.devicePhone,
      smsCoolDownFinished: _mainProvider.smsCooldownFinished,
      isManager: _mainProvider.selectedDevice.isManager,
      showConfirmDialog: showConfirmDialog,
    );
    sendSMSResult.fold(
      (l) => toastGenerator(l),
      (r) async {
        _mainProvider.startSMSCooldown();
        await _mainProvider.updateDevice(newDevice);
        if (isEditMode) isEditMode = false;
      },
    );
  }

  Future getContactsFromDevice(TextEditingController inquiryDialogTEC) async {
    var smsCode = smsCodeGenerator(
      _mainProvider.selectedDevice.devicePassword,
      kContactInquiryCode,
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
            (SmsMessage message) async => _processRecievedContactsSMS(
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
              await _processRecievedContactsSMS(
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

  Future _processRecievedContactsSMS(SmsMessage message) async {
    if (message.address == null ||
        !message.address!.contains(
          _mainProvider.selectedDevice.devicePhone.substring(1),
        ) ||
        message.body == null ||
        !message.body!.contains('*') ||
        message.body!.contains('Z')) {
      return;
    }
    String messageBody = message.body!;
    List<int> detectionSymbols = [];
    Device tempDevice = _mainProvider.selectedDevice.copyWith();
    if (messageBody == "*#") {
      /// Remove all contacts from database
      tempDevice = _generateNewDeviceWithFreshContacts();
    } else {
      detectionSymbols.addAll(_countDetectionSymbols(messageBody));
      int howMuchTime = 1;
      for (var i = 0; i < 9; i++) {
        if (howMuchTime < detectionSymbols.length) {
          if (messageBody
              .substring(
                detectionSymbols[howMuchTime] - 1,
                detectionSymbols[howMuchTime],
              )
              .contains((i + 1).toString())) {
            var contactData = messageBody.substring(
              detectionSymbols[howMuchTime - 1],
              detectionSymbols[howMuchTime],
            );
            tempDevice = _generateDeviceForRecievedSMS(
              i,
              tempDevice,
              messageBody.substring(
                detectionSymbols[howMuchTime - 1] + 1,
                detectionSymbols[howMuchTime - 1] + 12,
              ),
              contactData,
            );
            howMuchTime++;
          } else {
            tempDevice = _generateFreshContactBasedOnIndex(i, tempDevice);
          }
        } else {
          tempDevice = _generateFreshContactBasedOnIndex(i, tempDevice);
        }
      }
    }
    await _mainProvider.updateDevice(tempDevice);
    rootScaffoldMessengerKey.currentState!.hideCurrentSnackBar();
    if (isEditMode) isEditMode = false;
  }

  Device _generateNewDeviceWithFreshContacts() {
    return _mainProvider.selectedDevice.copyWith(
      contact1Name: kContact1Name,
      contact1Phone: '',
      contact1SMS: false,
      contact1Call: false,
      contact1Power: false,
      contact1Speaker: false,
      contact1SecretReport: false,
      contact1Manager: false,
      contact2Name: kContact2Name,
      contact2Phone: '',
      contact2SMS: false,
      contact2Call: false,
      contact2Power: false,
      contact2Speaker: false,
      contact2SecretReport: false,
      contact2Manager: false,
      contact3Name: kContact3Name,
      contact3Phone: '',
      contact3SMS: false,
      contact3Call: false,
      contact3Power: false,
      contact3Speaker: false,
      contact3SecretReport: false,
      contact3Manager: false,
      contact4Name: kContact4Name,
      contact4Phone: '',
      contact4SMS: false,
      contact4Call: false,
      contact4Power: false,
      contact4Speaker: false,
      contact4SecretReport: false,
      contact4Manager: false,
      contact5Name: kContact5Name,
      contact5Phone: '',
      contact5SMS: false,
      contact5Call: false,
      contact5Power: false,
      contact5Speaker: false,
      contact5SecretReport: false,
      contact5Manager: false,
      contact6Name: kContact6Name,
      contact6Phone: '',
      contact6SMS: false,
      contact6Call: false,
      contact6Power: false,
      contact6Speaker: false,
      contact6SecretReport: false,
      contact6Manager: false,
      contact7Name: kContact7Name,
      contact7Phone: '',
      contact7SMS: false,
      contact7Call: false,
      contact7Power: false,
      contact7Speaker: false,
      contact7SecretReport: false,
      contact7Manager: false,
      contact8Name: kContact8Name,
      contact8Phone: '',
      contact8SMS: false,
      contact8Call: false,
      contact8Power: false,
      contact8Speaker: false,
      contact8SecretReport: false,
      contact8Manager: false,
      contact9Name: kContact9Name,
      contact9Phone: '',
      contact9SMS: false,
      contact9Call: false,
      contact9Power: false,
      contact9Speaker: false,
      contact9SecretReport: false,
      contact9Manager: false,
    );
  }

  Device _generateDeviceForRecievedSMS(
    int index,
    Device device,
    String contactPhone,
    String contactData,
  ) {
    Device tempDevice = device;
    if (index == 0) {
      tempDevice = tempDevice.copyWith(
        contact1Phone: contactPhone,
        contact1Call: contactData.contains('D'),
        contact1Manager: contactData.contains('A'),
        contact1Power: contactData.contains('P'),
        contact1SMS: contactData.contains('S'),
        contact1SecretReport: contactData.contains('R'),
        contact1Speaker: contactData.contains('C'),
      );
    } else if (index == 1) {
      tempDevice = tempDevice.copyWith(
        contact2Phone: contactPhone,
        contact2Call: contactData.contains('D'),
        contact2Manager: contactData.contains('A'),
        contact2Power: contactData.contains('P'),
        contact2SMS: contactData.contains('S'),
        contact2SecretReport: contactData.contains('R'),
        contact2Speaker: contactData.contains('C'),
      );
    } else if (index == 2) {
      tempDevice = tempDevice.copyWith(
        contact3Phone: contactPhone,
        contact3Call: contactData.contains('D'),
        contact3Manager: contactData.contains('A'),
        contact3Power: contactData.contains('P'),
        contact3SMS: contactData.contains('S'),
        contact3SecretReport: contactData.contains('R'),
        contact3Speaker: contactData.contains('C'),
      );
    } else if (index == 3) {
      tempDevice = tempDevice.copyWith(
        contact4Phone: contactPhone,
        contact4Call: contactData.contains('D'),
        contact4Manager: contactData.contains('A'),
        contact4Power: contactData.contains('P'),
        contact4SMS: contactData.contains('S'),
        contact4SecretReport: contactData.contains('R'),
        contact4Speaker: contactData.contains('C'),
      );
    } else if (index == 4) {
      tempDevice = tempDevice.copyWith(
        contact5Phone: contactPhone,
        contact5Call: contactData.contains('D'),
        contact5Manager: contactData.contains('A'),
        contact5Power: contactData.contains('P'),
        contact5SMS: contactData.contains('S'),
        contact5SecretReport: contactData.contains('R'),
        contact5Speaker: contactData.contains('C'),
      );
    } else if (index == 5) {
      tempDevice = tempDevice.copyWith(
        contact6Phone: contactPhone,
        contact6Call: contactData.contains('D'),
        contact6Manager: contactData.contains('A'),
        contact6Power: contactData.contains('P'),
        contact6SMS: contactData.contains('S'),
        contact6SecretReport: contactData.contains('R'),
        contact6Speaker: contactData.contains('C'),
      );
    } else if (index == 6) {
      tempDevice = tempDevice.copyWith(
        contact7Phone: contactPhone,
        contact7Call: contactData.contains('D'),
        contact7Manager: contactData.contains('A'),
        contact7Power: contactData.contains('P'),
        contact7SMS: contactData.contains('S'),
        contact7SecretReport: contactData.contains('R'),
        contact7Speaker: contactData.contains('C'),
      );
    } else if (index == 7) {
      tempDevice = tempDevice.copyWith(
        contact8Phone: contactPhone,
        contact8Call: contactData.contains('D'),
        contact8Manager: contactData.contains('A'),
        contact8Power: contactData.contains('P'),
        contact8SMS: contactData.contains('S'),
        contact8SecretReport: contactData.contains('R'),
        contact8Speaker: contactData.contains('C'),
      );
    } else if (index == 8) {
      tempDevice = tempDevice.copyWith(
        contact9Phone: contactPhone,
        contact9Call: contactData.contains('D'),
        contact9Manager: contactData.contains('A'),
        contact9Power: contactData.contains('P'),
        contact9SMS: contactData.contains('S'),
        contact9SecretReport: contactData.contains('R'),
        contact9Speaker: contactData.contains('C'),
      );
    }
    return tempDevice;
  }

  List<int> _countDetectionSymbols(String messageBody) {
    List<int> detectionSymbols = [];
    for (int i = 0; i < messageBody.length; i++) {
      if (messageBody[i] == '*' || messageBody[i] == '#') {
        detectionSymbols.add(i);
      }
    }
    return detectionSymbols;
  }
}
