import 'package:flutter/material.dart';
import 'reactive.binding.dart';

typedef WidgetReturn = Widget Function(WingsReactive controller);

class Wx extends StatelessWidget {
  final WidgetReturn builder;
  final WingsReactive controller;

  const Wx({
    Key? key,
    required this.controller,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.stream,
      builder: (context, shot) {
        return builder(controller);
      },
    );
  }
}
