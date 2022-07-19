import 'package:flutter/material.dart';
import 'package:wings/core/immutable/app.wings.dart';
import 'package:wings/features/index/view/index.view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WingsApp(
      title: 'Flutter Wings',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexView(),
    );
  }
}
