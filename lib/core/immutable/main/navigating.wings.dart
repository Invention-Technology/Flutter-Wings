part of '../main.wings.dart';

void _push(WingsView page, {dynamic args}) async {
  await _checkMiddleware(page);

  Get.to(() => page, arguments: args);
}

void _pushReplace(WingsView page, {dynamic args}) async {
  await _checkMiddleware(page);

  Get.off(() => page, arguments: args);
}

void _pushReplaceAll(WingsView page, {dynamic args}) async {
  await _checkMiddleware(page);

  Get.offAll(() => page, arguments: args);
}

Future<void> _checkMiddleware(WingsView page) async {
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
}
