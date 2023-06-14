import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/theme.wings.dart';

class Badge {
  final String name;
  final Color color;
  final Color backgroundColor;

  Badge({
    required this.name,
    required this.color,
    required this.backgroundColor,
  });

  Widget toWidget() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: EdgeInsets.symmetric(vertical: 0.005.sh, horizontal: 0.02.sw),
      margin: EdgeInsetsDirectional.only(end: 0.01.sh, top: 0.01.sh),
      child: Text(
        name,
        style: WingsTheme.body4.copyWith(color: color.withOpacity(1)),
      ),
    );
  }

  static List<Badge> fromJsonList(List<Map<String, dynamic>> json) {
    List<Badge> list = [];

    json.map((e) => list.add(Badge.fromJson(e)));

    return list;
  }

  factory Badge.fromJson(json) {
    return Badge(
      name: json['name'],
      color: Color(int.parse(json['color'])),
      backgroundColor: Color(int.parse(json['backgroundColor'])),
    );
  }
}
