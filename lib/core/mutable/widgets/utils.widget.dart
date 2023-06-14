import 'package:flutter/material.dart';

import '../themes/theme.wings.dart';
import 'online_images.widget.dart';
import 'svg.widget.dart';

extension ToSvg on String {
  Widget get toSvg => SvgWidget(this);
}

extension ToImage on String {
  Widget get toOnlineImage => OnlineImages(imageUrl: this);

  Widget get toImage => Image.asset('assets/images/$this');
}

extension ToText on String {
  Text get toDynamicBody1Text =>
      WingsTheme.bigScreen ? toBody2Text : toBody1Text;

  Text get toBody1Text => Text(this, style: WingsTheme.body1);

  Text get toBody1Point5Text => Text(this, style: WingsTheme.body1Point5);

  Text get toBody2Text => Text(this, style: WingsTheme.body2);

  Text get toHeadingText => Text(this, style: WingsTheme.heading);

  Text get toHeading500Text => Text(this, style: WingsTheme.heading500);

  Text get toBigHeadingText => Text(this, style: WingsTheme.bigHeading);
}
