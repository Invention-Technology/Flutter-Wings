import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wings/core/mutable/themes/theme.wings.dart';

import '../utils.widget.dart';

class InputText extends StatefulWidget {
  TextEditingController? controller;
  TextInputType? keyboardType;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final String? initialValue;
  late String title;
  bool disable;
  Function? validator;
  GestureTapCallback? onTab;
  List<TextInputFormatter>? inputFormatters;
  String? suffixText;
  String? prefixText;
  Widget? suffix;
  bool obscureText;
  TextDirection? textDirection;
  bool isOptional;
  String? titlePrefixIcon;
  String value;
  Color? borderColor;
  Color? activeBorderColor;
  Function(String text)? onChanged;
  Function()? onComplete;
  Function(dynamic selected)? onFocusChanged;
  EdgeInsets? padding;
  int maxLines;
  Color? shadowColor;
  double? yOffset;
  bool? autoFocus;

  InputText({
    Key? key,
    this.controller,
    this.keyboardType,
    required this.title,
    this.focusNode,
    this.nextNode,
    this.validator,
    this.onTab,
    this.disable = false,
    this.obscureText = false,
    this.inputFormatters,
    this.suffixText,
    this.prefixText,
    this.suffix,
    this.isOptional = false,
    this.initialValue,
    this.titlePrefixIcon,
    this.borderColor,
    this.activeBorderColor,
    this.textDirection,
    this.value = '',
    this.onChanged,
    this.onComplete,
    this.padding,
    this.maxLines = 1,
    this.shadowColor,
    this.autoFocus,
    this.yOffset,
    this.onFocusChanged,
  }) : super(key: key);

  @override
  _FormFieldComponentsState createState() => _FormFieldComponentsState();
}

class _FormFieldComponentsState extends State<InputText> {
  Color borderColor = Colors.white;
  Color textColor = Colors.grey;
  bool dirChanged = false;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    if (widget.textDirection == TextDirection.rtl && !dirChanged) {
      var temp = widget.suffixText;
      widget.suffixText = widget.prefixText;
      widget.prefixText = temp;
      dirChanged = true;
    }

    if (widget.borderColor != null) {
      borderColor = widget.borderColor!;
    }

    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 0.03.sw),
        decoration: BoxDecoration(
          color: widget.disable ? const Color(0xffDDE5ED) : Colors.white,
          boxShadow: [
            BoxShadow(
                color: widget.shadowColor ?? Colors.black12,
                blurRadius: 10,
                offset: Offset(0.0, widget.yOffset ?? 4.0)),
          ],
        ),
        child: Column(
          children: [
            Focus(
              onFocusChange: (selected) {
                this.selected = selected;

                setState(() {
                  if (selected) {
                    borderColor = widget.activeBorderColor ?? Colors.blue;
                    textColor = Colors.blue;
                  } else {
                    borderColor = widget.borderColor ?? Colors.white;
                  }
                });

                if (widget.onFocusChanged != null) {
                  widget.onFocusChanged!(selected);
                }
              },
              child: SizedBox(
                height: constraint.maxHeight * 0.9,
                child: TextFormField(
                  autofocus: widget.autoFocus ?? false,
                  onEditingComplete: widget.onComplete,
                  initialValue: widget.initialValue,
                  enabled: !(widget.disable),
                  onTap: widget.onTab,
                  textDirection: widget.textDirection,
                  keyboardType: widget.keyboardType,
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  inputFormatters: widget.inputFormatters,
                  obscureText: widget.obscureText,
                  maxLines: widget.maxLines,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(widget.nextNode);
                  },
                  onChanged: (value) {
                    widget.value = value;

                    /*if (value.isNotEmpty) {
                        setState(() {
                          borderColor = widget.activeBorderColor ?? Colors.blue;
                          textColor = Colors.blue;
                        });
                      } else {
                        setState(() {
                          borderColor = widget.borderColor ?? Colors.white;
                        });
                      }*/

                    if (widget.onChanged != null) {
                      widget.onChanged!(value);
                    }
                    return;
                  },
                  validator: (value) {
                    if (widget.validator != null) {
                      String? val = widget.validator!(value);
                      if (val != null) {
                        setState(() {
                          borderColor = Colors.red;
                          textColor = Colors.red;
                        });
                        return val;
                      } else {
                        setState(() {
                          borderColor = widget.activeBorderColor ?? Colors.blue;
                        });
                      }
                    }
                    return null;
                  },
                  style: WingsTheme.bigScreen ? WingsTheme.body1 : WingsTheme.body1Point5,
                  decoration: InputDecoration(
                    suffixText: widget.suffixText,
                    prefixText: widget.prefixText,
                    suffixIcon: widget.suffix,
                    border: InputBorder.none,
                    suffixIconConstraints: const BoxConstraints(maxHeight: 26),
                    isDense: true,
                    contentPadding: const EdgeInsets.only(top: 10),
                    errorMaxLines: 1,
                    errorStyle: const TextStyle(height: .1),
                    constraints: const BoxConstraints(maxHeight: 46),
                    label: LayoutBuilder(
                        builder: (context, constraint) {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: (!selected
                                  ? (widget.value.isEmpty ? (constraint.maxHeight * .1) : 0)
                                  : 0),
                            ),
                            child: widget.title.toDynamicBody1Text,
                          );
                        }
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
