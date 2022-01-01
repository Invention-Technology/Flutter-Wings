import 'dart:ui';

import '../base/models/model.wings.dart';

class WingsLanguage extends WingsModel {
  TextDirection textDirection;
  Locale locale;

  WingsLanguage({
    this.locale = const Locale('ar', 'ye'),
    this.textDirection = TextDirection.rtl,
  });

  factory WingsLanguage.fromJson(Map<String, dynamic> json) {
    return WingsLanguage(
      locale: json['locale'],
      textDirection: json['direction'],
    );
  }

  @override
  WingsLanguage fromJson(Map<String, dynamic> json) {
    return WingsLanguage.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'locale': locale,
      'direction': textDirection,
    };
  }
}
