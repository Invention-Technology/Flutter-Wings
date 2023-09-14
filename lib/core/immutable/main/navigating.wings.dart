part of '../main.wings.dart';

void _push(
  dynamic page, {
  bool withAnimation = false,
  Map<String, dynamic> args = const {},
}) {
  if (page is WingsView) {
    Wings.arguments = args;
    _checkMiddleware(page);
  }

  Navigator.of(Wings.context).push(
    withAnimation
        ? PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(
                    begin: const Offset(-1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ),
                ),
                child: child,
              );
            },
          )
        : MaterialPageRoute(
            builder: (context) => page,
          ),
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

  while (ModalRoute.of(Wings.context)?.isFirst == false) {
    _pop();
  }

  GoRouter.of(Wings.context).pushReplacement(page);
}

void _pop({bool removeLast = false}) {
  if (removeLast) {
    Wings.removeLast();
  }

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
