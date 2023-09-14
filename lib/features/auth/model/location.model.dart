import 'package:wings/core/immutable/base/models/model.wings.dart';
import 'package:wings/core/mutable/helpers/util.helper.dart';
import 'package:wings/core/mutable/models/simple/dropdown.model.dart';
import 'package:wings/features/auth/helper/utils.helper.dart';

import 'city.model.dart';

class LocationModel extends WingsModel {
  final List<CityModel> cities;
  final List<CityModel> districts;
  List<DropDownModel> citiesList = [];
  List<DropDownModel> districtsList = [];

  LocationModel({
    this.cities = const [],
    this.districts = const [],
  }) {
    if (cities.isNotEmpty) {
      citiesList = cities.toDropDownList();
    }

    if (districts.isNotEmpty) {
      fillDistrictsList();
    }
  }

  @override
  LocationModel fromJson(Map<String, dynamic> json) {
    return LocationModel(
      cities: const CityModel().fromJsonList(json['cities'] ?? []),
      districts: const CityModel().fromJsonList(json['districts'] ?? []),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'cities': cities.toJson(),
      'districts': districts.toJson(),
    };
  }

  void fillDistrictsList({String? parentId}) {
    districtsList = [const DropDownModel(key: '0', value: 'اختر المنطقة')];
    districtsList.addAll(
      districts
          .where((element) =>
              element.parentId.toString() ==
              (parentId ?? cities.first.id.toString()))
          .toList()
          .toDropDownList(),
    );
  }
}
