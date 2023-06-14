import 'package:flutter/material.dart';

class WingsDatePicker {
  static Future<DateTime?> picker(
      {required BuildContext context,
      DateTime? currentDate,
      DateTime? firstDate}) async {
    return await showDatePicker(
      context: context,
      currentDate: currentDate,
      initialDate: DateTime.now(),
      firstDate: firstDate ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 100)),
      cancelText: 'إلغاء',
      confirmText: 'موافق',
      fieldLabelText: 'قم بكتابة التاريخ',
      helpText: 'إختر تاريخ',
    );
  }
}
