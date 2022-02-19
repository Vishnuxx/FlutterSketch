import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/fsketch_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/widget_controller.dart';
import 'package:flutteruibuilder/Widgets/Wrap/fs_wrap_controller.dart';
import 'package:flutteruibuilder/Widgets/column/fs_column_controller.dart';

// ignore: must_be_immutable
class FSWrap extends StatefulWidget implements FlutterSketchWidget {
  final State _state = _FSWrapState();

  final Map _props = {"width": double.infinity, "height": 100, "color": null};

  @override
  bool? isMultiChilded;

  @override
  bool? isViewGroup;

  @override
  CWHolder? children;

  @override
  List<WidgetController>? controllers;

  FSWrap({Key? key}) : super(key: key) {
    isMultiChilded = true;
    isViewGroup = true;
    children = CWHolder([], _state);
    _initControllers();
  }

  @override
  // ignore: no_logic_in_create_state
  _FSWrapState createState() => _state as _FSWrapState;

  @override
  Map getProperties() {
    return _props;
  }

  @override
  void set(String property, dynamic value) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _props[property] = value;
    });
  }

  @override
  Object toDataObject() => throw UnimplementedError();

  void _initControllers() {
    controllers = FSWrapController.getControllers(this);
  }

  @override
  void onDragMove() {
     print("fs move");
    // TODO: implement onDragMove
  }

  @override
  void onDragStart() {
    print("fs started");
    // TODO: implement onDragStart
  }

  @override
  void onDrop() {
     print("fs drop");
    // TODO: implement onDrop
  }

  @override
  bool onEnter() {
    // TODO: implement onEnter
    return true;
  }

  @override
  bool onExit() {
    // TODO: implement onExit
    return true;
  }

  @override
  void onSelect() {
    // TODO: implement onSelect
  }
}

class _FSWrapState extends State<FSWrap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.parse(widget._props["width"].toString()),
      height: double.parse(widget._props["height"].toString()),
      color: widget._props["color"],
      padding: const EdgeInsets.all(10),
      child: Wrap(
        children: (widget.children!.isNotEmpty())
            ? widget.children!.getChildren()
            : [],
      ),
    );
  }
}
