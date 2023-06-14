import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wings/features/index/view/index.view.dart';

import 'core/immutable/app.wings.dart';
import 'core/immutable/main.wings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Wings.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WingsApp(
      title: 'Flutter Wings',
      home: IndexView(),
    );
  }
}
