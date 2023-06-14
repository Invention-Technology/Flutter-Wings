import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgWidget extends StatelessWidget {
  final String icon;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;

  const SvgWidget(
    this.icon, {
    super.key,
    this.height,
    this.width,
    this.color,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$icon',
      height: height,
      width: width,
      fit: fit ?? BoxFit.contain,
      color: color,
    );
  }
}
