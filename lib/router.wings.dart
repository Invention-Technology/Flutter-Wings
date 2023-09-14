import 'package:go_router/go_router.dart';
import 'package:wings/features/index/view/index.view.dart';

import 'core/immutable/main.wings.dart';

class WingsRouter {
  static WingsRouter? _router;

  factory WingsRouter() {
    _router ??= WingsRouter._();
    return _router!;
  }

  late GoRouter router;

  String get initialRoute {
    return '/';
  }

  WingsRouter._() {
    router = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: Wings.key,
      initialLocation: initialRoute,
      routes: [
        GoRoute(
          path: "/",
          name: 'home',
          builder: (context, state) => IndexView(),
        ),
      ],
    );
  }
}
