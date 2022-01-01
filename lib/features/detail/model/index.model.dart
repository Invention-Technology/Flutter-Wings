import 'package:wings/core/immutable/base/models/model.wings.dart';

class DetialModel extends WingsModel {
  dynamic id;
  dynamic title;
  dynamic body;

  DetialModel({
    this.id,
    this.title,
    this.body,
  });

  @override
  List<WingsModel> fromJsonList(List<dynamic> json) {
    List<DetialModel> models = [];

    for (var element in json) {
      models.add(DetialModel.fromJson(element));
    }

    return models;
  }

  @override
  WingsModel fromJson(Map<String, dynamic> json) {
    return DetialModel.fromJson(json);
  }

  factory DetialModel.fromJson(Map<String, dynamic> json) {
    return DetialModel(
        id: json['id'], title: json['title'], body: json['body']);
  }
}
