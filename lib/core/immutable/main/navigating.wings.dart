part of '../main.wings.dart';

Future<T?> _push<T extends Object?>(dynamic page,
    {Map<String, dynamic> args = const {}}) {
  if (page is WingsView) {
    Wings.arguments = args;
    _checkMiddleware(page);
  }

  return Navigator.of(Wings.context).push(
    MaterialPageRoute(builder: (context) => page),
  );
}

void _pushReplace(dynamic page, {Map<String, dynamic> args = const {}}) {
  if (page is WingsView) {
    Wings.arguments = args;
    _checkMiddleware(page);
  }

  Navigator.of(Wings.context).pushReplacement(
    MaterialPageRoute(builder: (context) => page),
  );
}

void _pushReplaceAll(dynamic page, {Map<String, dynamic> args = const {}}) {
  if (page is WingsView) {
    Wings.arguments = args;
    _checkMiddleware(page);
  }

  Navigator.of(Wings.context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => page),
    (route) => false,
  );
}

void _pop({bool removeLast = false}) {
  if (removeLast) {
    Wings.removeLast();
  }

  Navigator.of(Wings.context).pop();
}

_checkMiddleware(WingsView page) {
  for (var middleware in page.middlewares) {
    dynamic boot = middleware.boot();
    if (boot != true) {
      log((boot is WingsView).toString());
      if (boot is WingsView) {
        return Wings.push(boot);
      } else {
        return;
      }
    }
  }
}
