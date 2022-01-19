import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/canvas_widgets.dart';
import 'package:flutteruibuilder/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Bases/fsketch_widget.dart';
import 'package:flutteruibuilder/Bases/widget_controller.dart';

// ignore: must_be_immutable
class FSText extends StatefulWidget implements FlutterSketchWidget {
  @override
  bool? isMultiChilded;

  @override
  bool? isViewGroup;

  @override
  List<WidgetController>? controllers;

  @override
  CWHolder? children;

  final Map _props = {
    "key": GlobalKey(),
    "name": "text",
    "text": "textview",
    "color": Colors.amber
  };

  FSText({Key? key}) : super(key: key) {
    isMultiChilded = false;
    isViewGroup = false;
    children = CWHolder([] , _state as State);;
    _initControllers();
  }

  void _initControllers() {
    controllers = [
      WidgetController(
        "text",
        controllers: [
          TextField(
            controller: TextEditingController(text: _props["text"].toString()),
            onChanged: (value) {
              // ignore: invalid_use_of_protected_member
              _state.setState(() {
                _props["text"] = value;
              });
            },
          )
        ],
      )
    ];
  }

  final State _state = _FSTextState();

  @override
  void set(String property, dynamic value) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _props[property] = value;
    });
  }

  @override
  Map getProperties() {
    // ignore: todo
    // TODO: implement getProperties
    throw UnimplementedError();
  }

  @override
  Object toDataObject() => throw UnimplementedError();

  

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
