
import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  var state = _TextWidgetState();
  late var props = {
    "name": "text" , 
    "text" : "textview",
    "color" : Colors.amber
  };

  TextWidget({Key? key}) : super(key: key) {
    props["name"] = "hello";
  }

  void set(String property , String value) {
    state.setState(() {
      this.props[property] = value;
    });
  }

  @override
  _TextWidgetState createState() {
    return state;
  }
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.props["text"].toString());
  }
}

class TextWidgetModel {
  String name = "textview";
}
