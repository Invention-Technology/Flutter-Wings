import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/simple/dropdown.model.dart';
import '../../themes/theme.wings.dart';

class DropDownInput extends StatelessWidget {
  final List<DropDownModel> items;
  final Function(dynamic) onChange;
  final EdgeInsets? padding;
  final dynamic value;
  bool disable;
  Color? borderColor;
  Color? shadowColor;
  double? yOffset;

  DropDownInput({
    Key? key,
    required this.items,
    required this.onChange,
    this.disable = false,
    this.value,
    this.padding,
    this.borderColor,
    this.shadowColor,
    this.yOffset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? EdgeInsets.symmetric(vertical: 8.h, horizontal: 0.01.sw),
      decoration: BoxDecoration(
        color: disable ? const Color(0xffDDE5ED) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Colors.black12,
            blurRadius: 10,
            offset: Offset(0.0, yOffset ?? 4.0),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(right: 6.w),
            child: DropdownButtonHideUnderline(
              child: Center(
                child: DropdownButton(
                    underline: null,
                    icon: const Visibility(
                      visible: false,
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    borderRadius: WingsTheme.inputRadius,
                    onChanged: disable ? null : onChange,
                    isExpanded: true,
                    isDense: true,
                    style: WingsTheme.body1,
                    value: value,
                    alignment: Alignment.centerRight,
                    focusColor: Colors.transparent,
                    dropdownColor: Colors.white,
                    items: items.map((element) {
                      return DropdownMenuItem(
                        value: element.key,
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          element.value.trim(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      );
                    }).toList()),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-1, 0.0),
            child: IgnorePointer(
              child: Icon(
                Icons.expand_circle_down,
                color: WingsTheme.greyedOut,
              ),
            ),
          )
        ],
      ),
    );
  }
}
