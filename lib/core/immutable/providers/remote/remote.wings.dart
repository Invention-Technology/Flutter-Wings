import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../errors/exceptions.enum.wings.dart';
import '../errors/exceptions.wings.dart';
import 'methods.enums.wings.dart';
import 'request.wings.dart';

class WingsRemoteProvider {
  factory WingsRemoteProvider() {
    _singleton ??= WingsRemoteProvider._();

    return _singleton!;
  }

  WingsRemoteProvider._();

  static WingsRemoteProvider? _singleton;

  Dio dio = Dio();

  Future<dynamic> send({
    required WingsRequest request,
    required WingsRemoteMethod method,
    List<int> successStates = const [200, 201, 202],
    Function(Response, int)? onSuccess,
    Function(int, dynamic error)? onError,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
  }) async {
    int errorStatusCode = 500;

    try {
      Response<dynamic> response = await dio
          .request(
        request.urlQueryString,
        data: request.body,
        options: Options(
          method: method.name,
          headers: request.header,
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      )
          .timeout(
        dio.options.sendTimeout ?? Duration(seconds: 10),
        onTimeout: () {
          if (onError != null) {
            onError(408, null);
          }
          errorStatusCode = 408;

          throw 408.toException;
        },
      );

      var statusCode = response.statusCode!;

      if (successStates.contains(statusCode)) {
        if (onSuccess != null) onSuccess(response, statusCode);
      } else {
        log('Server response with status code $statusCode',
            name: 'Wings Remote');
        log(response.data.toString(), name: 'Wings Remote');
        if (onError != null) {
          onError(statusCode, response.data);
        } else {
          throw statusCode.toException;
        }
      }
      return response;
    } catch (exception) {
      log(exception.toString(), name: 'Wings Remote');
      if (onError != null) {
        onError(errorStatusCode, exception);
      } else {
        _catchExceptions(exception);
      }
    }
  }

  Future<dynamic> download({
    required WingsRequest request,
    required String savePath,
    Function(int, int)? onProgress,
    VoidCallback? onComplete,
    List<int> successStates = const [200, 201, 202],
    Function(Response, int)? onSuccess,
    Function(Response?, int)? onError,
    bool overrideIfExists = false,
  }) async {
    if (await File(savePath).exists() && !overrideIfExists) {
      if (onComplete != null) onComplete();
    } else {
      try {
        var response = await dio
            .download(
          request.url,
          savePath,
          options: Options(
            headers: request.header,
            validateStatus: (status) {
              return status != null && status < 500;
            },
          ),
          onReceiveProgress: onProgress,
        )
            .timeout(
          dio.options.sendTimeout ?? Duration(seconds: 10),
          onTimeout: () {
            if (onError != null) {
              onError(null, 408);
            }

            throw WingsException.fromEnumeration(ExceptionTypes.timeout);
          },
        ).whenComplete(() {
          if (onComplete != null) onComplete();
        });

        var statusCode = response.statusCode!;

        if (successStates.contains(statusCode)) {
          if (onSuccess != null) onSuccess(response, statusCode);
        } else {
          log('Server response with status code $statusCode',
              name: 'Wings Remote');
          if (onError != null) {
            onError(response, statusCode);
          } else {
            throw WingsException.fromStatusCode(statusCode);
          }
        }

        return jsonDecode(response.data);
      } catch (exception) {
        _catchExceptions(exception);
      }
    }
  }

  void _catchExceptions(Object exception) {
    log("$exception", name: "Wings Remote Catch Exception");
    var statusCode = 500;
    if (exception is DioError) {
      statusCode = exception.response?.statusCode ?? 500;
      log(exception.response?.data, name: 'dio error');
    }
    throw WingsException.fromStatusCode(statusCode);
  }
}
