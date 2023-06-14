import 'ar/_ar.trans.dart';
import 'en/_en.trans.dart';

abstract class TranslationMapper {
  static Map<String, Map<String, String>> keys = {
    'en': en,
    'ar': ar,
  };
}

extension Trans on String {
  String get tr {
    try {
      return ar[this] ?? '';
    } catch (ex) {
      return this;
    }
  }
}
