import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextWidget extends StatefulWidget {
  var state = _TextWidgetState();

  final _props = {"name": "text", "text": "textview", "color": Colors.amber};

  TextWidget({Key? key}) : super(key: key) {
    _props["name"] = "hello";
  }

  void set(String property, String value) {
    // ignore: invalid_use_of_protected_member
    state.setState(() {
      _props[property] = value;
    });
  }

  @override
  // ignore: no_logic_in_create_state
  _TextWidgetState createState() => state;

}

class _TextWidgetState extends State<TextWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(widget._props["text"].toString());
  }

 
}

class TextWidgetModel {
  String name = "textview";
}
