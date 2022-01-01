import 'dart:developer';

import 'package:get_storage/get_storage.dart';

import '../errors/exceptions.enum.wings.dart';
import '../errors/exceptions.wings.dart';

class Local {
  static Local? _instance;

  static Local get instance {
    if (_instance == null) init();

    return _instance!;
  }

  static Future<void> init() async {
    _instance ??= Local();

    await GetStorage.init();
  }

  final GetStorage _storage = GetStorage();

  void save({required String key, dynamic value}) async {
    await _storage.write(key, value);
  }

  dynamic get({required String key}) {
    log('this $key has ${_storage.hasData(key)}');
    if (_storage.hasData(key)) return _storage.read(key);
    throw WingsException.fromEnumeration(ExceptionTypes.connection);
  }

  void delete({required String key}) {
    if (_storage.hasData(key)) _storage.remove(key);
  }

  /// Please be aware that calling this function will delete all the data in the cache
  void clean() async {
    _storage.erase();
  }
}
