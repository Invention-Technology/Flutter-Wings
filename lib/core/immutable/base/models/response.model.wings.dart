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
    return WingsResponseModel(
      data: json['data'],
      message: json['Messages'],
      statusCode: json['Status'],
      totalSize: json['totalSize'],
      pageSize: json['pageSize'],
      pages: json['pages'],
    );
  }

  factory WingsResponseModel.fromResponse(Response<dynamic> response) {
    return WingsResponseModel.fromJson(response.data);
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
