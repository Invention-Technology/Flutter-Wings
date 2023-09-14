import 'package:dio/dio.dart';

import 'model.wings.dart';

class WingsResponseModel extends WingsModel {
  final dynamic data;
  final dynamic message;
  final dynamic statusCode;
  final dynamic totalSize;
  final dynamic pageSize;
  final dynamic pages;

  WingsResponseModel({
    this.data,
    this.message,
    this.statusCode,
    this.totalSize,
    this.pageSize,
    this.pages,
  });

  factory WingsResponseModel.fromJson(Map<String, dynamic> json) {
    int totalSize = json['totalSize'] ?? 1;

    int pageSize = json['pages'] ?? 1;
    if (pageSize <= 0) pageSize = 1;

    int pages = totalSize ~/ pageSize;
    pages += int.tryParse((totalSize % pageSize).toString()) ?? 0;

    return WingsResponseModel(
      data: json['data'],
      message: json['Messages'],
      statusCode: json['Status'],
      totalSize: totalSize,
      pageSize: pageSize,
      pages: pages,
    );
  }

  factory WingsResponseModel.fromResponse(Response<dynamic> response) {
    try {
      return WingsResponseModel.fromJson(response.data);
    } catch (ex) {
      return WingsResponseModel(data: response.data);
    }
  }

  @override
  WingsResponseModel fromJson(Map<String, dynamic> json) {
    return WingsResponseModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'Messages': message,
      'Status': statusCode,
      'totalSize': totalSize,
      'pages': pageSize,
      'pageSize': pages,
    };
  }
}
