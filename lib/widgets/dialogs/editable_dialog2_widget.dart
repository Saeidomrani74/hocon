import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/helper.dart';

import '../custom_text_field_widget.dart';

class EditableDialog2Widget extends StatelessWidget {
  final List<TextEditingController> controllerList;
  final List<String> hintTextList;
  final int maxLength;
  final bool isObsecure;
  const EditableDialog2Widget({
    Key? key,
    required this.controllerList,
    required this.hintTextList,
    required this.maxLength,
    this.isObsecure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFieldWidget(
            controller: controllerList[0],
            hintStyle: styleGenerator(fontSize: 14, fontColor: Colors.black45),
            inputStyle: styleGenerator(fontSize: 14, fontColor: Colors.black45),
            onSubmit: (_) {},
            hintText: hintTextList[0],
            floatingText: hintTextList[0],
            maxLength: maxLength,
            hasFloatingPlaceholder: true,
            inputBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: Colors.black45),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2.w, color: Colors.black45),
            ),
            obscureText: isObsecure,
          ),
          CustomTextFieldWidget(
            controller: controllerList[1],
            hintStyle: styleGenerator(fontSize: 14, fontColor: Colors.black45),
            inputStyle: styleGenerator(fontSize: 14, fontColor: Colors.black45),
            onSubmit: (_) {},
            hintText: hintTextList[1],
            floatingText: hintTextList[1],
            maxLength: maxLength,
            hasFloatingPlaceholder: true,
            inputBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: Colors.black45),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2.w, color: Colors.black45),
            ),
            obscureText: isObsecure,
          ),
          CustomTextFieldWidget(
            controller: controllerList[2],
            hintStyle: styleGenerator(fontSize: 14, fontColor: Colors.black45),
            inputStyle: styleGenerator(fontSize: 14, fontColor: Colors.black45),
            onSubmit: (_) {},
            hintText: hintTextList[2],
            floatingText: hintTextList[2],
            maxLength: maxLength,
            hasFloatingPlaceholder: true,
            inputBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: Colors.black45),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2.w, color: Colors.black45),
            ),
            obscureText: isObsecure,
          ),
        ],
      ),
    );
  }
}
