/*
  place where widgets are dropped and arranged
 */

import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Bases/fsketch_widget.dart';
import 'package:flutteruibuilder/Controls/widget_controller.dart';


// ignore: must_be_immutable
class EditorCanvas extends StatefulWidget implements FlutterSketchWidget {
  final State _state = _EditorCanvasState();

  final Map _props = {

  };

  @override
  bool? isMultiChilded;

  @override
  bool? isViewGroup;

  @override
  CWHolder? children;

  EditorCanvas({Key? key}) : super(key: key) {
    isMultiChilded = true;
    isViewGroup = true;
    children = CWHolder([] , _state);
  }

  

  @override
  // ignore: no_logic_in_create_state
  _EditorCanvasState createState() => _state as _EditorCanvasState;

  @override
  Map getProperties() => throw UnimplementedError();

  @override
  void set(String property, dynamic value) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _props[property] = value;
    });
  }

  @override
  Object toDataObject() => throw UnimplementedError();

  @override
  List<WidgetController>? controllers;
}

class _EditorCanvasState extends State<EditorCanvas> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: (widget.children!.isNotEmpty())? widget.children!.getChildren() : []
        ,
      ),
    );
  }
}
