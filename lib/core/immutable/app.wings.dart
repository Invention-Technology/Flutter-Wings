import 'package:flutter/material.dart';
import 'package:wings/core/immutable/translations/language.wings.dart';

import 'main.wings.dart';

class WingsApp extends StatelessWidget {
  final String title;
  final Map<String, Map<String, String>>? translationsKeys;
  final TextDirection? textDirection;
  final Locale? locale;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode themeMode;
  final Widget? home;

  WingsApp({
    required this.title,
    this.translationsKeys,
    this.textDirection = WingsLanguage.defaultTextDirection,
    this.locale,
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.home,
    Key? key,
  }) : super(key: key) {
    Wings.init();
  }

  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      navigatorKey: Wings.key,
      title: title,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: home,
      locale: locale ?? Wings.locale,
    );

    return materialApp;
  }

}
