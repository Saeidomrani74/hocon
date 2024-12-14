import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/helper.dart';
import '../../../../models/device.dart';
import '../../../../providers/device_settings_provider.dart';
import '../../../../providers/main_provider.dart';
import '../../../../widgets/custom_text_field_widget.dart';
import '../../../../widgets/elevated_button_widget.dart';
import '../../../../widgets/operator_container_widget.dart';
import '../../../../widgets/outlined_button_widget.dart';

class EditDeviceViewMobile extends StatefulWidget {
  const EditDeviceViewMobile({Key? key}) : super(key: key);

  @override
  State<EditDeviceViewMobile> createState() => _EditDeviceViewMobileState();
}

class _EditDeviceViewMobileState extends State<EditDeviceViewMobile> {
  late DeviceSettingsProvider _deviceSettingsProvider;
  late Device _device;
  late TextEditingController _deviceNameTEC;
  late TextEditingController _devicePhoneTEC;
  late FocusNode _deviceNameFN;
  late FocusNode _devicePhoneFN;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _deviceSettingsProvider.deviceModelDropDownValue = _device.deviceModel;
      _deviceSettingsProvider.selectedOperator =
          OperatorsExt.getOperatorsList().firstWhere(
        (element) => element.value == _device.operator,
      );
    });
  }

  @override
  void dispose() {
    _deviceNameTEC.dispose();
    _devicePhoneTEC.dispose();
    _deviceNameFN.dispose();
    _devicePhoneFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSettingsProvider = context.watch<DeviceSettingsProvider>();
    _device = context.select<MainProvider, Device>(
      (MainProvider m) => m.selectedDevice,
    );
    _deviceNameTEC = TextEditingController(text: _device.deviceName);
    _devicePhoneTEC = TextEditingController(text: _device.devicePhone);
    _deviceNameFN = FocusNode();
    _devicePhoneFN = FocusNode();
    return Column(
      children: [
        SizedBox(height: 8.h),
        /*  Text(
          translate('device_model'),
          style: styleGenerator(
            fontWeight: FontWeight.w500,
            fontColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 0.7.sw,
          child: DropdownButton<String>(
            value: context.select<DeviceSettingsProvider, String>(
              (DeviceSettingsProvider ds) => ds.deviceModelDropDownValue,
            ),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey.shade500,
            ),
            iconSize: 22.w,
            isExpanded: true,
            underline: Container(height: 1, color: Colors.black),
            onChanged: (String? newValue) async =>
                _deviceSettingsProvider.deviceModelDropDownValue = newValue!,
            items: DeviceModelsExt.getDeviceModelsList()
                .map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: styleGenerator(fontSize: 13),
                  ),
                );
              },
            ).toList(),
          ),
        ),
        Divider(height: 30.h, thickness: 1, color: Colors.black12), */
        Text(
          translate('device_phone'),
          style: styleGenerator(
            fontWeight: FontWeight.w500,
            fontColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 0.6.sw,
          child: CustomTextFieldWidget(
            controller: _devicePhoneTEC,
            focusNode: _devicePhoneFN,
            hintStyle: styleGenerator(
              fontSize: 13,
              fontColor: Colors.black45,
            ),
            inputStyle: styleGenerator(
              fontSize: 14,
              fontColor: Colors.black54,
            ),
            textDirection: TextDirection.ltr,
            hintText: translate('device_sim_number'),
            floatingText: translate('device_sim_number'),
            maxLength: 11,
            inputBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: Colors.black45),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: Colors.black54),
            ),
            keyboardType: TextInputType.number,
            onChange: (String newText) {
              _deviceSettingsProvider.autoDetectOperator(newText);
              _devicePhoneFN.requestFocus();
            },
          ),
        ),
        Divider(height: 30.h, thickness: 1, color: Colors.black12),
        Text(
          translate('device_name'),
          style: styleGenerator(
            fontWeight: FontWeight.w500,
            fontColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        SizedBox(
          width: 0.6.sw,
          child: CustomTextFieldWidget(
            controller: _deviceNameTEC,
            focusNode: _deviceNameFN,
            hintStyle: styleGenerator(
              fontSize: 13,
              fontColor: Colors.black45,
            ),
            inputStyle: styleGenerator(
              fontSize: 14,
              fontColor: Colors.black54,
            ),
            textDirection: TextDirection.ltr,
            hintText: translate('device_name'),
            floatingText: translate('device_name'),
            inputBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: Colors.black45),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: Colors.black54),
            ),
            keyboardType: TextInputType.text,
          ),
        ),
        Divider(height: 30.h, thickness: 1, color: Colors.black12),
        Text(
          translate('device_operator'),
          style: styleGenerator(
            fontWeight: FontWeight.w500,
            fontColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OperatorContainerWidget(
              operator: Operators.mci,
              onTapOperator: () =>
                  _deviceSettingsProvider.selectedOperator = Operators.mci,
              width: 70.w,
              selectedOperator:
                  context.watch<DeviceSettingsProvider>().selectedOperator,
            ),
            OperatorContainerWidget(
              operator: Operators.irancell,
              onTapOperator: () =>
                  _deviceSettingsProvider.selectedOperator = Operators.irancell,
              width: 70.w,
              selectedOperator:
                  context.watch<DeviceSettingsProvider>().selectedOperator,
            ),
            OperatorContainerWidget(
              operator: Operators.rightel,
              onTapOperator: () =>
                  _deviceSettingsProvider.selectedOperator = Operators.rightel,
              width: 70.w,
              selectedOperator:
                  context.watch<DeviceSettingsProvider>().selectedOperator,
            ),
          ],
        ),
        SizedBox(height: 50.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSubmitButton(),
            _buildRemoveButton(context),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButtonWidget(
      btnText: translate('record'),
      btnIcon: Icons.save,
      onPressBtn: _onTapSubmitButton,
    );
  }

  Widget _buildRemoveButton(BuildContext context) {
    return OutlinedButtonWidget(
      btnText: translate('remove_device'),
      btnIcon: Icons.delete,
      onPressBtn: _onTapRemoveButton,
    );
  }

  void _onTapSubmitButton() {
    dialogGenerator(
      translate('edit_device'),
      translate('are_you_sure'),
      onPressAccept: () async => _deviceSettingsProvider.updateDeviceInfo(
        _deviceNameTEC.text,
        _devicePhoneTEC.text,
      ),
    );
  }

  void _onTapRemoveButton() {
    dialogGenerator(
      translate('remove_device'),
      translate('are_you_sure'),
      onPressAccept: () async =>
          _deviceSettingsProvider.removeDeviceFromDatabase(),
    );
  }
}
