import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:tokenizer/tokenizer.dart';

import '../../core/constants/global_keys.dart';
import 'drawer_menu_widget.dart';
import 'mobile/home_view_mobile.dart';

class RootView extends StatelessWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyBaseWidget(
      mobileChild: _buildMobileView(context),
      hasScrollView: false,
    );
  }

  Widget _buildMobileView(BuildContext context) {
    return SliderDrawer(
      slideDirection: SlideDirection.RIGHT_TO_LEFT,
      isDraggable: false,
      appBar: null,
      key: kDrawerKey,
      sliderOpenSize: 0.78.sw,
      slider: const DrawerMenuWidget(),
      child: const HomeViewMobile(),
    );
  }
}
