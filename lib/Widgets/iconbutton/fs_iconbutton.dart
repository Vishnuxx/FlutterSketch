import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/Bases/FSWidget/fsketch_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/WidgetController/widget_controller.dart';

// ignore: must_be_immutable
class FSIconButton extends StatefulWidget implements FlutterSketchWidget {
  final State _state = _FSIconButtonState();

   @override
  final Map<String, dynamic> _props = {"width": 200, "height": 100, "color": Colors.blue};

 

    @override
  bool? isMultiChilded;

  @override
  bool? isViewGroup;

  @override
  CWHolder? children;

  FSIconButton({Key? key  }) : super(key: key){
    isMultiChilded = false;
    isViewGroup = false;
    children = CWHolder([] , _state);
  }

  @override
  // ignore: no_logic_in_create_state
  _FSIconButtonState createState() => _state as _FSIconButtonState;


 

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

class _FSIconButtonState extends State<FSIconButton> {
  @override
  Widget build(BuildContext context) {
    return const IconButton(onPressed: null, icon: Icon( Icons.ac_unit));
  }
}
