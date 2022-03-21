import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editorpane.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditorPane(),
    );
  }
}
