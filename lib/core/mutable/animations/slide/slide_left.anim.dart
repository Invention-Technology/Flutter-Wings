import 'package:flutter/material.dart';

import 'slide.anim.dart';

class SlideLeftAnim extends StatelessWidget {
  final Widget child;
  final double leftMargin;
  final Duration duration;

  const SlideLeftAnim({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.leftMargin = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    return SlideAnim(
      begin: Offset(leftMargin, 0.0),
      end: Offset.zero,
      duration: duration,
      child: child,
    );
  }
}
