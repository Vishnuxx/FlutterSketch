import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Palette/fsketch_widget.dart';

class FSContainer extends StatefulWidget implements FlutterSketchWidget {
  @override
  State _state = _FSContainerState();

  @override
  Map _props = {"width": 200, "height": 100 , "color" : Colors.blue};

  FSContainer({Key? key}) : super(key: key);

  @override
  _FSContainerState createState() => _state as _FSContainerState;

  @override
  List<Widget>? children;

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

class _FSContainerState extends State<FSContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.parse(widget._props["width"].toString()),
      height: double.parse(widget._props["height"].toString()),
      color: widget._props["color"],
    );
  }
}
