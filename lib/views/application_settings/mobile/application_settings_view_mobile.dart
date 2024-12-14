import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/helper.dart';
import '../../../models/device.dart';
import '../../../models/relay.dart';
import '../../../providers/app_settings_provider.dart';
import '../../../providers/main_provider.dart';
import '../../../widgets/dialogs/capsul_range_dialog_widget.dart';
import '../../../widgets/dialogs/editable_dialog2_widget.dart';
import '../../../widgets/dialogs/palette_picker_dialog_widget.dart';
import '../../../widgets/setting_item_widget.dart';

class ApplicationSettingsViewMobile extends HookWidget {
  late TextEditingController _oldPassTEC;
  late TextEditingController _newPassTEC;
  late TextEditingController _reNewPassTEC;
  late TextEditingController _triggerHourTEC;
  late TextEditingController _triggerMinuteTEC;
  late TextEditingController _triggerSecondsTEC;
  late TextEditingController _capsulMaxTEC;
  late TextEditingController _capsulMinTEC;
  late MainProvider _mainProvider;
  late AppSettingsProvider _appSettingsProvider;
  late Device _device;
  late List<Relay> relays;

  ApplicationSettingsViewMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _mainProvider = context.read<MainProvider>();
    _appSettingsProvider = context.read<AppSettingsProvider>();
    _device = context.select<MainProvider, Device>(
      (MainProvider m) => m.selectedDevice,
    );
    relays = context.select<MainProvider, List<Relay>>(
      (MainProvider m) => m.relays,
    );
    _oldPassTEC = useTextEditingController();
    _newPassTEC = useTextEditingController();
    _reNewPassTEC = useTextEditingController();
    _triggerHourTEC = useTextEditingController();
    _triggerMinuteTEC = useTextEditingController();
    _triggerSecondsTEC = useTextEditingController();
    _capsulMinTEC = useTextEditingController();
    _capsulMaxTEC = useTextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildShowPassPage(context),
          SizedBox(height: 10.h),
          _buildChangeAppPass(),
          SizedBox(height: 10.h),
          _buildCustomizeHomeItems(context),
          SizedBox(height: 10.h),
          _buildChangeTheme(),
          SizedBox(height: 10.h),
          _buildRelay1TriggerTime(),
          SizedBox(height: 10.h),
          _buildRelay2TriggerTime(),
          SizedBox(height: 10.h),
          _buildEditRelayName(context),
          SizedBox(height: 10.h),
          _buildCapsulRange(),
          /* SizedBox(height: 10.h),
          _buildResetAppSettings(context), */
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildShowPassPage(BuildContext context) {
    return SettingItemWidget(
      settingType: SettingItemType.toggle,
      itemTitle: translate('show_pass_page'),
      switchOpen: _mainProvider.appSettings.showPassPage,
      onSwitchChange: _appSettingsProvider.updateShowPassPage,
    );
  }

