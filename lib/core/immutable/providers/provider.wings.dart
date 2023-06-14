import 'network.manager.dart';

typedef GetDataFunction = Future<dynamic> Function();
typedef GetCacheDataFunction = dynamic Function();

class WingsDataProvider {
  factory WingsDataProvider() {
    if (_singleton == null) {
      _singleton = WingsDataProvider._();
      WingsNetworkManager();
    }

    return _singleton!;
  }

  WingsDataProvider._();

  static WingsDataProvider? _singleton;

  bool get remoteConnection => WingsNetworkManager().hasConnection;

  Future<dynamic> sendRequest({
    GetDataFunction? remoteFunction,
    GetCacheDataFunction? getCacheDataFunction,
    Function(dynamic)? onError,
  }) async {
    try {
      if (remoteConnection) {
        if (remoteFunction != null) {
          final remoteData = await remoteFunction();
          return remoteData;
        }
      } else {
        if (getCacheDataFunction != null) {
          final localData = getCacheDataFunction();
          return localData;
        }
      }
    } catch (e) {
      if (onError != null) onError(e);
    }
  }
}
