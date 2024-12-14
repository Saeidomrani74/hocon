import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

import '../../../core/constants/asset_constants.dart';
import '../../../providers/splash_provider.dart';

class SplashViewMobile extends StatelessWidget {
  late SplashProvider _splashProvider;

  SplashViewMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _splashProvider = context.read<SplashProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(600.milliseconds).then(
        (value) => _splashProvider.initialSetup(),
      );
    });
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0.5.sw),
        child: Material(
          color: Colors.white,
          elevation: 8.0,
          child: Container(
            padding: EdgeInsets.all(6.w),
            width: 160.w,
            height: 160.w,
            child: Image.asset(kIconLauncherAsset),
          ),
        ),
      ),
    );
  }
}
