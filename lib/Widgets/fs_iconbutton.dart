import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/canvas_widgets.dart';
import 'package:flutteruibuilder/Bases/fsketch_widget.dart';

class FSIconButton extends StatefulWidget implements FlutterSketchWidget {
  @override
  State _state = _FSIconButtonState();

  @override
  Map _props = {"width": 200, "height": 100, "color": Colors.blue};

  FSIconButton({Key? key}) : super(key: key);

  @override
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
    // TODO: implement getProperties
    throw UnimplementedError();
  }

  @override
  void set(String property, dynamic value) {
    _state.setState(() {
      _props[property] = value;
    });
  }

  @override
  Object toDataObject() {
    // TODO: implement toDataObject
    throw UnimplementedError();
  }
}

class _FSIconButtonState extends State<FSIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: null, icon: Icon( Icons.ac_unit));
  }
}
