import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import 'config/routes/app_routes.dart';
import 'config/themes/app_themes.dart';
import 'core/constants/design_values.dart';
import 'core/constants/global_keys.dart';
import 'injector.dart';
import 'providers/add_device_provider.dart';
import 'providers/advance_tools_provider.dart';
import 'providers/app_settings_provider.dart';
import 'providers/charge_device_provider.dart';
import 'providers/contacts_provider.dart';
import 'providers/device_settings_provider.dart';
import 'providers/home_provider.dart';
import 'providers/main_provider.dart';
import 'providers/setup_provider.dart';
import 'providers/splash_provider.dart';
import 'providers/zones_provider.dart';
import 'repository/cache_repository.dart';

late LocalizationDelegate delegate;
ThemeData themeData = AppThemes.palette1;

Future main() async {
  await startupSetup();
  await getThemeFromDatabase();
  runApp(
    LocalizedApp(
      delegate,
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MainProvider>(
            create: (_) => MainProvider(),
          ),
          ChangeNotifierProxyProvider<MainProvider, AddDeviceProvider>(
            create: (_) => AddDeviceProvider(null),
            update: (context, main, addDevice) => AddDeviceProvider(main),
          ),
          ChangeNotifierProxyProvider<MainProvider, AdvanceToolsProvider>(
            create: (_) => AdvanceToolsProvider(null),
            update: (context, main, advanceTools) => AdvanceToolsProvider(main),
          ),
          ChangeNotifierProxyProvider<MainProvider, AppSettingsProvider>(
            create: (_) => AppSettingsProvider(null),
            update: (context, main, appSettings) => AppSettingsProvider(main),
          ),
          ChangeNotifierProxyProvider<MainProvider, ChargeDeviceProvider>(
            create: (_) => ChargeDeviceProvider(null),
            update: (context, main, chargeDevice) => ChargeDeviceProvider(main),
          ),
          ChangeNotifierProxyProvider<MainProvider, ContactsProvider>(
            create: (_) => ContactsProvider(null),
            update: (context, main, contacts) => ContactsProvider(main),
          ),
          ChangeNotifierProxyProvider<MainProvider, DeviceSettingsProvider>(
            create: (_) => DeviceSettingsProvider(null),
            update: (context, main, deviceSettings) =>
                DeviceSettingsProvider(main),
          ),
          ChangeNotifierProxyProvider<MainProvider, SplashProvider>(
            create: (_) => SplashProvider(null),
            update: (context, main, splash) => SplashProvider(main),
          ),
          ChangeNotifierProxyProvider<MainProvider, ZonesProvider>(
            create: (_) => ZonesProvider(null),
            update: (context, main, zones) => ZonesProvider(main),
          ),
          ChangeNotifierProxyProvider2<MainProvider, ChargeDeviceProvider,
              HomeProvider>(
            create: (_) => HomeProvider(null, null),
            update: (context, main, chargeDevice, home) => HomeProvider(
              main,
              chargeDevice,
            ),
          ),
          ChangeNotifierProxyProvider<MainProvider, SetupProvider>(
            create: (_) => SetupProvider(null),
            update: (context, main, setup) => SetupProvider(main),
          ),
        ],
        child: MyApp(themeData: themeData),
      ),
    ),
  );
}

Future startupSetup() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Configure dependency injections
  await initializeDependencies();

  /// configure localization
  delegate = await LocalizationDelegate.create(
    fallbackLocale: 'fa',
    supportedLocales: ['fa'],
  );

  /// If the OS is `not web`
  if (!kIsWeb) {
    /// Open app only in `portrait` mode
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );

    /// Sets device `status bar` and `navigation bar` color
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }
}

Future getThemeFromDatabase() async {
  await injector<CacheRepository>().getAppSettings().then(
    (value) {
      if (value != null) {
        if (value.selectedThemePalette == 0) {
          themeData = AppThemes.palette1;
        } else if (value.selectedThemePalette == 1) {
          themeData = AppThemes.palette2;
        } else if (value.selectedThemePalette == 2) {
          themeData = AppThemes.palette3;
        }
      }
    },
  );
}

class MyApp extends StatelessWidget {
  final ThemeData themeData;
  const MyApp({
    Key? key,
    required this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: ScreenUtilInit(
        designSize: kDesignSizeMobile,
        minTextAdapt: false,
        builder: (_, __) => MaterialApp(
          navigatorKey: kNavigatorKey,
          scaffoldMessengerKey: rootScaffoldMessengerKey,
          title: translate('app_title'),
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            localizationDelegate,
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
          debugShowCheckedModeBanner: false,
          theme: themeData,
          onGenerateRoute: AppRoutes.onGenerateRoutes,
          onGenerateInitialRoutes: AppRoutes.onGenerateInitialRoute,
        ),
      ),
    );
  }
}
