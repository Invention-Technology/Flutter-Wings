import 'package:wings/core/immutable/base/models/model.wings.dart';

class DetailsModel extends WingsModel {
  dynamic id;
  dynamic title;
  dynamic body;

  DetailsModel({
    this.id,
    this.title,
    this.body,
  });

  @override
  List<WingsModel> fromJsonList(List<dynamic> json) {
    List<DetailsModel> models = [];

    for (var element in json) {
      models.add(DetailsModel.fromJson(element));
    }

    return models;
  }

  @override
  WingsModel fromJson(Map<String, dynamic> json) {
    return DetailsModel.fromJson(json);
  }

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
        id: json['id'], title: json['title'], body: json['body']);
  }
}
