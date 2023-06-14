import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class WingsLocalProvider {
  WingsLocalProvider._();

  static WingsLocalProvider? _instance;

  factory WingsLocalProvider() {
    _instance ??= WingsLocalProvider._();

    return _instance!;
  }

  final String fcmKey = 'fcmKey';

  SharedPreferences? _prefs;

  Future<void> write({required String key, required value}) async {
    _prefs ??= await SharedPreferences.getInstance();

    try {
      String val = '';

      if (value is Map<String, dynamic>) {
        val = jsonEncode(value);
      } else if (value is String) {
        val = value;
      } else {
        val = value.toString();
      }
      await _prefs?.setString(key, val);
    } catch (ex) {}
  }

  Future<String?> read({required String key}) async {
    _prefs ??= await SharedPreferences.getInstance();

    return _prefs?.getString(key);
  }

  Future<void> delete({required String key}) async {
    await _prefs?.remove(key);
  }
}
