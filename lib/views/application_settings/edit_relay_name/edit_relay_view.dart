import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokenizer/tokenizer.dart';

import '../../../core/utils/enums.dart';
import '../../../widgets/custom_appbar_widget.dart';
import 'mobile/edit_relay_view_mobile.dart';

class EditRelayView extends StatelessWidget {
  const EditRelayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyBaseWidget(
      platformAppBar: const CustomAppbarWidget(
        menu: MenuItems.editRelay,
        hasHelper: false,
      ).build(context),
      mobileChild: EditRelayViewMobile(),
    );
  }
}
