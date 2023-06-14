import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String dayHour(String date) {
  if (date.isEmpty) return '';

  try {
    return '${todayYesterdayOrDayOfWeek(date)}، ${DateFormat('hh:mm').format(localDateTime(date))} ${amPm(date)}';
  } catch (ex) {
    return '';
  }
}

String dayDate(String date) {
  if (date.isEmpty) return '';

  try {
    return '${dayOfWeek(date)} ${DateFormat('dd').format(DateTime.parse(date))} ${monthName(date)} ';
  } catch (ex) {
    return '';
  }
}

String dateMonthArYear(String date) {
  if (date.isEmpty) return '';

  try {
    return '${dayOfWeek(date)} ${DateFormat('dd').format(DateTime.parse(date))} ${monthName(date)}، ${DateFormat('yyyy').format(DateTime.parse(date))}';
  } catch (ex) {
    return '';
  }
}

String dayOfWeek(String date) {
  return DateFormat('EEEE', 'ar-YE').format(DateTime.parse(date));
}

String monthName(String date, {String local = 'ar-YE'}) {
  return DateFormat('MMM', local).format(DateTime.parse(date));
}

String todayYesterdayOrDayOfWeek(String date) {
  var todayDate = DateTime.now();
  var yesterdayDate = todayDate.subtract(const Duration(days: 1));
  var datetime = DateTime.parse(date);

  String day = dayOfWeek(date);

  if (datetime.month != todayDate.month || datetime.year != todayDate.year) {
    return dayDate(date);
  }

  if (datetime.day != todayDate.day && datetime.day != yesterdayDate.day) {
    return dayDate(date);
  }

  String today = dayOfWeek(todayDate.toString());
  String yesterday = dayOfWeek(yesterdayDate.toString());

  if (day == today) {
    return 'اليوم';
  }

  if (day == yesterday) {
    return 'امس';
  }

  return dayDate(date);
}

String amPm(String date) {
  return DateFormat('a ', 'ar-YE').format(DateTime.parse(date));
}

DateTime fromTime(TimeOfDay time, {DateTime? dateTime}) {
  var now = dateTime ?? DateTime.now();

  return DateTime(now.year, now.month, now.day, time.hour, time.minute);
}

DateTime fromTimeString(String time, {String? dateTime}) {
  var date = DateTime.now();

  if (dateTime != null) {
    date = DateTime.parse('$dateTime $time');
  }

  return date;
}

DateTime localDateTime(String date) {
  return DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date, true).toLocal();
}

String onlyDate(DateTime? date) {
  return DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());
}

String formatDays(dynamic days) {
  String suffix = '';

  if (days is String) {
    days = int.tryParse(days) ?? days;
  }

  if (days is int) {
    String formatted =
        days.toStringAsFixed(0).replaceAll(RegExp(r'(?=(\d{3})+$)'), ',');

    if (formatted.startsWith(',')) {
      formatted = formatted.substring(1, formatted.length);
    }

    if (days == 0) {
      formatted = '';
      suffix = 'اليوم';
    } else if (days == 1) {
      formatted = '';
      suffix = 'يوم';
    } else if (days == 2) {
      formatted = '';
      suffix = 'يومين';
    } else if (days > 2 && days < 11) {
      suffix = 'أيام';
    } else {
      suffix = 'يوم';
    }

    return '$formatted $suffix';
  }

  return "${days ?? 0}";
}
