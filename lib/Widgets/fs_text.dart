import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/fsketch_widget.dart';

// ignore: must_be_immutable
class FSText extends StatefulWidget implements FlutterSketchWidget {
  
  
  @override
  Map _props = {
    "key": GlobalKey(),
    "name": "text",
    "text": "textview",
    "color": Colors.amber
  };

  FSText({Key? key}) : super(key: key) {
    _props["name"] = "hello";
  }

  @override
  State _state = _FSTextState();


  @override
  void set(String property, dynamic value) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _props[property] = value;
    });
  }

  @override
  String? classname;

  @override
  String? id;

  @override
  bool? isMultiChilded;

  @override
  bool? isViewGroup;

  @override
  Map getProperties() {
    // TODO: implement getProperties
    throw UnimplementedError();
  }

  @override
  Object toDataObject() {
    // TODO: implement toDataObject
    throw UnimplementedError();
  }

  @override
  List<Widget>? children;


    @override
  // ignore: no_logic_in_create_state
  _FSTextState createState() => _state as _FSTextState;
}

class _FSTextState extends State<FSText> {
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
