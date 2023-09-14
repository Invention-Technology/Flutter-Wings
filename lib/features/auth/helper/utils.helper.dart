import 'package:wings/core/mutable/models/simple/dropdown.model.dart';

import '../model/city.model.dart';

extension ToDropdownList on List<CityModel> {
  List<DropDownModel> toDropDownList() {
    List<DropDownModel> dropdownList = [];

    for (var ele in this) {
      dropdownList.add(ele.toDropDown());
    }

    return dropdownList;
  }
}
