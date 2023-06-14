import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wings/core/mutable/themes/theme.wings.dart';

String formatMoney(dynamic amount, {String currency = 'ر.ي'}) {
  if (amount is String) {
    amount = double.tryParse(amount) ?? amount;
  }

  if (amount is int || amount is double) {
    String formatted =
        amount.toStringAsFixed(0).replaceAll(RegExp(r'(?=(\d{3})+$)'), ',');

    if (formatted.startsWith(',')) {
      formatted = formatted.substring(1, formatted.length);
    }

    return '$formatted $currency';
  }

  return "${amount ?? 0}";
}

extension ToJson on List {
  List toJson() {
    List list = [];

    for (var ele in this) {
      list.add(ele.toJson());
    }

    return list;
  }
}

extension Wsh on double {
  double get wsh {
    if (WingsTheme.bigScreen) {
      return (this - (this * 0.1)).sh;
    }
    return sh;
  }
}

extension StatusString on int {
  String get statusString {
    if (this == -2) {
      return 'ملغية';
    }

    if (this < 0) {
      return 'مرفوضة';
    }

    switch (this) {
      case 0:
        return 'جاري الانتظار';
      case 1:
        return 'مقبولة';
      case 2:
      case 3:
        return 'محولة';
      case 4:
        return 'في انتظار الحمولة';
      case 5:
        return 'قيد المعالجة';
      case 6:
        return 'قيد التوصيل';
      case 7:
        return 'تم التوصيل';
      case 8:
        return 'قيد التحصيل';
      case 9:
        return 'مكتملة';
    }

    return 'قيد المعالجة';
  }
}

extension StatusTextColor on int {
  Color get statusTextColor {
    if (this < 0) {
      return WingsTheme.dangerDarkColor;
    }

    if (this <= 3) {
      return WingsTheme.greyedOut;
    }

    return WingsTheme.successDarkColor;
  }
}

extension StatusBgColor on int {
  Color get statusBgColor {
    if (this < 0) {
      return WingsTheme.dangerLightColor;
    }

    if (this <= 3) {
      return WingsTheme.greyedOutLight;
    }

    return WingsTheme.successLightColor;
  }
}

extension PaymentTextColor on int {
  Color get paymentTxtColor {
    return this == 0 ? WingsTheme.successDarkColor : WingsTheme.dangerDarkColor;
  }
}

extension PaymentBgColor on int {
  Color get paymentBgColor {
    return this == 0
        ? WingsTheme.successLightColor
        : WingsTheme.dangerLightColor;
  }
}
