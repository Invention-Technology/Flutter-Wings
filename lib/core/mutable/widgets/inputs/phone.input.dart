import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/theme.wings.dart';

class PhoneInput extends StatelessWidget {
  final String hint;
  Widget? suffixIcon, suffix;
  TextEditingController? controller;
  bool obscureText;
  int maxLines;
  bool required;

  PhoneInput(
      {Key? key,
      required this.hint,
      this.suffixIcon,
      this.suffix,
      this.maxLines = 1,
      this.obscureText = false,
      this.required = true,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: WingsTheme.defaultRadius, color: Colors.white),
      child: TextFormField(
        style: WingsTheme.body1.copyWith(
          fontSize: 18.sp,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: false,
          signed: false,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(9),
        ],
        validator: (value) {
          value = value!.trim();
          if (value.isEmpty) {
            return 'قم بإدخال رقم الهاتف';
          } else if (!value.startsWith(RegExp(r'(7)(0|1|3|7)([0-9]{6})'))) {
            return 'رقم الهاتف غير صحيح';
          } else if (value.length < 9) {
            return 'قم بإكمال رقم الهاتف';
          }

          return null;
        },
        maxLines: maxLines,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          suffixIcon: suffixIcon,
          suffix: suffix,
          suffixIconConstraints:
              BoxConstraints(maxHeight: 30.h, maxWidth: 30.w),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h)
              .copyWith(top: 12.h),
        ),
      ),
    );
  }
}
