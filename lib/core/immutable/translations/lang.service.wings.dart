import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../main.wings.dart';
import 'language.wings.dart';

class WingsLanguageService {
  static const languageKey = 'APP_LANGUAGE';
  static var defaultLang = Wings.instance.defaultLanguage;

  static WingsLanguageService? _instance;

  static WingsLanguageService get instance {
    _instance ??= WingsLanguageService();

    return _instance!;
  }

  WingsLanguageService() {
    init();
  }

  late WingsLanguage currentLang;

  Future<WingsLanguageService> init() async {
    final deviceLocale = ui.window.locale; // get the current device language
    Locale locale = defaultLang.locale;
    TextDirection direction = defaultLang.textDirection;

    // get the user language form the locale storage
    var appLanguage = read(languageKey);

    if (appLanguage != null) {
      WingsLanguage language = WingsLanguage.fromJson(appLanguage);
      locale = language.locale;
      direction = language.textDirection;
    } else if (deviceLocale.languageCode.toLowerCase() == 'en') {
      // if the user didn't change the lang get the device lang
      locale = const Locale('en');
      direction = TextDirection.ltr;
    }

    currentLang = WingsLanguage(
      locale: locale,
      textDirection: direction,
    );

    updateLocale(currentLang.locale);
    return this;
  }

  // write the user language to the locale storage
  void write(String key, dynamic value) {
    Wings.provider.local.save(key: key, value: value);
  }

  //read the user language from the locale storage
  read(String key) {
    return Wings.provider.local.get(key: key);
  }

  Future<void> updateLocale(Locale l) async {
    Wings.locale = l;
    await WidgetsFlutterBinding.ensureInitialized().performReassemble();
  }
}
