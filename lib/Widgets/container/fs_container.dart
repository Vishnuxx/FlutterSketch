import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/fsketch_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/widget_controller.dart';
import 'package:flutteruibuilder/Widgets/container/fs_container_controller.dart';

// ignore: must_be_immutable
class FSContainer extends StatefulWidget implements FlutterSketchWidget {
  final State _state = _FSContainerState();

  final Map<String , dynamic> _props = {
    "width": 200,
    "height": 100,
    "color": null //const Color(0xff3FC5FF)
  };

  
  @override
  bool? isMultiChilded;

  @override
  bool? isViewGroup;

  @override
  CWHolder? children;

  FSContainer({Key? key }) : super(key: key) {
    isMultiChilded = false;
    isViewGroup = true;
    children = CWHolder([], _state);
    _initControllers();
  }

  void _initControllers() {
    controllers = FSContainerController.getControllers(this);
  }

  @override
  // ignore: no_logic_in_create_state
  _FSContainerState createState() => _state as _FSContainerState;

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

class _FSContainerState extends State<FSContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.parse(widget._props["width"].toString()),
      height: double.parse(widget._props["height"].toString()),
      color: widget._props["color"],
      padding: const EdgeInsets.all(10),
      child: (widget.children!.isNotEmpty())
          ? widget.children!.elementAt(0)
          : null,
    );
  }
}
