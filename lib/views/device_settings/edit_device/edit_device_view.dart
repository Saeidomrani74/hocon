import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokenizer/tokenizer.dart';

import '../../../core/utils/enums.dart';
import '../../../widgets/custom_appbar_widget.dart';
import 'mobile/edit_device_view_mobile.dart';

class EditDeviceView extends StatelessWidget {
  const EditDeviceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyBaseWidget(
      platformAppBar: const CustomAppbarWidget(
        menu: MenuItems.editDevice,
        hasHelper: false,
      ).build(context),
      mobileChild: const EditDeviceViewMobile(),
    );
  }
}
