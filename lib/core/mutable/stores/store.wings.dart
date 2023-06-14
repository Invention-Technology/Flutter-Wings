import 'package:wings/core/immutable/binding/reactive.binding.dart';

/// You can store data that you want to store and retrieve during the app life cycle
class WingsStore {
  static WingsStore? _instance;

  static WingsStore get instance {
    _instance ??= WingsStore();

    return _instance!;
  }

// add your data
  var trackingEnabled = false.wis;
  static const double sanaaLong = 44.191006;

  static const double sanaaLat = 15.369445;

  dynamic customer;

  DateTime? fromDate;
  DateTime? toDate;
  String? filterTitle;
  int? filterType;
}
