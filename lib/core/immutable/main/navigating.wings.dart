part of '../main.wings.dart';

void _push(WingsView page, {Map<String, dynamic> args = const {}}) {
  Wings.arguments = args;
  _checkMiddleware(page);
  Navigator.of(Wings.context).push(
    MaterialPageRoute(builder: (context) => page),
  );
}

void _pushReplace(WingsView page, {Map<String, dynamic> args = const {}}) {
  Wings.arguments = args;
  _checkMiddleware(page);
  Navigator.of(Wings.context).pushReplacement(
    MaterialPageRoute(builder: (context) => page),
  );
}

void _pushReplaceAll(WingsView page, {Map<String, dynamic> args = const {}}) {
  Wings.arguments = args;
  _checkMiddleware(page);
  // TODO: Check this later
  Navigator.of(Wings.context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => page),
    ModalRoute.withName('/'),
  );
}

void _pop() {
  Navigator.of(Wings.context).pop();
}

void _checkMiddleware(WingsView page) {
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
