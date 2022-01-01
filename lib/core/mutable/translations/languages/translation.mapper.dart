import 'ar/_ar.trans.dart';
import 'en/_en.trans.dart';

abstract class TranslationMapper {
  static Map<String, Map<String, String>> keys = {
    'en': en,
    'ar': ar,
  };
}
