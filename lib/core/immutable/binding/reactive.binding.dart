import 'dart:async';

class WingsReactive<T> {
  final StreamController<T> _controller = StreamController<T>();

  late final Stream<T>? _stream;

  T? _data;

  WingsReactive(T data) {
    _data = data;
    _stream = _controller.stream.asBroadcastStream();

    _controller.sink.add(_data as T);
  }

  set data(T value) {
    _data = value;

    _controller.sink.add(_data as T);
  }

  T get value => _data!;

  T get data => _data!;

  set value(T value) {
    _data = value;

    _controller.sink.add(_data as T);
  }

  void updateState(void Function(T data) updateFunction) {
    updateFunction(_data as T);
    _controller.sink.add(_data as T);
  }

  Stream<T> get stream => _stream!;
}

extension Wis<T> on T {
  WingsReactive<T> get wis {
    return WingsReactive<T>(this);
  }
}
