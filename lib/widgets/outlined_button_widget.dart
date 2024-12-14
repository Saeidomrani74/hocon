import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/helper.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String btnText;
  final IconData? btnIcon;
  final Function()? onPressBtn;

  const OutlinedButtonWidget({
    Key? key,
    required this.btnText,
    this.width,
    this.height,
    this.onPressBtn,
    this.btnIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 0.4.sw,
      height: height ?? 40.h,
      child: OutlinedButton(
        onPressed: onPressBtn,
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (btnIcon != null) ...[
                Icon(
                  btnIcon,
                  color: Theme.of(context).colorScheme.surface,
                  size: 18.w,
                ),
                SizedBox(width: 6.w),
              ],
              Text(
                btnText,
                style: styleGenerator(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontColor: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
