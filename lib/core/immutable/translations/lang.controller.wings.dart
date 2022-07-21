import 'dart:ui';

import 'lang.service.wings.dart';
import 'language.wings.dart';

class WingsLanguageController {
  WingsLanguageService get _langService => WingsLanguageService.instance;
  WingsLanguage currentLanguage = WingsLanguageService.defaultLang;

  static WingsLanguageController? _instance;

  static WingsLanguageController get instance {
    _instance ??= WingsLanguageController();

    return _instance!;
  }

  WingsLanguageController() {
    onInit();
  }

  void onInit() async {
    currentLanguage = _langService.currentLang;
  }

  void updateLanguageSettings(String value) {
    var newLang = WingsLanguageService.defaultLang;

    if (value.toLowerCase() == 'en') {
      newLang = WingsLanguage(
        locale: const Locale('en', 'Us'),
        textDirection: TextDirection.ltr,
      );
    }

    currentLanguage = newLang;
    _langService.write(WingsLanguageService.languageKey, newLang);
    _langService.updateLocale(newLang.locale);
  }
}
