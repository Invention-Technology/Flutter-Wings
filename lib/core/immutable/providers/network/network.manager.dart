import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../immutable/main.wings.dart';
import '../errors/error.model.wings.dart';
import '../errors/exceptions.enum.wings.dart';
import '../errors/exceptions.wings.dart';
import '../errors/mapping_errors.helper.wings.dart';

class NetworkManager {
  final _connectionChecker = InternetConnectionChecker();

  static NetworkManager? _instance;

  static NetworkManager get instance {
    if (_instance == null) {
      init();
    }
    return _instance!;
  }

  final Connectivity _connectivity = Connectivity();

  var _connectivityResult = ConnectivityResult.none;

  late StreamSubscription _streamSubscription;

  bool _hasConnection = false;

  bool get hasConnection {
    return _hasConnection;
  }

  static Future<void> init() async {
    _instance ??= NetworkManager();

    await _instance!.checkAndListen();
  }

  Future<void> checkAndListen() async {
    try {
      await getConnectionType();
      _streamSubscription = _connectivity.onConnectivityChanged.listen(
        _updateState,
      );

      _connectionChecker.onStatusChange.listen((event) {
        if (_connectivityResult == ConnectivityResult.none) return;

        Wings.provider.error = ErrorModel(message: '');
        _hasConnection = event == InternetConnectionStatus.connected;

        if (!_hasConnection) {
          Wings.provider.error = mapExceptionToMessage(
            WingsException.fromEnumeration(ExceptionTypes.connection),
          );
        }

        log(_hasConnection.toString(), name: 'connection listener');
      });
    } catch (exception) {
      Wings.provider.error = mapExceptionToMessage(exception);
    }
  }

  Future<void> getConnectionType() async {
    try {
      await _updateState(await _connectivity.checkConnectivity());
    } catch (exception) {
      log(exception.toString());
      _hasConnection = false;

      Wings.provider.error = mapExceptionToMessage(
        WingsException.fromEnumeration(ExceptionTypes.connection),
      );
    }
  }

  Future<void> _updateState(ConnectivityResult result) async {
    _connectivityResult = result;

    if (result != ConnectivityResult.none) {
      _hasConnection = await _connectionChecker.hasConnection;
    } else {
      _hasConnection = false;

      Wings.provider.error = mapExceptionToMessage(
        WingsException.fromEnumeration(ExceptionTypes.connection),
      );
    }

    if (!_hasConnection) {
      Wings.provider.error = mapExceptionToMessage(
        WingsException.fromEnumeration(ExceptionTypes.connection),
      );
    }
  }

  static void clear() {
    _instance!._streamSubscription.cancel();
  }
}
