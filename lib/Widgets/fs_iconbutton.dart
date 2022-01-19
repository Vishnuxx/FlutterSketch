import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/canvas_widgets.dart';
import 'package:flutteruibuilder/Bases/fsketch_widget.dart';
import 'package:flutteruibuilder/Bases/widget_controller.dart';

// ignore: must_be_immutable
class FSIconButton extends StatefulWidget implements FlutterSketchWidget {
  final State _state = _FSIconButtonState();

  final Map _props = {"width": 200, "height": 100, "color": Colors.blue};

  FSIconButton({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _FSIconButtonState createState() => _state as _FSIconButtonState;

  @override
  List<CanvasWidget>? children;

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
    // ignore: todo
    // TODO: implement getProperties
    throw UnimplementedError();
  }

  @override
  void set(String property, dynamic value) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _props[property] = value;
    });
  }

  @override
  Object toDataObject() {
    // ignore: todo
    // TODO: implement toDataObject
    throw UnimplementedError();
  }

  @override
  List<WidgetController>? controllers;
}

class _FSIconButtonState extends State<FSIconButton> {
  @override
  Widget build(BuildContext context) {
    return const IconButton(onPressed: null, icon: Icon( Icons.ac_unit));
  }
}
