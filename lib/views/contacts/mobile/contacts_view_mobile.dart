import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hoco/views/contacts/mobile/widgets/cc/redev_checkbox.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_values.dart';
import '../../../core/utils/helper.dart';
import '../../../models/device.dart';
import '../../../providers/contacts_provider.dart';
import '../../../providers/main_provider.dart';
import '../../../widgets/custom_text_field_widget.dart';
import '../../../widgets/elevated_button_widget.dart';
import '../../../widgets/outlined_button_widget.dart';

class ContactsViewMobile extends StatefulWidget {
  const ContactsViewMobile({Key? key}) : super(key: key);

  @override
  ContactsViewMobileState createState() => ContactsViewMobileState();
}

class ContactsViewMobileState extends State<ContactsViewMobile>
    with TickerProviderStateMixin {
  late Device _device;
  late ContactsProvider _contactsProvider;
  late bool _isEditMode;
  late List<List<bool?>> _localData;
  final _inquiryDialogTEC = TextEditingController();
  final List<TextEditingController> _contactsPhoneTECList = List.generate(
    9,
    (index) {
      return TextEditingController();
    },
  );
  final List<TextEditingController> _contactsNameTECList = List.generate(
    9,
    (index) {
      return TextEditingController();
    },
  );

  @override
  void dispose() {
    _inquiryDialogTEC.dispose();
    for (var element in _contactsPhoneTECList) {
      element.dispose();
    }
    for (var element in _contactsNameTECList) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _contactsProvider = context.read<ContactsProvider>();
    _device = context.select<MainProvider, Device>(
      (MainProvider m) => m.selectedDevice,
    );
    _isEditMode = context.select<ContactsProvider, bool>(
      (ContactsProvider c) => c.isEditMode,
    );
    _localData = context.watch<ContactsProvider>().localData;
    if (!_isEditMode) {
      for (int i = 0; i < 9; i++) {
        if (i == 0) {
          _contactsNameTECList[i].text = _device.contact1Name;
          _contactsPhoneTECList[i].text = _device.contact1Phone;
          _localData[i][0] = _device.contact1Call;
          _localData[i][1] = _device.contact1SMS;
          _localData[i][2] = _device.contact1Power;
          _localData[i][3] = _device.contact1Speaker;
          _localData[i][4] = _device.contact1SecretReport;
          _localData[i][5] = _device.contact1Manager;
        } else if (i == 1) {
          _contactsNameTECList[i].text = _device.contact2Name;
          _contactsPhoneTECList[i].text = _device.contact2Phone;
          _localData[i][0] = _device.contact2Call;
          _localData[i][1] = _device.contact2SMS;
          _localData[i][2] = _device.contact2Power;
          _localData[i][3] = _device.contact2Speaker;
          _localData[i][4] = _device.contact2SecretReport;
          _localData[i][5] = _device.contact2Manager;
        } else if (i == 2) {
          _contactsNameTECList[i].text = _device.contact3Name;
          _contactsPhoneTECList[i].text = _device.contact3Phone;
          _localData[i][0] = _device.contact3Call;
          _localData[i][1] = _device.contact3SMS;
          _localData[i][2] = _device.contact3Power;
          _localData[i][3] = _device.contact3Speaker;
          _localData[i][4] = _device.contact3SecretReport;
          _localData[i][5] = _device.contact3Manager;
        } else if (i == 3) {
          _contactsNameTECList[i].text = _device.contact4Name;
          _contactsPhoneTECList[i].text = _device.contact4Phone;
          _localData[i][0] = _device.contact4Call;
          _localData[i][1] = _device.contact4SMS;
          _localData[i][2] = _device.contact4Power;
          _localData[i][3] = _device.contact4Speaker;
          _localData[i][4] = _device.contact4SecretReport;
          _localData[i][5] = _device.contact4Manager;
        } else if (i == 4) {
          _contactsNameTECList[i].text = _device.contact5Name;
          _contactsPhoneTECList[i].text = _device.contact5Phone;
          _localData[i][1] = _device.contact5SMS;
          _localData[i][0] = _device.contact5Call;
          _localData[i][2] = _device.contact5Power;
          _localData[i][3] = _device.contact5Speaker;
          _localData[i][4] = _device.contact5SecretReport;
          _localData[i][5] = _device.contact5Manager;
        } else if (i == 5) {
          _contactsNameTECList[i].text = _device.contact6Name;
          _contactsPhoneTECList[i].text = _device.contact6Phone;
          _localData[i][0] = _device.contact6Call;
          _localData[i][1] = _device.contact6SMS;
          _localData[i][2] = _device.contact6Power;
          _localData[i][3] = _device.contact6Speaker;
          _localData[i][4] = _device.contact6SecretReport;
          _localData[i][5] = _device.contact6Manager;
        } else if (i == 6) {
          _contactsNameTECList[i].text = _device.contact7Name;
          _contactsPhoneTECList[i].text = _device.contact7Phone;
          _localData[i][0] = _device.contact7Call;
          _localData[i][1] = _device.contact7SMS;
          _localData[i][2] = _device.contact7Power;
          _localData[i][3] = _device.contact7Speaker;
          _localData[i][4] = _device.contact7SecretReport;
          _localData[i][5] = _device.contact7Manager;
        } else if (i == 7) {
          _contactsNameTECList[i].text = _device.contact8Name;
          _contactsPhoneTECList[i].text = _device.contact8Phone;
          _localData[i][0] = _device.contact8Call;
          _localData[i][1] = _device.contact8SMS;
          _localData[i][2] = _device.contact8Power;
          _localData[i][3] = _device.contact8Speaker;
          _localData[i][4] = _device.contact8SecretReport;
          _localData[i][5] = _device.contact8Manager;
        } else if (i == 8) {
          _contactsNameTECList[i].text = _device.contact9Name;
          _contactsPhoneTECList[i].text = _device.contact9Phone;
          _localData[i][0] = _device.contact9Call;
          _localData[i][1] = _device.contact9SMS;
          _localData[i][2] = _device.contact9Power;
          _localData[i][3] = _device.contact9Speaker;
          _localData[i][4] = _device.contact9SecretReport;
          _localData[i][5] = _device.contact9Manager;
        }
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      width: 1.0.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Contacts list
          SizedBox(
            width: 1.0.sw,
            height: 0.78.sh,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 16.h),
              child: Column(
                children: [
                  _buildContactContainer(0),
                  _buildContactContainer(1),
                  _buildContactContainer(2),
                  _buildContactContainer(3),
                  _buildContactContainer(4),
                  _buildContactContainer(5),
                  _buildContactContainer(6),
                  _buildContactContainer(7),
                  _buildContactContainer(8),
                  SizedBox(height: 150.h),
                ],
              ),
            ),
          ),
          Divider(height: 8.h, thickness: 2, color: Colors.black12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButtonWidget(
                btnText: translate('record_cntacts'),
                onPressBtn: () async => _contactsProvider.updateContacts(
                  _contactsPhoneTECList,
                  _contactsNameTECList,
                ),
              ),
              OutlinedButtonWidget(
                btnText: translate('inquiry_contacts'),
                onPressBtn: () async =>
                    _contactsProvider.getContactsFromDevice(_inquiryDialogTEC),
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  //TODO: Should move to a separate Widget
  Widget _buildContactContainer(int position) {
    final containerColor = position.isEven
        ? Colors.white
        : Theme.of(context).colorScheme.secondary;
    final contentColor = position.isEven ? Colors.black87 : Colors.white;
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: containerColor,
        elevation: 2,
        borderRadius: BorderRadius.circular(kBorderRadius.r),
        child: Container(
          padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 18.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 0.65.sw,
                    child: CustomTextFieldWidget(
                      controller: _contactsNameTECList[position],
                      hintStyle: styleGenerator(
                        fontSize: 14,
                        fontColor: contentColor,
                      ),
                      inputStyle: styleGenerator(
                        fontSize: 14,
                        fontColor: contentColor,
                      ),
                      textAlign: TextAlign.start,
                      hintText: translate('contact_name'),
                      floatingText: translate('contact_name'),
                      maxLength: 40,
                      hasFloatingPlaceholder: true,
                      inputBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1.w, color: contentColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2.w, color: contentColor),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: IconButton(
                      icon: const Icon(Icons.contact_page_outlined),
                      iconSize: 25.w,
                      splashRadius: 20.w,
                      constraints: const BoxConstraints(),
                      splashColor: Colors.grey.shade400,
                      color: contentColor,
                      onPressed: () async => _onTapImportContact(position),
                    ),
                  ),
                ],
              ),
              CustomTextFieldWidget(
                controller: _contactsPhoneTECList[position],
                hintStyle: styleGenerator(
                  fontSize: 14,
                  fontColor: contentColor,
                ),
                inputStyle:
                    styleGenerator(fontSize: 14, fontColor: contentColor),
                hintText: translate('phone_number'),
                floatingText: translate('phone_number'),
                maxLength: 11,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                hasFloatingPlaceholder: true,
                inputBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1.w, color: contentColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2.w, color: contentColor),
                ),
              ),

              /// Contact checkboxes
              Row(
                children: [
                  CircleCheckbox(
                    value: _localData[position][1],
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    activeColor: contentColor,
                    checkColor: containerColor,
                    fillColor: MaterialStateProperty.all(contentColor),
                    onChanged: (bool? x) => _contactsProvider.updateCheckbox(
                      _contactsPhoneTECList[position].text,
                      x,
                      position,
                      1,
                    ),
                  ),
                  SizedBox(
                    width: 80.w,
                    child: Text(
                      translate('sms'),
                      style: styleGenerator(
                        fontSize: 14,
                        fontColor: contentColor,
                      ),
                    ),
                  ),
                  CircleCheckbox(
                    value: _localData[position][0],
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    activeColor: contentColor,
                    checkColor: containerColor,
                    fillColor: MaterialStateProperty.all(contentColor),
                    onChanged: (bool? x) => _contactsProvider.updateCheckbox(
                      _contactsPhoneTECList[position].text,
                      x,
                      position,
                      0,
                    ),
                  ),
                  Text(
                    translate('call'),
                    style: styleGenerator(
                      fontSize: 14,
                      fontColor: contentColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  CircleCheckbox(
                    value: _localData[position][2],
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    activeColor: contentColor,
                    checkColor: containerColor,
                    fillColor: MaterialStateProperty.all(contentColor),
                    onChanged: (bool? x) => _contactsProvider.updateCheckbox(
                      _contactsPhoneTECList[position].text,
                      x,
                      position,
                      2,
                    ),
                  ),
                  SizedBox(
                    width: 80.w,
                    child: Text(
                      translate('power'),
                      style: styleGenerator(
                        fontSize: 14,
                        fontColor: contentColor,
                      ),
                    ),
                  ),
                  CircleCheckbox(
                    value: _localData[position][3],
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    activeColor: contentColor,
                    checkColor: containerColor,
                    fillColor: MaterialStateProperty.all(contentColor),
                    onChanged: (bool? x) => _contactsProvider.updateCheckbox(
                      _contactsPhoneTECList[position].text,
                      x,
                      position,
                      3,
                    ),
                  ),
                  Text(
                    translate('speaker'),
                    style: styleGenerator(
                      fontSize: 14,
                      fontColor: contentColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  CircleCheckbox(
                    value: _localData[position][4],
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    activeColor: contentColor,
                    checkColor: containerColor,
                    fillColor: MaterialStateProperty.all(contentColor),
                    onChanged: (bool? x) => _contactsProvider.updateCheckbox(
                      _contactsPhoneTECList[position].text,
                      x,
                      position,
                      4,
                    ),
                  ),
                  SizedBox(
                    width: 80.w,
                    child: Text(
                      translate('secret_report'),
                      style: styleGenerator(
                        fontSize: 14,
                        fontColor: contentColor,
                      ),
                    ),
                  ),
                ],
              ),

              /// Delete button
              Align(
                alignment: Alignment.centerLeft,
                child: Material(
                  type: MaterialType.transparency,
                  child: IconButton(
                    icon: const Icon(Icons.delete_forever),
                    iconSize: 25.w,
                    splashRadius: 20.w,
                    constraints: const BoxConstraints(),
                    splashColor: Colors.grey.shade400,
                    color: contentColor,
                    onPressed: () async => _contactsProvider.deleteContact(
                      position,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }

  Future _onTapImportContact(int position) async {
    try {
      final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();

      // final Contact? contact =
      //     await FlutterNativeContactPicker.selectContact();

      Contact? contact = await _contactPicker.selectContact();

      if (contact?.fullName != null) {
        _contactsNameTECList[position].text = contact?.fullName ?? '';
      }
      if (contact?.phoneNumbers != null) {
        String number = (contact?.phoneNumbers?.first ?? '').replaceAll(' ', '');
        if (number.contains('+98')) number = number.replaceFirst('+98', '0');
        if (number.length == 11) {
          _contactsPhoneTECList[position].text = number;
        }
      }
    } on Exception catch (_) {}
  }
}
