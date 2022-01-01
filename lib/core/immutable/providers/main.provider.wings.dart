import 'dart:developer';

import 'errors/error.model.wings.dart';
import 'errors/exceptions.enum.wings.dart';
import 'errors/exceptions.wings.dart';
import 'errors/mapping_errors.helper.wings.dart';
import 'local/local.wings.dart';
import 'network/network.manager.dart';
import 'remote/methods.enums.wings.dart';
import 'remote/remote.wings.dart';
import 'remote/request.wings.dart';

class DataProvider {
  static DataProvider? _instance;

  static DataProvider get instance {
    if (_instance == null) init();

    return _instance!;
  }

  static Future<void> init() async {
    _instance ??= DataProvider();
    await NetworkManager.init();
    await Local.init();
  }

  Remote get remote => Remote.instance;

  Local get local => Local.instance;

  int get statusCode => remote.statusCode;

  ErrorModel error = ErrorModel(message: '');

  double get sendingRemaining => remote.sendingRemaining.value;

  double get receiveRemaining => remote.receiveRemaining.value;

  bool get remoteConnection => NetworkManager.instance.hasConnection;

  Future<dynamic> update({required WingsRequest request}) async {
    try {
      var response = remote.send(request: request, method: HttpMethod.put);

      if (response.toString().isEmpty) {
        throw WingsException.fromEnumeration(ExceptionTypes.process);
      }

      return response;
    } catch (exception) {
      log('update has exception of type $exception');
      error = mapExceptionToMessage(exception);
    }
  }

  Future<dynamic> insert({required WingsRequest request}) async {
    try {
      var response =
          await remote.send(method: HttpMethod.post, request: request);

      if (response.toString().isEmpty) {
        throw WingsException.fromEnumeration(ExceptionTypes.process);
      }

      return response;
    } catch (exception) {
      log('insert has exception of type $exception');
      error = mapExceptionToMessage(exception);
    }
  }

  Future<void> delete({required WingsRequest request}) async {
    try {
      var response = remote.send(request: request, method: HttpMethod.delete);

      if (response.toString().isEmpty) {
        throw WingsException.fromEnumeration(ExceptionTypes.process);
      }
    } catch (exception) {
      log('delete has exception of type $exception');
      error = mapExceptionToMessage(exception);
    }
  }

  Future<dynamic> get({required WingsRequest request}) async {
    try {
      error = ErrorModel(message: '');

      dynamic response;
      if (remoteConnection) {
        response = await remote.send(request: request, method: HttpMethod.get);

        if (response == null) {
          throw WingsException.fromEnumeration(ExceptionTypes.connection);
        }

        if (request.shouldCache) {
          local.save(key: request.urlQueryString, value: response);
        }
      } else if (request.shouldCache) {
        response = local.get(key: request.urlQueryString);
      } else {
        throw WingsException.fromEnumeration(ExceptionTypes.connection);
      }

      return response;
    } catch (exception) {
      log('get has exception of type $exception');
      error = mapExceptionToMessage(exception);
    }
  }
}
