import 'package:flutter/material.dart';

import '../../../mutable/statics/error_asset.static.wings.dart';
import '../../../mutable/translations/languages/translation.mapper.dart';
import 'exceptions.wings.dart';

class ErrorModel {
  String message;
  Color borderColor;
  Color backgroundColor;
  String icon = WingsErrorAssets.defaultIcon;
  String image = WingsErrorAssets.defaultImage;
  WingsException? exception;
  bool hideRetry;

  ErrorModel({
    this.message = '',
    this.borderColor = const Color(0xffFF434F),
    this.backgroundColor = const Color(0xffFEE8E9),
    this.icon = '',
    this.image = '',
    this.exception,
    this.hideRetry = false,
  }) {
    if (message.isEmpty)
      message = 'Error:${exception?.runtimeType.toString()}'.tr;
    if (icon.isEmpty) icon = WingsErrorAssets.defaultIcon;
    if (image.isEmpty) image = WingsErrorAssets.defaultImage;
    exception ??= WingsException.fromEnumeration();
  }
}
