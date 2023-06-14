import '../../immutable/base/models/model.wings.dart';
import 'simple/dropdown.model.dart';

class PriceModel extends WingsModel {
  final dynamic id;
  final dynamic title;
  final dynamic price;

  const PriceModel({
    this.id = '',
    this.title = '',
    this.price = 0,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      id: json['_id'] ?? json['id'] ?? '',
      title: json['title'] ?? '',
      price: json['price'] ?? 0,
    );
  }

  @override
  PriceModel fromJson(Map<String, dynamic> json) {
    return PriceModel.fromJson(json);
  }

  @override
  List<PriceModel> fromJsonList(List json) {
    List<PriceModel> prices = [];

    for (var ele in json) {
      prices.add(PriceModel.fromJson(ele));
    }

    return prices;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
    };
  }

  DropDownModel toDropDown() {
    return DropDownModel(
      key: id.toString(),
      value: title,
    );
  }
}
