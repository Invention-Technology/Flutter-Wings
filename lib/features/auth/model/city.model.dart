import 'package:wings/core/immutable/base/models/model.wings.dart';
import 'package:wings/core/mutable/models/simple/dropdown.model.dart';

class CityModel extends WingsModel {
  final dynamic id;
  final dynamic name;
  final dynamic parentId;

  const CityModel({
    this.id = '',
    this.name = '',
    this.parentId = '',
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      parentId: json['parentId'] ?? '',
    );
  }

  @override
  CityModel fromJson(Map<String, dynamic> json) {
    return CityModel.fromJson(json);
  }

  @override
  List<CityModel> fromJsonList(List json) {
    List<CityModel> cities = [];

    for (var ele in json) {
      cities.add(CityModel.fromJson(ele));
    }

    return cities;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentId': parentId,
      'name': name,
    };
  }

  DropDownModel toDropDown() {
    return DropDownModel(
      key: id.toString(),
      value: name,
    );
  }
}
