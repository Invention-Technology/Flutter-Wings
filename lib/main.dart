import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wings/core/immutable/main.wings.dart';
import 'package:wings/features/index/view/index.view.dart';

import 'core/mutable/translations/languages/translation.mapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Wings.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',

      translationsKeys: TranslationMapper.keys,
      // get the current language text direction
      textDirection: Wings.language.currentLanguage.textDirection,
      // get the current language locale
      locale: Wings.language.currentLanguage.locale,
      fallbackLocale: Wings.language.currentLanguage.locale,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexView(),
    );
  }
}
