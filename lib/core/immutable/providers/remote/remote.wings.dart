import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../mutable/remote/response_format.wings.dart';
import '../../../mutable/remote/urls.wings.dart';
import '../../main.wings.dart';
import '../errors/exceptions.enum.wings.dart';
import '../errors/exceptions.wings.dart';
import '../errors/mapping_errors.helper.wings.dart';
import 'methods.enums.wings.dart';
import 'request.wings.dart';

class Remote {
  static Remote? _instance;

  static Remote get instance {
    if (_instance == null) init();

    return _instance!;
  }

  static void init() {
    _instance ??= Remote();

    var options = BaseOptions(
      baseUrl: WingsURL.baseURL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      sendTimeout: 300000,
    );

    _instance!.dio = Dio(options);
  }

  Dio? dio;

  int statusCode = 0;
  RxDouble sendingRemaining = 0.0.obs;
  RxDouble receiveRemaining = 0.0.obs;

  bool get success =>
      statusCode == 200 || statusCode == 201 || statusCode == 202;

  Future<dynamic> send({
    required WingsRequest request,
    required HttpMethod method,
  }) async {
    try {
      var response = await dio!.request(
        request.urlQueryString,
        data: request.body,
        options: Options(method: method.name, headers: request.header!.toMap()),
        onSendProgress: (sent, total) {
          sendingRemaining.value = (total - sent) / total * 100;
        },
        onReceiveProgress: (received, total) {
          receiveRemaining.value = (total - received) / total * 100;
        },
      ).timeout(
        Duration(milliseconds: dio!.options.sendTimeout),
        onTimeout: () {
          throw WingsException.fromEnumeration(ExceptionTypes.timeout);
        },
      );

      statusCode = response.statusCode!;

      if (!success) {
        log('Server response with status code $statusCode',
            name: 'Wings Remote');
        throw WingsException.fromStatusCode(statusCode);
      }

      _checkInvalidResponse(response.data);

      if (WingsResponseFormat.key != null &&
          WingsResponseFormat.key!.isNotEmpty) {
        return jsonDecode(response.data)[WingsResponseFormat.key];
      }

      return response.data;
    } catch (exception) {
      Wings.provider.error = mapExceptionToMessage(exception);
    }
  }

  void _checkInvalidResponse(response) {
    if (response.toString().isEmpty) {
      log('Empty Response from the Server', name: 'Wings Remote');
      throw WingsException.fromStatusCode(404);
    }

    if (!WingsResponseFormat.validatedResponse(response.toString())) {
      log('Invalid Response from the Server', name: 'Wings Remote');
      throw WingsException.fromStatusCode(0);
    }
  }
}
