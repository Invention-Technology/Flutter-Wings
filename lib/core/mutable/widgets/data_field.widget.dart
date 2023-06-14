import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wings/core/mutable/helpers/util.helper.dart';
import 'package:wings/core/mutable/themes/theme.wings.dart';

class DataFieldWidget extends StatelessWidget {
  final dynamic title;
  final dynamic body;
  final String? prefix;
  final String? suffix;
  final Color? shadowColor;
  final double? yOffset;
  final Widget? trailing;
  final dynamic trailingText;
  final Widget? leading;
  final dynamic leadingText;
  final bool oneLine;
  final Color? textColor;
  final VoidCallback? onClick;

  const DataFieldWidget({
    super.key,
    required this.title,
    required this.body,
    this.prefix,
    this.suffix,
    this.shadowColor,
    this.yOffset,
    this.trailing,
    this.trailingText,
    this.leading,
    this.leadingText,
    this.oneLine = false,
    this.textColor,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    if (body != null && body.toString().isNotEmpty && body != "null") {
      return GestureDetector(
        onTap: onClick,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: shadowColor ?? WingsTheme.shadowColor,
                blurRadius: 10,
                blurStyle: BlurStyle.inner,
                spreadRadius: 1,
                offset: Offset(0.0, yOffset ?? 1.0),
              ),
            ],
          ),
          margin:
              EdgeInsets.symmetric(vertical: 0.0075.wsh, horizontal: 0.005.sw),
          child: ListTile(
            title: Padding(
              padding: EdgeInsets.only(bottom: 0.01.wsh, top: 0.005.wsh),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title.toString(),
                      style: (oneLine ? WingsTheme.body2 : WingsTheme.body2)
                          .copyWith(
                        color: WingsTheme.secondTextColor,
                      ),
                      maxLines: oneLine ? null : 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (oneLine)
                    SizedBox(
                      width: 0.03.sw,
                    ),
                  if (oneLine)
                    Text(
                      body.toString(),
                      style: WingsTheme.body2.copyWith(
                        color: textColor ?? WingsTheme.secondTextColor,
                      ),
                    ),
                ],
              ),
            ),
            subtitle: oneLine
                ? null
                : Padding(
                    padding: EdgeInsets.only(bottom: 0.01.wsh),
                    child: Text(
                      '${prefix ?? ''} $body ${suffix ?? ''}',
                      style: WingsTheme.body1.copyWith(
                        color: textColor ?? WingsTheme.textColor,
                      ),
                    ),
                  ),
            trailing: trailingText != null
                ? Text(
                    trailingText!.toString(),
                    style: WingsTheme.body1.copyWith(
                      color: WingsTheme.primaryColor,
                    ),
                  )
                : trailing,
            leading: leadingText != null
                ? Text(
                    leadingText!.toString(),
                    style: WingsTheme.body1.copyWith(
                      color: WingsTheme.primaryColor,
                    ),
                  )
                : leading,
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
