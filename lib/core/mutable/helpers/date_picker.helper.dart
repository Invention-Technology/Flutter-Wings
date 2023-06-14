import 'package:flutter/material.dart';
import 'package:wings/core/immutable/main.wings.dart';

Future<DateTime> datePickerHelper(
    {DateTime? initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    BuildContext? context,
    Function(DateTime selectedDate)? onSelected}) async {
  DateTime? newSelectedDate = await showDatePicker(
    context: context ?? Wings.context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate,
    lastDate: lastDate,
  );

  if (newSelectedDate != null) {
    if (onSelected != null) {
      onSelected(newSelectedDate);
    }

    return newSelectedDate;
  }

  return DateTime.now();
}
