import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wings/core/immutable/base/controllers/controller.wings.dart';
import 'package:wings/core/immutable/translations/lang.controller.wings.dart';
import 'package:wings/core/immutable/translations/language.wings.dart';

import 'base/views/view.wings.dart';
import 'providers/main.provider.wings.dart';

part 'main/navigating.wings.dart';

class Wings {
  static Wings? _instance;

  static Wings get instance {
    _instance ??= Wings();

    return _instance!;
  }

  /// This is the initialization of the main class of Wings framework
  /// and it should be called before runApp() is called
  static Future<void> init({BuildContext? context}) async {
    _instance ??= Wings();

    instance._context = context;

    await DataProvider.init();
  }

  static WingsController add(WingsController controller, {String? tag}) {
    // if (controller.runtimeType is! WingsController) throw UnimplementedError();

    tag ??= controller.runtimeType.toString();

    if (!instance.controllers.containsKey(tag)) {
      instance.controllers.addAll({tag: controller});
    }

    log('$tag controller has been created', name: 'Wings');

    return controller;
  }

  static WingsController? find<T>({String? tag}) {
    tag ??= T.runtimeType.toString();

    if (instance.controllers.containsKey(tag)) {
      return instance.controllers[tag];
    } else {
      return null;
    }
  }

  static void remove<T>({String? tag}) {
    tag ??= T.runtimeType.toString();

    instance.controllers.removeWhere((key, value) => key == tag);

    log('$tag controller has been removed', name: 'Wings');
  }

  WingsLanguage defaultLanguage = WingsLanguage(
    locale: const Locale('ar', 'ye'),
    textDirection: TextDirection.rtl,
  );

  BuildContext? _context;

  Map<String, dynamic> controllers = {};

  static BuildContext get context => instance._context!;

  static DataProvider get provider => DataProvider.instance;

  static WingsLanguageController get language =>
      WingsLanguageController.instance;

  static void push(WingsView page, {dynamic args}) {
    _push(page, args: args);
  }

  static void pushReplace(WingsView page, {dynamic args}) {
    _pushReplace(page, args: args);
  }

  static void pushReplaceAll(WingsView page, {dynamic args}) {
    _pushReplaceAll(page, args: args);
  }

  static void setContext(BuildContext context) {
    instance._context = context;
  }
}
