import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokenizer/tokenizer.dart';

import '../../core/utils/enums.dart';
import '../../widgets/custom_appbar_widget.dart';
import 'mobile/application_settings_view_mobile.dart';

class ApplicationSettingsView extends StatelessWidget {
  const ApplicationSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyBaseWidget(
      platformAppBar:
          const CustomAppbarWidget(menu: MenuItems.applicationSettings)
              .build(context),
      mobileChild: ApplicationSettingsViewMobile(),
    );
  }
}
