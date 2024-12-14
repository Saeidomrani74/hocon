import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokenizer/tokenizer.dart';

import '../../core/utils/enums.dart';
import '../../widgets/custom_appbar_widget.dart';
import 'mobile/contacts_view_mobile.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyBaseWidget(
      platformAppBar:
          const CustomAppbarWidget(menu: MenuItems.contacts).build(context),
      mobileChild: const ContactsViewMobile(),
    );
  }
}
