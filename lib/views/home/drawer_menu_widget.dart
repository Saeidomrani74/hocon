import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../config/routes/app_routes.dart';
import '../../core/constants/asset_constants.dart';
import '../../core/constants/global_keys.dart';
import '../../core/utils/helper.dart';

class DrawerMenuWidget extends StatelessWidget {
  const DrawerMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: <Widget>[
              SizedBox(height: 40.h),
              _buildHeaderImage(),
              SizedBox(height: 30.h),
              sliderItem(
                translate('add_device'),
                Icons.add_circle,
                () {
                  closeDrawerAndRoute(AppRoutes.addDeviecRoute, context);
                },
              ),
              sliderItem(
                translate('charge_device'),
                Icons.attach_money_rounded,
                () {
                  closeDrawerAndRoute(AppRoutes.chargeDeviceRoute, context);
                },
              ),
              sliderItem(
                translate('device_setting'),
                Icons.settings,
                () {
                  closeDrawerAndRoute(AppRoutes.deviceSettingsRoute, context);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.white54,
                ),
              ),
              sliderItem(
                translate('advance_tools'),
                Icons.settings_input_component_rounded,
                () {
                  closeDrawerAndRoute(AppRoutes.advanceToolsRoute, context);
                },
              ),
              sliderItem(
                translate('contacts'),
                Icons.phone,
                () {
                  closeDrawerAndRoute(AppRoutes.contactsRoute, context);
                },
              ),
              sliderItem(
                translate('zones'),
                Icons.control_camera,
                () {
                  closeDrawerAndRoute(AppRoutes.zonesRoute, context);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.white54,
                ),
              ),
              sliderItem(
                translate('android_app_settings'),
                Icons.settings_cell_rounded,
                () {
                  closeDrawerAndRoute(
                    AppRoutes.applicationSettingsRoute,
                    context,
                  );
                },
              ),
              sliderItem(
                translate('guide'),
                Icons.help,
                () {
                  closeDrawerAndRoute(AppRoutes.guideRoute, context);
                },
              ),
              sliderItem(
                translate('about_us'),
                Icons.info,
                () {
                  closeDrawerAndRoute(AppRoutes.aboutusRoute, context);
                },
              ),
              sliderItem(
                translate('exit'),
                Icons.exit_to_app,
                exitApp,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return CircleAvatar(
      radius: 60.w,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 55.w,
        backgroundColor: Colors.white,
        backgroundImage: const AssetImage(kIconLauncherAsset),
      ),
    );
  }

  void closeDrawerAndRoute(String routeName, BuildContext context) {
    kDrawerKey.currentState!.toggle();
    Navigator.pushNamed(context, routeName);
  }

  void exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

  Widget sliderItem(String title, IconData icons, Function()? onItemClick) =>
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onItemClick,
          child: ListTile(
            contentPadding: EdgeInsets.only(right: 20.w),
            title: Text(
              title,
              style: styleGenerator(fontSize: 14, fontColor: Colors.white),
            ),
            leading: Icon(icons, color: Colors.white60),
          ),
        ),
      );
}
