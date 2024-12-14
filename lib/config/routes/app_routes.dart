import 'package:flutter/material.dart';

import '../../views/about_us/aboutus_view.dart';
import '../../views/add_device/add_device_view.dart';
import '../../views/advance_tools/advance_tools_view.dart';
import '../../views/application_settings/application_settings_view.dart';
import '../../views/application_settings/customize_home_page/customize_home_view.dart';
import '../../views/application_settings/edit_relay_name/edit_relay_view.dart';
import '../../views/charge_device/charge_device_view.dart';
import '../../views/contacts/contacts_view.dart';
import '../../views/device_settings/device_settings_view.dart';
import '../../views/device_settings/edit_device/edit_device_view.dart';
import '../../views/guide/guide_view.dart';
import '../../views/home/root_view.dart';
import '../../views/setup/setup_view.dart';
import '../../views/splash/splash_view.dart';
import '../../views/zones/zones_view.dart';

class AppRoutes {
  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';
  static const String deviceSettingsRoute = '/deviceSettings';
  static const String applicationSettingsRoute = '/applicationSettings';
  static const String editDeviceRoute = '/editDevice';
  static const String customizeHomeRoute = '/customizeHome';
  static const String editRelayRoute = '/editRelay';
  static const String chargeDeviceRoute = '/chargeDevice';
  static const String addDeviecRoute = '/addDevice';
  static const String zonesRoute = '/zones';
  static const String contactsRoute = '/contacts';
  static const String aboutusRoute = '/aboutus';
  static const String guideRoute = '/guide';
  static const String advanceToolsRoute = '/advanceTools';
  static const String setupRoute = '/setup';

  static List<Route<dynamic>> onGenerateInitialRoute(String initialRouteName) {
    return <Route>[_materialRoute(const SplashView())];
  }

  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return _materialRoute(const SplashView());
      case homeRoute:
        return _materialRoute(const RootView());
      case deviceSettingsRoute:
        return _materialRoute(const DeviceSettingsView());
      case applicationSettingsRoute:
        return _materialRoute(const ApplicationSettingsView());
      case editDeviceRoute:
        return _materialRoute(const EditDeviceView());
      case customizeHomeRoute:
        return _materialRoute(const CustomizeHomeView());
      case editRelayRoute:
        return _materialRoute(const EditRelayView());
      case chargeDeviceRoute:
        return _materialRoute(const ChargeDeviceView());
      case addDeviecRoute:
        return _materialRoute(const AddDeviceView());
      case zonesRoute:
        return _materialRoute(const ZonesView());
      case contactsRoute:
        return _materialRoute(const ContactsView());
      case aboutusRoute:
        return _materialRoute(const AboutUsView());
      case guideRoute:
        return _materialRoute(const GuideView(scrollToIndex: 0));
      case advanceToolsRoute:
        return _materialRoute(const AdvanceToolsView());
      case setupRoute:
        return _materialRoute(const SetupView());
      default:
        return null;
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
