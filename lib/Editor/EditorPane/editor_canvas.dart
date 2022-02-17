/*
  place where widgets are dropped and arranged
 */

import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/fsketch_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/widget_controller.dart';

// ignore: must_be_immutable
class EditorCanvas extends StatefulWidget implements FlutterSketchWidget {
  final State _state = _EditorCanvasState();

  final Map _props = {};

  String? id;

  @override
  bool? isMultiChilded = true;

  @override
  bool? isViewGroup = true;

  @override
  CWHolder? children;

  EditorCanvas({Key? key, this.children}) : super(key: key) {
    isMultiChilded = true;
    isViewGroup = true;
    children = CWHolder([], _state);
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

class _EditorCanvasState extends State<EditorCanvas> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,

      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.children!.getChildren()
      ),
    );
  }
}
