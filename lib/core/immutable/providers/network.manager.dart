import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class WingsNetworkManager {
   final StreamController<bool> _networkChange =
      StreamController.broadcast();

  /// event handler functions are called.
   void onNetworkChange(
    Function(bool)? onData, {
    Function? onError,
    Function()? onDone,
    bool? cancelOnError,
  }) {
    _singleton!._networkChange.stream.listen(
      onData,
      cancelOnError: cancelOnError,
      onDone: onDone,
      onError: onError,
    );
  }

  factory WingsNetworkManager() {
    if (_singleton == null) {
      _singleton = WingsNetworkManager._();
      _singleton!._connectivity.onConnectivityChanged.listen(
        _singleton!._updateState,
      );
    }
    return _singleton!;
  }

  WingsNetworkManager._();

  static WingsNetworkManager? _singleton;

  final Connectivity _connectivity = Connectivity();

  bool _hasConnection = false;

  bool get hasConnection {
    return _hasConnection;
  }



  Future<void> _updateState(ConnectivityResult result) async {
    if (result != ConnectivityResult.none) {
      _hasConnection = await InternetConnectionChecker().hasConnection;
    } else {
      _hasConnection = false;
    }
    log('Has connection: $_hasConnection', name: 'WingsNetwork');
    _networkChange.add(_hasConnection);
  }
}
