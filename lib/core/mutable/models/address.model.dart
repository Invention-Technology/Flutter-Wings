import '../../immutable/base/models/model.wings.dart';

class AddressModel extends WingsModel {
  final dynamic id;
  final dynamic country;
  final dynamic city;
  final dynamic district;
  final dynamic streetName;

  const AddressModel({
    this.id = '',
    this.country = '',
    this.city = '',
    this.district = '',
    this.streetName = '',
  });

  @override
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'],
      country: json['country'],
      city: json['city'],
      district: json['district'],
      streetName: json['streetName'],
    );
  }

  @override
  List<AddressModel> fromJsonList(List<dynamic> json) {
    List<AddressModel> images = [];

    for (var ele in json) {
      images.add(AddressModel.fromJson(ele));
    }

    return images;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'country': country,
      'city': city,
      'district': district,
      'streetName': streetName,
    };
  }

  @override
  String toString() {
    String string = '';

    if (city != null && city.toString().isNotEmpty) string += city;

    if (district != null && district.toString().isNotEmpty) {
      string += string.isEmpty ? district : " - $district";
    }

    if (streetName != null && streetName.toString().isNotEmpty) {
      string += string.isEmpty ? streetName : " - $streetName";
    }

    return string;
  }
}
