import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

import '../config/routes/app_routes.dart';
import '../core/constants/global_keys.dart';
import '../core/utils/helper.dart';
import '../injector.dart';
import '../models/app_settings.dart';
import '../models/device.dart';
import '../repository/cache_repository.dart';
import 'main_provider.dart';

class SplashProvider extends ChangeNotifier {
  late MainProvider _mainProvider;
  //SharedPreferences? sharedPref;
  //String? _appSettingsInSP;
  final auth = LocalAuthentication();

  SplashProvider(MainProvider? mainProvider) {
    if (mainProvider != null) _mainProvider = mainProvider;
  }

  Future initialSetup() async {
    //sharedPref = await SharedPreferences.getInstance();
    //_appSettingsInSP = sharedPref!.getString(APP_SETTING);

    //TODO: Add data from SP to the new database if exist
    AppSettings? appSettings =
        await injector<CacheRepository>().getAppSettings();
    if (appSettings == null) {
      /// User is opening new version for the first time
      await _handleFirstTimeOpening();
    } else {
      /// User used new version before
      await _handleNotFirstTimeOpening();
    }
    kHomePageExpansionKeys =
        List.generate(_mainProvider.deviceListLength, (index) {
      return GlobalKey<ExpansionTileCardState>();
    });
    if (_mainProvider.appSettings.showPassPage) {
      _showAuthenticationView();
    } else {
      _initialRouteHandler();
    }
  }

  void _initialRouteHandler() {
    if (_mainProvider.selectedDevice.devicePhone.isEmpty) {
      Navigator.pushNamedAndRemoveUntil(
        kNavigatorKey.currentContext!,
        AppRoutes.setupRoute,
        ModalRoute.withName(AppRoutes.setupRoute),
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        kNavigatorKey.currentContext!,
        AppRoutes.homeRoute,
        ModalRoute.withName(AppRoutes.homeRoute),
      );
    }
  }

  Future _handleFirstTimeOpening() async {
    await _mainProvider.insertAppSettings(const AppSettings());
    await _mainProvider.insertDevice(const Device(id: 1));
    _mainProvider.setSelectedDevice();
  }

  Future _handleNotFirstTimeOpening() async {
    await _mainProvider.getAppSettings();
    await _mainProvider.getAllDevices();
    _mainProvider.setSelectedDevice();
    await _mainProvider.getAllRelays();
  }

  Future _showAuthenticationView() async {
    screenLock(
      context: kNavigatorKey.currentContext!,
      correctString: _mainProvider.appSettings.appPassword,
      digits: 6,
      title: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Text(
          translate('enter_pass_desc'),
          style: styleGenerator(
            fontWeight: FontWeight.w500,
            fontColor: Colors.white,
          ),
        ),
      ),
      customizedButtonChild: Icon(Icons.fingerprint, size: 45.w),
      footer: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 20.h),
        child: Text(
          translate('touch_fingerprint_desc'),
          style: styleGenerator(
            fontSize: 14,
            fontColor: Colors.white,
          ),
        ),
      ),
      customizedButtonTap: () async {
        if (await _localAuth(kNavigatorKey.currentContext!)) {
          _initialRouteHandler();
        }
      },
      cancelButton: const Icon(Icons.close),
      deleteButton: const Icon(Icons.delete),
      canCancel: false,
      didError: (c) {
        toastGenerator(translate('wrong_pass'));
      },
      didUnlocked: _initialRouteHandler,
    );
  }

  Future<bool> _localAuth(BuildContext context) async {
    bool didAuthenticate = false;
    await auth.isDeviceSupported().then((isSupported) async {
      if (isSupported) {
        await _checkBiometrics().then((value) async {
          if (value) {
            await _getAvailableBiometrics().then((value) async {
              if (value.contains(BiometricType.fingerprint)) {
                didAuthenticate = await auth.authenticate(
                  localizedReason: 'Please Authenticate',
                  authMessages: [
                    const AndroidAuthMessages(
                      biometricHint: '',
                      signInTitle: 'Biometric Authentication',
                    )
                  ],
                  options: const AuthenticationOptions(
                    stickyAuth: true,
                  ),
                );
              }
            });
          } else {
            toastGenerator(translate('no_biometric_permission'));
            return false;
          }
        });
      } else {
        toastGenerator(translate('no_fingerprint_exist'));
        return false;
      }
    });
    return didAuthenticate;
  }

  Future<bool> _checkBiometrics() async {
    try {
      return await auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  Future<List<BiometricType>> _getAvailableBiometrics() async {
    try {
      return await auth.getAvailableBiometrics();
    } on PlatformException {
      return <BiometricType>[];
    }
  }
}