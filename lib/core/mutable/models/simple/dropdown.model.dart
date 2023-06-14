import '../../../immutable/base/models/model.wings.dart';

part 'dropdown.model.g.dart';

class DropDownModel implements WingsModel {
  final String key;
  final dynamic value;

  const DropDownModel({this.value = '', this.key = ''});

  factory DropDownModel.fromJson(Map<String, dynamic> json) =>
      _$DropDownModelFromJson(json);

  @override
  DropDownModel fromJson(Map<String, dynamic> json) =>
      DropDownModel.fromJson(json);

  @override
  List<DropDownModel> fromJsonList(List json) {
    List<DropDownModel> models = [];

    for (var element in json) {
      models.add(DropDownModel.fromJson(element));
    }

    return models;
  }

  @override
  Map<String, dynamic> toJson() => _$DropDownModelToJson(this);
}