  Widget _buildChangeAppPass() {
    return SettingItemWidget(
      settingType: SettingItemType.icon,
      itemTitle: translate('change_app_pass'),
      onItemClick: _onTapChangePassword,
      itemIcon: Icon(
        Icons.keyboard_arrow_left_rounded,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildCustomizeHomeItems(BuildContext context) {
    return SettingItemWidget(
      settingType: SettingItemType.icon,
      itemTitle: translate('choose_home_items'),
      onItemClick: () => Navigator.pushNamed(
        context,
        AppRoutes.customizeHomeRoute,
      ),
      itemIcon: Icon(
        Icons.keyboard_arrow_left_rounded,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildChangeTheme() {
    return SettingItemWidget(
      settingType: SettingItemType.icon,
      itemTitle: translate('change_theme'),
      onItemClick: _onTapChangeTheme,
      itemIcon: Icon(
        Icons.keyboard_arrow_left_rounded,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildRelay1TriggerTime() {
    return SettingItemWidget(
      settingType: SettingItemType.icon,
      itemTitle: translate('relay1_trigger_time'),
      onItemClick: _onTapRelay1TriggerTime,
      itemIcon: Icon(
        Icons.keyboard_arrow_left_rounded,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildRelay2TriggerTime() {
    return SettingItemWidget(
      settingType: SettingItemType.icon,
      itemTitle: translate('relay2_trigger_time'),
      onItemClick: _onTapRelay2TriggerTime,
      itemIcon: Icon(
        Icons.keyboard_arrow_left_rounded,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildEditRelayName(BuildContext context) {
    return SettingItemWidget(
      settingType: SettingItemType.icon,
      itemTitle: translate('relays_naming'),
      onItemClick: () => Navigator.pushNamed(context, AppRoutes.editRelayRoute),
      itemIcon: Icon(
        Icons.keyboard_arrow_left_rounded,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildCapsulRange() {
    return SettingItemWidget(
      settingType: SettingItemType.icon,
      itemTitle: translate('set_capsul_range'),
      onItemClick: _onTapCapsulRange,
      itemIcon: Icon(
        Icons.keyboard_arrow_left_rounded,
        color: Colors.grey[700],
      ),
    );
  }

  /* Widget _buildResetAppSettings(BuildContext context) {
    return SettingItemWidget(
      settingType: SettingItemType.icon,
      itemTitle: translate('reset_app_settings'),
      onItemClick: () => _onTapResetAppSettings(context),
      itemIcon: Icon(
        Icons.keyboard_arrow_left_rounded,
        color: Colors.grey[700],
      ),
    );
  } */

  void _onTapChangePassword() {
    _oldPassTEC.clear();
    _newPassTEC.clear();
    _reNewPassTEC.clear();
    dialogGenerator(
      translate('change_app_pass2'),
      '',
      contentWidget: EditableDialog2Widget(
        controllerList: [
          _oldPassTEC,
          _newPassTEC,
          _reNewPassTEC,
        ],
        hintTextList: [
          translate('old_pass'),
          translate('new_pass'),
          translate('re_new_pass'),
        ],
        maxLength: 6,
        isObsecure: true,
      ),
      onPressAccept: () async => _appSettingsProvider.updateAppPassword(
        _oldPassTEC.text,
        _newPassTEC.text,
        _reNewPassTEC.text,
      ),
    );
  }

  void _onTapChangeTheme() {
    dialogGenerator(
      translate('change_theme'),
      '',
      contentWidget: const PalettePickerDialogWidget(),
      showAccept: false,
    );
  }

  void _onTapRelay1TriggerTime() {
    _triggerHourTEC.clear();
    _triggerMinuteTEC.clear();
    _triggerSecondsTEC.clear();
    dialogGenerator(
      translate('relay1_trigger_time'),
      '',
      contentWidget: EditableDialog2Widget(
        controllerList: [
          _triggerHourTEC,
          _triggerMinuteTEC,
          _triggerSecondsTEC,
        ],
        hintTextList: [
          "${translate('hour_colon')}${relays[0].relayTriggerTime.substring(0, 2)}",
          "${translate('minute_colon')}${relays[0].relayTriggerTime.substring(2, 4)}",
          "${translate('seconds_colon')}${relays[0].relayTriggerTime.substring(4)}",
        ],
        maxLength: 2,
      ),
      onPressAccept: () async => _appSettingsProvider.updateRelayTriggerTime(
        0,
        _triggerHourTEC.text,
        _triggerMinuteTEC.text,
        _triggerSecondsTEC.text,
      ),
    );
  }

  void _onTapRelay2TriggerTime() {
    _triggerHourTEC.clear();
    _triggerMinuteTEC.clear();
    _triggerSecondsTEC.clear();
    dialogGenerator(
      translate('relay2_trigger_time'),
      '',
      contentWidget: EditableDialog2Widget(
        controllerList: [
          _triggerHourTEC,
          _triggerMinuteTEC,
          _triggerSecondsTEC,
        ],
        hintTextList: [
          "${translate('hour_colon')}${relays[1].relayTriggerTime.substring(0, 2)}",
          "${translate('minute_colon')}${relays[1].relayTriggerTime.substring(2, 4)}",
          "${translate('seconds_colon')}${relays[1].relayTriggerTime.substring(4)}",
        ],
        maxLength: 2,
      ),
      onPressAccept: () async => _appSettingsProvider.updateRelayTriggerTime(
        1,
        _triggerHourTEC.text,
        _triggerMinuteTEC.text,
        _triggerSecondsTEC.text,
      ),
    );
  }

  void _onTapCapsulRange() {
    _capsulMaxTEC.clear();
    _capsulMinTEC.clear();
    dialogGenerator(
      translate('set_capsul_range'),
      '',
      contentWidget: CapsulRangeDialogWidget(
        controllerList: [_capsulMaxTEC, _capsulMinTEC],
        hintTextList: [
          "${translate('max_charge_toman_colon')}${_device.capsulMax}",
          "${translate('min_charge_toman_colon')}${_device.capsulMin}",
        ],
      ),
      onPressAccept: () async => _appSettingsProvider.updateCapsulRange(
        _capsulMaxTEC.text,
        _capsulMinTEC.text,
      ),
    );
  }

  /* void _onTapResetAppSettings(BuildContext context) {
    dialogGenerator(
      translate('reset_app_settings'),
      translate('reset_app_settings_desc'),
      onPressAccept: () async {
        _appSettingsProvider
            .resetAppSettings()
            .then((value) => Phoenix.rebirth(context));
      },
    );
  } */
}
