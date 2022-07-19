import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wings/core/immutable/translations/language.wings.dart';

import 'main.wings.dart';

class WingsApp extends StatefulWidget {
  final String title;
  final Map<String, Map<String, String>>? translationsKeys;
  final TextDirection? textDirection;
  final Locale? locale;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode themeMode;
  final Widget? home;

  const WingsApp({
    required this.title,
    this.translationsKeys,
    this.textDirection = WingsLanguage.defaultTextDirection,
    this.locale,
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.home,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WingsAppState();
}

class _WingsAppState extends State<WingsApp> {
  @override
  void initState() {
    Wings.init(context: context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: widget.theme,
      darkTheme: widget.darkTheme,
      themeMode: widget.themeMode,
      home: widget.home,
      locale: widget.locale ?? Wings.language.currentLanguage.locale,
    );
  }

}
