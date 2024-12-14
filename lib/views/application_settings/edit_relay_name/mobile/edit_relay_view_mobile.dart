import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/helper.dart';
import '../../../../providers/app_settings_provider.dart';
import '../../../../providers/main_provider.dart';
import '../../../../widgets/elevated_button_widget.dart';
import '../../../../widgets/setting_item_widget.dart';

class EditRelayViewMobile extends HookWidget {
  late TextEditingController _relay1TEC;
  late TextEditingController _relay2TEC;
  late MainProvider _mainProvider;
  late AppSettingsProvider _appSettingsProvider;

  EditRelayViewMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _mainProvider = context.read<MainProvider>();
    _appSettingsProvider = context.read<AppSettingsProvider>();
    _relay1TEC = useTextEditingController();
    _relay2TEC = useTextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      width: 1.0.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRelay1Title(),
          SizedBox(height: 8.h),
          _buildRelay1Name(),
          SizedBox(height: 25.h),
          _buildRelay2Title(),
          SizedBox(height: 8.h),
          _buildRelay2Name(),
          SizedBox(height: 50.h),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildRelay1Title() {
    return Text(
      translate('relay1'),
      style: styleGenerator(
        fontWeight: FontWeight.bold,
        fontColor: Colors.black87,
      ),
    );
  }

  Widget _buildRelay1Name() {
    return SettingItemWidget(
      textFieldController: _relay1TEC,
      settingType: SettingItemType.edit,
      itemHeight: 85.h,
      hintText:
          "${translate('current_name_colon')}${_mainProvider.relays[0].relayName}",
    );
  }

  Widget _buildRelay2Title() {
    return Text(
      translate('relay2'),
      style: styleGenerator(
        fontWeight: FontWeight.bold,
        fontColor: Colors.black87,
      ),
    );
  }

  Widget _buildRelay2Name() {
    return SettingItemWidget(
      textFieldController: _relay2TEC,
      settingType: SettingItemType.edit,
      itemHeight: 85.h,
      hintText:
          "${translate('current_name_colon')}${_mainProvider.relays[1].relayName}",
    );
  }

  Widget _buildSaveButton() {
    return Center(
      child: ElevatedButtonWidget(
        btnText: translate('save'),
        btnIcon: Icons.save,
        onPressBtn: _onTapSave,
      ),
    );
  }

  void _onTapSave() {
    dialogGenerator(
      translate('save_information'),
      translate('are_you_sure'),
      onPressAccept: () async => _appSettingsProvider.updateRelaysName(
        _relay1TEC.text,
        _relay2TEC.text,
      ),
    );
  }
}
