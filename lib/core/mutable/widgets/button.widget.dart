import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wings/core/mutable/helpers/util.helper.dart';

import '../themes/theme.wings.dart';

class ButtonWidget extends StatelessWidget {
  final bool primaryStyle;
  final Color? bgColor;
  final Color? textColor;
  final String text;
  final double? height;
  final double? radius;
  final Function() onClick;

  /// height: height of the button between 0 to 1
  /// This class automatically calculated the value to screen height
  /// Leave it as null if you want to Wrap it With SizedBox to give it a special size
  const ButtonWidget({
    super.key,
    required this.text,
    required this.onClick,
    this.textColor,
    this.bgColor,
    this.height = 0.075,
    this.radius,
    this.primaryStyle = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor ??
              (primaryStyle ? WingsTheme.primaryColor : Colors.white),
        ),
        padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
        height: height?.wsh,
        child: Center(
          child: Text(
            text,
            style: !primaryStyle
                ? WingsTheme.body1
                    .copyWith(color: textColor ?? WingsTheme.primaryColor)
                : WingsTheme.body1.copyWith(color: textColor ?? Colors.white),
          ),
        ),
      ),
    );
  }
}
