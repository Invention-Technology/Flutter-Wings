import 'package:flutter/material.dart';

import 'slide.anim.dart';

class SlideRightAnim extends StatelessWidget {
  final Widget child;
  final double rightMargin;
  final Duration duration;

  const SlideRightAnim({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.rightMargin = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    return SlideAnim(
      begin: Offset.zero,
      end: Offset(rightMargin, 0.0),
      duration: duration,
      child: child,
    );
  }
}
