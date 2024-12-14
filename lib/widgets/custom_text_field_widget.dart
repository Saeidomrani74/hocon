import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final int maxLength;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final InputBorder? inputBorder;
  final String floatingText;
  final TextStyle? errorStyle;
  final String errorText;
  final InputBorder? focusedBorder;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle inputStyle;
  final bool hasFloatingPlaceholder;
  final TextInputType keyboardType;
  final TextDirection? textDirection;
  final void Function(String)? onSubmit;
  final Function(String)? onChange;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;

  const CustomTextFieldWidget({
    Key? key,
    this.maxLength = 30,
    this.controller,
    this.obscureText = false,
    this.inputBorder,
    this.floatingText = '',
    this.errorStyle,
    this.focusedBorder,
    this.hintText = '',
    this.hintStyle,
    required this.inputStyle,
    this.hasFloatingPlaceholder = false,
    this.keyboardType = TextInputType.phone,
    this.onSubmit,
    this.errorText = '',
    this.onChange,
    this.textDirection,
    this.focusNode,
    this.textAlign = TextAlign.center,
    this.inputFormatters,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode ?? FocusNode(),
      maxLength: maxLength,
      controller: controller,
      obscureText: obscureText,
      textAlignVertical: TextAlignVertical.top,
      textAlign: textAlign,
      textDirection: textDirection,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        border: inputBorder,
        errorText: errorText,
        errorStyle: errorStyle,
        enabledBorder: inputBorder,
        focusedBorder: focusedBorder,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        errorBorder: inputBorder,
        focusedErrorBorder: focusedBorder,
        hintText: hasFloatingPlaceholder ? null : hintText,
        hintStyle: hintStyle ?? inputStyle,
        counterText: '',
        alignLabelWithHint: true,
        floatingLabelBehavior: hasFloatingPlaceholder
            ? FloatingLabelBehavior.auto
            : FloatingLabelBehavior.never,
        labelText: floatingText,
        labelStyle: hintStyle ?? inputStyle,
      ),
      keyboardType: keyboardType,
      textInputAction: TextInputAction.done,
      onSubmitted: onSubmit,
      style: inputStyle,
      onChanged: onChange,
      onTap: onTap,
    );
  }
}
