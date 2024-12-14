import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/enums.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/helper.dart';
import '../../../providers/setup_provider.dart';
import '../../../widgets/custom_text_field_widget.dart';
import '../../../widgets/elevated_button_widget.dart';
import '../../../widgets/operator_container_widget.dart';

class SetupViewMobile extends HookWidget {
  late SetupProvider _setupProvider;
  late TextEditingController _devicePhoneTEC;
  late FocusNode _devicePhoneFN;

  SetupViewMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _setupProvider = context.read<SetupProvider>();
    _devicePhoneTEC = useTextEditingController();
    _devicePhoneFN = useFocusNode();
    return SizedBox(
      width: 1.0.sw,
      child: Column(
        children: <Widget>[
          SizedBox(height: 30.h),
          Text(
            translate('initial_setup'),
            style: styleGenerator(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            translate('device_model'),
            style: styleGenerator(
              fontWeight: FontWeight.w500,
              fontColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: 0.7.sw,
            child: DropdownButton<String>(
              value: context.select<SetupProvider, String>(
                (SetupProvider s) => s.deviceModelDropDownValue,
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey.shade500,
              ),
              iconSize: 22.w,
              isExpanded: true,
              underline: Container(height: 1, color: Colors.black),
              onChanged: (String? newValue) async =>
                  _setupProvider.deviceModelDropDownValue = newValue!,
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
          Divider(height: 30.h, thickness: 1, color: Colors.black12),
          Text(
            translate('device_phone'),
            style: styleGenerator(
              fontWeight: FontWeight.w500,
              fontColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: 0.7.sw,
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
                _setupProvider.autoDetectOperator(newText);
                _devicePhoneFN.requestFocus();
              },
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
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OperatorContainerWidget(
                operator: Operators.mci,
                onTapOperator: () =>
                    _setupProvider.selectedOperator = Operators.mci,
                width: 70.w,
                selectedOperator:
                    context.watch<SetupProvider>().selectedOperator,
              ),
              OperatorContainerWidget(
                operator: Operators.irancell,
                onTapOperator: () =>
                    _setupProvider.selectedOperator = Operators.irancell,
                width: 70.w,
                selectedOperator:
                    context.watch<SetupProvider>().selectedOperator,
              ),
              OperatorContainerWidget(
                operator: Operators.rightel,
                onTapOperator: () =>
                    _setupProvider.selectedOperator = Operators.rightel,
                width: 70.w,
                selectedOperator:
                    context.watch<SetupProvider>().selectedOperator,
              ),
            ],
          ),
          SizedBox(height: 30.h),
          GestureDetector(
            onTap: _onTapPrivacyPolicy,
            child: Text(
              translate('privacy_policy'),
              style: styleGenerator(
                fontSize: 13,
                fontColor: Theme.of(context).colorScheme.secondary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(height: 30.h),
          ElevatedButtonWidget(
            width: 0.45.sw,
            btnText: translate('accept_continue'),
            btnIcon: Icons.arrow_back,
            onPressBtn: () async => _setupProvider.updateDeviceAfterSetup(
              _devicePhoneTEC.text,
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  void _onTapPrivacyPolicy() {
    dialogGenerator(
      translate('privacy_policy'),
      translate('privacy_policy_desc'),
      showCancel: false,
    );
  }
}
