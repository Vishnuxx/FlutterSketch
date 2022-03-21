import 'package:flutter/material.dart';
import 'package:flutteruibuilder/editor_screen.dart';
import 'package:flutteruibuilder/first.dart';
import 'package:flutteruibuilder/third.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final navigatorKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (context) => const EditorScreen(),
          "first": (context) => const First(),
          "third": (context) => const Third(),
        },
        title: 'Flutter Demo',
        theme: ThemeData());
  }
}
