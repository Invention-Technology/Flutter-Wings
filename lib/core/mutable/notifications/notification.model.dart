import 'dart:convert';

import '../../immutable/base/models/model.wings.dart';

class WingsNotificationModel extends WingsModel {
  dynamic id;
  dynamic title;
  dynamic body;
  dynamic notRead;
  dynamic sendDate;
  dynamic closePage;
  List<dynamic> refreshPages;

  WingsNotificationModel({
    this.id = '',
    this.title = '',
    this.body = '',
    this.sendDate = '',
    this.closePage = '',
    this.refreshPages = const [],
    this.notRead = true,
  });

  @override
  WingsNotificationModel fromJson(Map<String, dynamic> json) {
    return WingsNotificationModel.fromJson(json);
  }

  factory WingsNotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json = jsonDecode(json['data']);
    }

    return WingsNotificationModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      sendDate: json['sendDate'] ?? '',
      closePage: json['closePage'] ?? '',
      refreshPages: json['refreshPages'] ?? [],
      notRead: json['notRead'] ?? false,
    );
  }

  @override
  List<WingsNotificationModel> fromJsonList(List json) {
    List<WingsNotificationModel> list = [];

    for (var ele in json) {
      list.add(WingsNotificationModel.fromJson(ele));
    }

    return list;
  }

  @override
  Map<String, String> toJson() {
    return {
      '_id': id ?? '',
      'title': title ?? '',
      'body': body ?? '',
      'sendDate': sendDate ?? '',
      'closePage': closePage ?? '',
      'refreshPages': refreshPages.toString(),
      'notRead': notRead ?? false
    };
  }

  Map<String, String> toShowNotification() {
    return {
      '_id': id ?? '',
      'title': title ?? '',
      'body': body ?? '',
    };
  }
}
