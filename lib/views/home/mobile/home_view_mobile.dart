import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hoco/models/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:signal_strength_indicator/signal_strength_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tokenizer/tokenizer.dart';

import '../../../core/constants/asset_constants.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/design_values.dart';
import '../../../core/constants/global_keys.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/helper.dart';
import '../../../models/device.dart';
import '../../../models/relay.dart';
import '../../../providers/home_provider.dart';
import '../../../providers/main_provider.dart';
import '../../../widgets/elevated_button_widget.dart';
import '../../../widgets/outlined_button_widget.dart';
import '../wave_capsul_widget.dart';

class HomeViewMobile extends StatefulWidget {
  const HomeViewMobile({Key? key}) : super(key: key);

  @override
  HomeViewMobileState createState() => HomeViewMobileState();
}

class HomeViewMobileState extends State<HomeViewMobile>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late MainProvider _mainProvider;
  late HomeProvider _homeProvider;
  late Device _device;
  late List<Relay> relays;
  final TextEditingController _devicePhoneTEC = TextEditingController();
  final TextEditingController _inquiryDialogTEC = TextEditingController();
  final FocusNode _devicePhoneFN = FocusNode();
  final double _stateItemsHeight = 0.053;
  late bool _spyButtonActivated;
  late TabController tabController;
  late CupertinoTabController cupertinoTabController;

  @override
  void dispose() {
    _devicePhoneTEC.dispose();
    _inquiryDialogTEC.dispose();
    _devicePhoneFN.dispose();
    tabController.dispose();
    super.dispose();
  }

  void tabControllerSetup() {
    final initialIndex = _mainProvider.appSettings.selectedDeviceIndex >=
            _mainProvider.deviceListLength
        ? 0
        : _mainProvider.appSettings.selectedDeviceIndex;

    tabController = TabController(
      vsync: this,
      length: _mainProvider.deviceListLength,
      initialIndex: initialIndex,
    )..addListener(
        () async {
          if (!tabController.indexIsChanging) {
            //tab is finished animating you get the current index
            AppSettings tempAppSettings = _mainProvider.appSettings.copyWith(
              selectedDeviceIndex: tabController.index,
            );
            await _mainProvider.updateAppSettings(tempAppSettings);
            _mainProvider.setSelectedDevice();
            _mainProvider.getAllRelays();
          }
        },
      );
    cupertinoTabController = CupertinoTabController(
      initialIndex: initialIndex,
    )..addListener(
        () async {
          AppSettings tempAppSettings = _mainProvider.appSettings.copyWith(
            selectedDeviceIndex: cupertinoTabController.index,
          );
          await _mainProvider.updateAppSettings(tempAppSettings);
          _mainProvider.setSelectedDevice();
          _mainProvider.getAllRelays();
        },
      );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _mainProvider = context.read<MainProvider>();
    _homeProvider = context.read<HomeProvider>();
    _device = context.select<MainProvider, Device>(
      (MainProvider m) => m.selectedDevice,
    );
    relays = context.select<MainProvider, List<Relay>>(
      (MainProvider m) => m.relays,
    );
    _spyButtonActivated = context.watch<HomeProvider>().spyButtonActivated;
    tabControllerSetup();
    return DefaultTabController(
      length: _mainProvider.deviceListLength,
      child: MyBaseWidget(
        hasScrollView: false,
        platformAppBar: _buildAppbar(),
        mobileChild: Platform.isAndroid
            ? TabBarView(
                controller: tabController,
                children:
                    List.generate(_mainProvider.deviceListLength, (index) {
                  return _buildBody(index, context);
                }),
              )
            : _mainProvider.deviceListLength >= 2
                ? CupertinoTabScaffold(
                    controller: cupertinoTabController,
                    tabBar: CupertinoTabBar(
                      activeColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      inactiveColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.4),
                      items: List.generate(_mainProvider.deviceListLength,
                          (index) {
                        return BottomNavigationBarItem(
                          icon: const Icon(Icons.devices),
                          label: _mainProvider.devices[index].deviceName,
                        );
                      }),
                    ),
                    tabBuilder: (context, index) {
                      return _buildBody(index, context);
                    },
                  )
                : _buildBody(0, context),
      ),
    );
  }

  Widget _buildBody(int index, BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(right: 16.w, left: 16.w, top: 14.h),
        child: Column(
          children: [
            _buildStatusSection(index),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActivationSection(context),
                Container(
                  width: 1.w,
                  height: _device.semiActiveVisibility ||
                          _device.silentVisibility ||
                          _device.spyVisibility
                      ? 220.h
                      : 110.h,
                  color: Colors.black54,
                ),
                Column(
                  children: [
                    _buildWaveView(),
                    if (_device.spyVisibility) SizedBox(height: 20.h),
                    if (_device.spyVisibility) _buildSpyDeviceBtn(context),
                  ],
                ),
              ],
            ),
            SizedBox(height: 35.h),
            ElevatedButtonWidget(
              width: double.infinity,
              height: 43.h,
              btnText: translate('inquiry_situation'),
              btnIcon: Icons.info,
              onPressBtn: () async =>
                  _homeProvider.getDeviceFullData(_inquiryDialogTEC),
            ),
            SizedBox(height: 30.h),
            _buildRelaysSection(),
            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSection(int index) {
    return RepaintBoundary(
      child: ExpansionTileCard(
        key: kHomePageExpansionKeys[index],
        title: Text(
          translate('show_info'),
          style: styleGenerator(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontColor: Colors.white,
          ),
        ),
        borderRadius: BorderRadius.circular(kBorderRadius.r),
        baseColor: Theme.of(context).colorScheme.secondary,
        expandedColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
        expandedTextColor: Colors.white,
        children: <Widget>[
          //TODO: use class widget with const instead of method
          _buildDeviceInfoRow(
            translate('state_colon'),
            _device.deviceState == 'active'
                ? translate('active')
                : _device.deviceState == 'semi_active'
                    ? translate('semi_active')
                    : _device.deviceState == 'deactive'
                        ? translate('deactive')
                        : _device.deviceState == 'silent'
                            ? translate('silent')
                            : translate('undefiened'),
          ),
          _buildDeviceInfoRow(
            translate('city_power'),
            _device.cityPowerState
                ? translate('connect')
                : translate('disconnect'),
          ),
          _buildDeviceInfoRow(
            translate('speaker_colon'),
            _device.speakerState
                ? translate('connect')
                : translate('disconnect'),
          ),
          _buildDeviceInfoRow(
            translate('battery_percent_colon'),
            _device.batteryAmount == -1
                ? translate('undefiened')
                : '${_device.batteryAmount} % ',
          ),
          _buildBatteryIndicator(),
          _buildDeviceInfoRow(
            translate('sim_charge_colon'),
            "${_device.simChargeAmount} ${translate('toman')}",
          ),
          _buildDeviceInfoRow(
            translate('netwrok_state_colon'),
            _device.networkState
                ? translate('connect')
                : translate('disconnect'),
            visibility: _device.networkStateVisibility,
          ),
          _buildDeviceInfoRow(
            translate('antenna_state'),
            _device.antennaAmount == 0
                ? translate('zero')
                : _device.antennaAmount >= 1 && _device.antennaAmount <= 8
                    ? translate('weak')
                    : _device.antennaAmount >= 9 && _device.antennaAmount <= 16
                        ? translate('medium')
                        : _device.antennaAmount >= 17 &&
                                _device.antennaAmount <= 24
                            ? translate('good')
                            : translate('perfect'),
            visibility: _device.antennaAmountVisibility,
          ),
          _buildAntennaIndicator(),
          _buildDeviceInfoRow(
            translate('telephone'),
            _device.gsmState ? translate('connect') : translate('disconnect'),
            visibility: _device.gsmStateVisibility,
          ),
          _buildDeviceInfoRow(
            translate('remote_count_colon'),
            "${_device.remoteAmount} ${translate('number')} ",
            visibility: _device.remoteAmountVisibility,
          ),
          _buildDeviceInfoRow(
            translate('contacts_count_colon'),
            "${_device.totalContactsAmount} ${translate('number')} ",
            visibility: _device.contactsAmountVisibility,
          ),
          _buildDeviceInfoRow(
            '${_device.zone1Name}:',
            _device.zone1State ? translate('open') : translate('closed'),
            visibility: _device.zone1Visibility,
          ),
          _buildDeviceInfoRow(
            '${_device.zone2Name}:',
            _device.zone2State ? translate('open') : translate('closed'),
            visibility: _device.zone2Visibility,
          ),
          _buildDeviceInfoRow(
            '${_device.zone3Name}:',
            _device.zone3State ? translate('open') : translate('closed'),
            visibility: _device.zone3Visibility,
          ),
          _buildDeviceInfoRow(
            '${_device.zone4Name}:',
            _device.zone4State ? translate('open') : translate('closed'),
            visibility: _device.zone4Visibility,
          ),
          _buildDeviceInfoRow(
            '${_device.zone5Name}:',
            _device.zone5State ? translate('open') : translate('closed'),
            visibility: _device.zone5Visibility,
          ),
          _buildDeviceInfoRow(
            '${relays[0].relayName}:',
            relays[0].relayState
                ? translate('connect')
                : !relays[0].relayState
                    ? translate('disconnect')
                    : translate('undefiened'),
            visibility: _device.relay1Visibility,
          ),
          _buildDeviceInfoRow(
            '${relays[1].relayName}:',
            relays[1].relayState
                ? translate('connect')
                : !relays[1].relayState
                    ? translate('disconnect')
                    : translate('undefiened'),
            visibility: _device.relay2Visibility,
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Widget _buildActivationSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildActiveDeviceBtn(context),
            SizedBox(width: 20.h),
            _buildDeactiveDeviceBtn(context),
          ],
        ),
        if (_device.semiActiveVisibility || _device.silentVisibility)
          SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_device.semiActiveVisibility)
              _buildSemiActiveDeviceBtn(context),
            if (_device.semiActiveVisibility && _device.silentVisibility)
              SizedBox(width: 20.h),
            if (_device.silentVisibility) _buildSilentDeviceBtn(context),
          ],
        ),
      ],
    );
  }

  Widget _buildRelaysSection() {
    int itemCount =
        _mainProvider.selectedDevice.deviceModel == DeviceModels.series300.value
            ? 2
            : RelaysExt.getRelaysList().length;
    return Visibility(
      visible:
          _device.relay1SectionVisibility || _device.relay2SectionVisibility,
      child: SizedBox(
        height: 0.3.sh,
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return (_device.relay1SectionVisibility &&
                    _device.relay2SectionVisibility)
                ? Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.shade400,
                  )
                : Container();
          },
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Visibility(
              visible: index == 0
                  ? _device.relay1SectionVisibility
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  : index == 1
                      ? _device.relay2SectionVisibility
                      : true,
              child: Container(
                height: 55.h,
                margin: EdgeInsets.only(bottom: 6.h, top: 6.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        relays[index].relayName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: styleGenerator(
                          fontWeight: FontWeight.w500,
                          fontColor: Colors.black87,
                        ),
                      ),
                    ),
                    if (index == 0
                        ? _device.relay1ActiveBtnVisibility
                        // ignore: avoid_bool_literals_in_conditional_expressions
                        : index == 1
                            ? _device.relay2ActiveBtnVisibility
                            : true) ...[
                      _buildRelayButton(
                        translate('active'),
                        () async => _homeProvider.activeRelay(index),
                        relays[index].relayState,
                      ),
                      SizedBox(width: 8.w),
                    ],
                    if (index == 0
                        ? _device.relay1TriggerBtnVisibility
                        // ignore: avoid_bool_literals_in_conditional_expressions
                        : index == 1
                            ? _device.relay2TriggerBtnVisibility
                            : true)
                      _buildRelayButton(
                        translate('trigger'),
                        () async => _homeProvider.triggerRelay(index),
                        false,
                      ),
                    if (index == 0
                        ? _device.relay1ActiveBtnVisibility
                        // ignore: avoid_bool_literals_in_conditional_expressions
                        : index == 1
                            ? _device.relay2ActiveBtnVisibility
                            : true) ...[
                      SizedBox(width: 8.w),
                      _buildRelayButton(
                        translate('deactive'),
                        () async => _homeProvider.deactiveRelay(index),
                        !relays[index].relayState,
                      )
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRelayButton(
    String btnText,
    Function() onTap,
    bool isSelected,
  ) {
    if (isSelected) {
      return ElevatedButtonWidget(
        btnText: btnText,
        width: 70.w,
        onPressBtn: onTap,
      );
    }
    return OutlinedButtonWidget(
      btnText: btnText,
      width: 70.w,
      onPressBtn: onTap,
    );
  }

  Widget _buildActiveDeviceBtn(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50.w),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              _device.deviceState == 'active'
                  ? Colors.transparent
                  : Colors.grey,
              BlendMode.saturation,
            ),
            child: Material(
              color: Colors.tealAccent,
              elevation: 8.0,
              child: InkWell(
                onTap: () async => _homeProvider.activateDevice(),
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  width: 80.w,
                  height: 80.w,
                  child: Image.asset(kActiveAsset),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          translate('active'),
          style: styleGenerator(
            fontWeight: FontWeight.w500,
            fontColor: _device.deviceState == 'active'
                ? Colors.green
                : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Widget _buildDeactiveDeviceBtn(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50.w),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              _device.deviceState == 'deactive'
                  ? Colors.transparent
                  : Colors.grey,
              BlendMode.saturation,
            ),
            child: Material(
              color: Colors.pink[200],
              elevation: 8.0,
              child: InkWell(
                onTap: () async => _homeProvider.deactiveDevice(),
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  width: 80.w,
                  height: 80.w,
                  child: Image.asset(kDeactiveAsset),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          translate('deactive'),
          style: styleGenerator(
            fontWeight: FontWeight.w500,
            fontColor: _device.deviceState == 'deactive'
                ? Colors.red
                : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Widget _buildSemiActiveDeviceBtn(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50.w),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              _device.deviceState == 'semi_active'
                  ? Colors.transparent
                  : Colors.grey,
              BlendMode.saturation,
            ),
            child: Material(
              color: Colors.blue[300],
              elevation: 8.0,
              child: InkWell(
                onTap: () async => _homeProvider.semiActiveDevice(),
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  width: 80.w,
                  height: 80.w,
                  child: Image.asset(kSemiActiveAsset),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          translate('semi_active'),
          style: styleGenerator(
            fontWeight: FontWeight.w500,
            fontColor: _device.deviceState == 'semi_active'
                ? Colors.indigo
                : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Widget _buildSilentDeviceBtn(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50.w),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              _device.deviceState == 'silent'
                  ? Colors.transparent
                  : Colors.grey,
              BlendMode.saturation,
            ),
            child: Material(
              color: Colors.orangeAccent,
              elevation: 8.0,
              child: InkWell(
                onTap: () async => _homeProvider.silentDevice(),
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  width: 80.w,
                  height: 80.w,
                  child: Image.asset(kSilentAsset),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          translate('silent'),
          style: styleGenerator(
            fontWeight: FontWeight.w500,
            fontColor: _device.deviceState == 'silent'
                ? Colors.orange
                : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Widget _buildSpyDeviceBtn(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50.w),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              _spyButtonActivated ? Colors.transparent : Colors.grey,
              BlendMode.saturation,
            ),
            child: Material(
              color: Colors.green,
              elevation: 8.0,
              child: InkWell(
                onTap: () async => _homeProvider.activateSpy(),
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  width: 65.w,
                  height: 65.w,
                  child: Image.asset(kSpyAsset),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          translate('spy'),
          style: styleGenerator(
            fontWeight: FontWeight.w500,
            fontColor:
                _spyButtonActivated ? Colors.green : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  PlatformAppBar _buildAppbar() {
    return PlatformAppBar(
      title: Text(
        translate('app_title'),
        style: styleGenerator(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontColor: Theme.of(context).colorScheme.primary,
          fontName: kFontKara,
          shadow: [
            const BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 3),
              blurRadius: 5.0,
            ),
          ],
        ),
      ),
      leading: GestureDetector(
        onTap: () => kDrawerKey.currentState!.toggle(),
        child: Icon(
          Icons.menu,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      toolbarHeight: _mainProvider.deviceListLength > 1 ? 0.1.sh : 0.08.sh,
      centerTitle: true,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0.0,
      bottom: Platform.isAndroid
          ? _mainProvider.deviceListLength > 1
              ? TabBar(
                  controller: tabController,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  isScrollable: true,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  labelStyle: styleGenerator(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontColor: Theme.of(context).colorScheme.primary,
                  ),
                  unselectedLabelStyle: styleGenerator(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.4),
                  ),
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.4),
                  labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
                  tabs: List.generate(_mainProvider.deviceListLength, (index) {
                    return SizedBox(
                      width: _mainProvider.deviceListLength == 2
                          ? 0.45.sw
                          : _mainProvider.deviceListLength > 2
                              ? 0.3.sw
                              : 0.85.sw,
                      child: Tab(
                        text: _mainProvider.devices[index].deviceName,
                      ),
                    );
                  }),
                )
              : null
          : null,
    );
  }

  Widget _buildWaveView() {
    return GestureDetector(
      onTapDown: (_) =>
          Platform.isAndroid ? _homeProvider.getCapsulData() : null,
      child: Container(
        width: 60.w,
        height: 0.2.sh,
        decoration: BoxDecoration(
          color: const Color(0xffE8EDFE),
          borderRadius: BorderRadius.circular(80.w),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: grey.withOpacity(0.4),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: RepaintBoundary(
          child: WaveCapsulWidget(
            percentageValue: _homeProvider.capsulPercentCalculator(
              _device.simChargeAmount,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAntennaIndicator() {
    return Container(
      height: _stateItemsHeight.sh,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            translate('antenna_power'),
            overflow: TextOverflow.ellipsis,
            style: styleGenerator(fontSize: 14, fontColor: Colors.white),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: _device.networkState
                ? SignalStrengthIndicator.bars(
                    value: _device.antennaAmount == 0
                        ? 0.0
                        : _device.antennaAmount >= 1 &&
                                _device.antennaAmount <= 8
                            ? 0.25
                            : _device.antennaAmount >= 9 &&
                                    _device.antennaAmount <= 16
                                ? 0.5
                                : _device.antennaAmount >= 17 &&
                                        _device.antennaAmount <= 24
                                    ? 0.75
                                    : 1.0,
                    size: 22.w,
                    barCount: 4,
                    spacing: 0.4,
                    radius: Radius.circular(10.w),
                    inactiveColor: Colors.grey[350],
                    activeColor: Colors.green,
                  )
                : Image.asset(kNoSignalAsset, scale: 4.w),
          ),
        ],
      ),
    );
  }

  Widget _buildBatteryIndicator() {
    return Visibility(
      visible: _device.batteryShapeVisibility,
      child: Container(
        height: _stateItemsHeight.sh,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('battery_amount'),
              overflow: TextOverflow.ellipsis,
              style: styleGenerator(fontSize: 15, fontColor: Colors.white),
            ),
            if (_device.batteryAmount == -1)
              Text(
                translate('undefiened'),
                overflow: TextOverflow.ellipsis,
                style: styleGenerator(
                  fontSize: 14,
                  fontColor: Colors.white,
                ),
              )
            else
              Row(
                children: [
                  Container(
                    width: 6.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(3.w),
                        bottomRight: Radius.circular(3.w),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    height: 20.h,
                    width: 55.w,
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70, width: 2.w),
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    child: StepProgressIndicator(
                      totalSteps: 5,
                      currentStep: _device.batteryAmount == 0
                          ? 0
                          : _device.batteryAmount >= 1 &&
                                  _device.batteryAmount <= 20
                              ? 1
                              : _device.batteryAmount >= 21 &&
                                      _device.batteryAmount <= 40
                                  ? 2
                                  : _device.batteryAmount >= 41 &&
                                          _device.batteryAmount <= 60
                                      ? 3
                                      : _device.batteryAmount >= 61 &&
                                              _device.batteryAmount <= 80
                                          ? 4
                                          : 5,
                      size: 10.h,
                      progressDirection: TextDirection.rtl,
                      selectedColor: Colors.green,
                      unselectedColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceInfoRow(
    String title,
    String content, {
    bool visibility = true,
  }) {
    return Visibility(
      visible: visibility,
      child: Container(
        height: _stateItemsHeight.sh,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: styleGenerator(fontSize: 14, fontColor: Colors.white),
            ),
            Text(
              content,
              overflow: TextOverflow.ellipsis,
              style: styleGenerator(
                fontSize: 15,
                fontColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
