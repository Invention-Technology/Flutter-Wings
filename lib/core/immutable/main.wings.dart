import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wings/core/immutable/translations/lang.controller.wings.dart';
import 'package:wings/core/immutable/translations/language.wings.dart';

import 'base/views/view.wings.dart';
import 'providers/main.provider.wings.dart';

class Wings {
  static Wings? _instance;

  static Wings get instance {
    _instance ??= Wings();

    return _instance!;
  }

  /// This is the initialization of the main class of Wings framework
  /// and it should be called before runApp() is called
  static Future<void> init() async {
    _instance ??= Wings();
    await DataProvider.init();
  }

  WingsLanguage defaultLanguage = WingsLanguage(
    locale: const Locale('ar', 'ye'),
    textDirection: TextDirection.rtl,
  );

  static DataProvider get provider => DataProvider.instance;

  static WingsLanguageController get language =>
      WingsLanguageController.instance;

  static void push(WingsView page, {dynamic args}) async {
    for (var middleware in page.middlewares) {
      dynamic boot = await middleware.boot();
      if (boot != true) {
        log((boot is WingsView).toString());
        if (boot is WingsView) {
          return Get.to(() => boot);
        } else {
          return;
        }
      }
    }

    Get.to(() => page, arguments: args);
  }
}
