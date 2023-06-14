import 'dart:async';

import '../binding/reactive.binding.dart';

class OneTimer {
  Timer? _timer;

  void startTimer(Duration duration, Function() callback) {
    _timer?.cancel();

    _timer = Timer(duration, callback);
  }
}

void debounce(
  WingsReactive variable, {
  required Function(dynamic data) callback,
  Duration duration = const Duration(milliseconds: 800),
}) {
  OneTimer oneTimer = OneTimer();

  variable.stream.listen((event) {
    oneTimer.startTimer(duration, () => callback(variable.data));
  });
}
