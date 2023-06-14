import 'dart:developer';

import 'package:flutter/material.dart';

import '../mutable/helpers/phone.info.helper.dart';
import '../mutable/remote/urls.wings.dart';
import 'base/controllers/controller.wings.dart';
import 'base/views/view.wings.dart';
import 'providers/remote/remote.wings.dart';
import 'translations/lang.controller.wings.dart';
import 'translations/language.wings.dart';

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

    WingsRemoteProvider().dio.options.baseUrl = WingsURL.baseURL;
    WingsRemoteProvider().dio.options.sendTimeout = const Duration(seconds: 20);

    WingsDeviceInfo();
  }

  static WingsController add(WingsController controller, {
    String? tag,
    bool permanent = false,
  }) {
    // if (controller.runtimeType is! WingsController) throw UnimplementedError();

    tag ??= controller.runtimeType.toString();

    if (permanent) {
      tag = "\$Permanent__" + tag;
    }

    if (!instance.controllers.containsKey(tag)) {
      instance.controllers.addAll({tag: controller});
    } else {
      return instance.controllers[tag];
    }

    log('$tag controller has been created', name: 'Wings');

    return controller;
  }

  static WingsController? find<T>({String? tag}) {
    tag ??= T.toString();

    if (instance.controllers.containsKey(tag)) {
      return instance.controllers[tag];
    } else {
      return null;
    }
  }

  static void remove<T>({String? tag}) {
    tag ??= T.toString();

    if (tag.startsWith("\$Permanent__")) {
      return;
    }

    if (instance.controllers.containsKey(tag)) {
      (instance.controllers[tag] as WingsController).onDispose();
      instance.controllers.removeWhere((key, value) => key == tag);
    }

    log('$tag controller has been removed', name: 'Wings');
  }

  static void removeLast() {
    if (instance.controllers.isNotEmpty) {
      var last = instance.controllers.entries.last.key.toString();

      instance.controllers[instance.controllers.entries.last.key].onDispose();

      instance.controllers.remove(instance.controllers.entries.last.key);

      log('$last controller has been removed', name: 'Wings');
    }
  }

  WingsLanguage defaultLanguage = WingsLanguage(
    locale: const Locale('ar', 'ye'),
    textDirection: TextDirection.rtl,
  );

  Map<String, dynamic> controllers = {};

  static BuildContext get context => key.currentContext!;

  static GlobalKey<NavigatorState> get key => _key;

  static final GlobalKey<NavigatorState> _key = GlobalKey();

  static WingsLanguageController get language =>
      WingsLanguageController.instance;

  static Map<String, dynamic> arguments = {};

  static Locale locale = const Locale('ar', 'YE');

  static bool isView = true;

  static Future<T?> push<T extends Object?>(dynamic page,
      {Map<String, dynamic> args = const {}}) {
    return _push(page, args: args);
  }

  static void pushReplace(dynamic page,
      {Map<String, dynamic> args = const {}}) {
    _pushReplace(page, args: args);
  }

  static void pushReplaceAll(dynamic page,
      {Map<String, dynamic> args = const {}}) {
    _pushReplaceAll(page, args: args);
  }

  static void pop({bool removeLast = true}) {
    _pop(removeLast: removeLast);
  }

  static void closeWidget() {
    if (!isView) {
      _pop(removeLast: false);

      isView = true;
    }
  }
}
