import 'package:wings/core/immutable/base/models/model.wings.dart';

class IndexModel implements WingsModel {
  dynamic id;
  dynamic title;

  IndexModel({
    this.id,
    this.title,
  });

  @override
  List<WingsModel> fromJsonList(List<dynamic> json) {
    List<IndexModel> models = [];

    for (var element in json) {
      models.add(IndexModel.fromJson(element));
    }

    return models;
  }

  factory IndexModel.fromJson(Map<String, dynamic> json) {
    return IndexModel(id: json['id'], title: json['title']);
  }

  @override
  WingsModel fromJson(Map<String, dynamic> json) {
    return IndexModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
