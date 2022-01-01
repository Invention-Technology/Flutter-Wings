import 'dart:ui';

import 'package:get/get.dart';

import 'lang.service.wings.dart';
import 'language.wings.dart';

class WingsLanguageController extends GetxController {
  WingsLanguageService get _langService => WingsLanguageService.instance;
  WingsLanguage currentLanguage = WingsLanguageService.defaultLang;

  static WingsLanguageController? _instance;

  static WingsLanguageController get instance {
    _instance ??= WingsLanguageController();

    return _instance!;
  }

  @override
  void onInit() async {
    super.onInit();
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

    Get.updateLocale(newLang.locale);
    currentLanguage = newLang;
    _langService.write(WingsLanguageService.languageKey, newLang);
    update();
  }
}
