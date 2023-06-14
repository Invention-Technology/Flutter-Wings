import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../mutable/themes/theme.wings.dart';
import 'main.wings.dart';
import 'translations/language.wings.dart';

class WingsApp extends StatelessWidget {
  final String title;
  final Map<String, Map<String, String>>? translationsKeys;
  final TextDirection? textDirection;
  final Locale? locale;
  final ThemeData? darkTheme;
  final ThemeMode themeMode;
  final Widget? home;

  WingsApp({
    required this.title,
    this.translationsKeys,
    this.textDirection = WingsLanguage.defaultTextDirection,
    this.locale,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.home,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Wings.locale, // OR Locale('ar', 'AE') OR Other RTL locales
          ],
          locale: Wings.locale,
          debugShowCheckedModeBanner: false,
          navigatorKey: Wings.key,
          title: title,
          theme: ThemeData(
            primarySwatch: WingsTheme.primarySwatch,
            scaffoldBackgroundColor: WingsTheme.scaffoldBackgroundColor,
            fontFamily: WingsTheme.fontFamily,
          ),
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: child,
        );
      },
      child: home,
    );
  }
}
