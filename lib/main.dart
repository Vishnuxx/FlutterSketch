import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editorpane.dart';
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
        navigatorKey: MyApp.navigatorKey,
        initialRoute: "first",
        routes: {
          "first": (context) => const First(),
          "editor": (context) => const EditorScreen(),
          "third": (context) => const Third(),
        },
        title: 'Flutter Demo',
        theme: ThemeData());
  }
}
