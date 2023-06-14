import '../../immutable/base/models/model.wings.dart';

class ImageModel extends WingsModel {
  final dynamic id;
  final dynamic name;
  final dynamic title;
  final dynamic path;
  final dynamic size;

  const ImageModel({
    this.id = '',
    this.name = '',
    this.title = '',
    this.path = '',
    this.size = 0,
  });

  @override
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['_id'],
      name: json['name'],
      title: json['title'],
      path: json['path'],
      size: json['size'],
    );
  }

  @override
  List<ImageModel> fromJsonList(List<dynamic> json) {
    List<ImageModel> images = [];

    for (var ele in json) {
      images.add(ImageModel.fromJson(ele));
    }

    return images;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'title': title,
      'path': path,
      'size': size,
    };
  }
}
