import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/Bases/FSWidget/fsketch_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/WidgetController/widget_controller.dart';

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

  @override
  final Map<String, dynamic> _props = {
    "name": "text",
    "text": "textview",
    "color": Colors.amber
  };

  FSText({Key? key}) : super(key: key) {
    isMultiChilded = false;
    isViewGroup = false;
    children = CWHolder([], _state);
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
    return _props;
  }

  @override
  Object toDataObject() => throw UnimplementedError();

  @override
  // ignore: no_logic_in_create_state
  _FSTextState createState() => _state as _FSTextState;

  @override
  void onDragMove() {
    // TODO: implement onDragMove
  }

  @override
  void onDragStart() {
    // TODO: implement onDragStart
  }

  @override
  void onDrop() {
    // TODO: implement onDrop
  }

  @override
  bool onEnter() {
    // TODO: implement onEnter
    throw UnimplementedError();
  }

  @override
  bool onExit() {
    // TODO: implement onExit
    throw UnimplementedError();
  }

  @override
  void onSelect() {
    // TODO: implement onSelect
  }
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
