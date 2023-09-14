import 'package:flutter/material.dart';

import 'reactive.binding.dart';

typedef WidgetReturn = Widget Function(WingsReactive controller);

class Wx extends StatefulWidget {
  final WidgetReturn builder;
  final WingsReactive controller;

  const Wx({
    Key? key,
    required this.controller,
    required this.builder,
  }) : super(key: key);

  @override
  State<Wx> createState() => _WxState();
}

class _WxState extends State<Wx> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.controller.stream,
      builder: (context, shot) {
        return widget.builder(widget.controller);
      },
    );
  }
}

typedef BuildReturn = Widget Function(dynamic controller);

class Lx extends StatefulWidget {
  final BuildReturn builder;
  final ValueNotifier controller;

  const Lx({
    Key? key,
    required this.controller,
    required this.builder,
  }) : super(key: key);

  @override
  State<Lx> createState() => _LxState();
}

class _LxState extends State<Lx> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (context, value, child) {
        return widget.builder(value);
      },
    );
  }
}

class WingsConsumer<T> extends InheritedWidget {
  final T provider;
  final Widget Function(T provider) builder;

  WingsConsumer({
    required this.provider,
    required this.builder,
    Key? key,
    Widget? child,
  }) : super(key: key, child: child ?? const SizedBox());

  static WingsConsumer? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WingsConsumer>();
  }

  @override
  bool updateShouldNotify(WingsConsumer oldWidget) {
    return provider != oldWidget.provider;
  }
}
