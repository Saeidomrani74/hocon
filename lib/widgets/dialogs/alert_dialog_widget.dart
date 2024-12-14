import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../core/utils/helper.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final Widget? contentWidget;
  final String contentText;
  final bool showCancel;
  final bool showAccept;
  final String? confirmBtnText;
  final Function()? onPressCancel;
  final Function()? onPressAccept;
  const AlertDialogWidget({
    Key? key,
    required this.title,
    this.contentWidget,
    required this.contentText,
    this.showCancel = true,
    this.showAccept = true,
    this.confirmBtnText,
    this.onPressCancel,
    this.onPressAccept,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: styleGenerator(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: contentWidget ??
            Text(
              contentText,
              style: styleGenerator(fontSize: 14),
            ),
      ),
      contentPadding: EdgeInsets.only(right: 20.w, left: 20.w, top: 10.h),
      actions: <Widget>[
        _buildCancelButton(context),
        _buildAcceptButton(context),
      ],
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return Visibility(
      visible: showCancel,
      child: TextButton(
        onPressed: onPressCancel ?? () => Navigator.pop(context),
        child: Text(
          translate('cancel'),
          style: styleGenerator(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            fontColor: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Widget _buildAcceptButton(BuildContext context) {
    return Visibility(
      visible: showAccept,
      child: TextButton(
        onPressed: onPressAccept ?? () => Navigator.pop(context),
        child: Text(
          confirmBtnText ?? translate('accept'),
          style: styleGenerator(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontColor: confirmBtnText == translate('remove')
                ? Colors.red
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
