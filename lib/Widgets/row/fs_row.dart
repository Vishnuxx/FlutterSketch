import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/fsketch_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/widget_controller.dart';

// ignore: must_be_immutable
class FSRow extends StatefulWidget implements FlutterSketchWidget {
  final State _state = _FSRowState();



  @override
  final Map<String, dynamic> _props = {
    "width": double.infinity,
    "height": 50,
    "color": const Color(0xff3FC5FF),
    "crossAxisAlignment" : CrossAxisAlignment.start,
  };

  @override
  bool? isMultiChilded;

  @override
  bool? isViewGroup;

  @override
  CWHolder? children;

  FSRow({Key? key }) : super(key: key) {
    isMultiChilded = true;
    isViewGroup = true;
    children = CWHolder([] , _state);
    _initControllers();
  }

  void _initControllers() {
    controllers = [
      WidgetController(
        "width",
        controllers: [
          TextField(
            controller: TextEditingController(text: _props["width"].toString()),
            onChanged: (value) {
              // ignore: invalid_use_of_protected_member
              _state.setState(() {
                _props["width"] = double.parse(value);
              });
            },
          )
        ],
      ),
      WidgetController(
        "height",
        controllers: [
          TextField(
            controller:
                TextEditingController(text: _props["height"].toString()),
            onChanged: (value) {
              // ignore: invalid_use_of_protected_member
              _state.setState(() {
                _props["height"] = double.parse(value);
              });
            },
          )
        ],
      ),
      WidgetController(
        "Color",
        controllers: [
          TextField(
            controller: TextEditingController(text: _props["color"].toString()),
            onSubmitted: (value) {
              // ignore: invalid_use_of_protected_member
              _state.setState(() {
                _props["color"] = Color(int.parse(
                    "0xff" + ((value).toString()).replaceAll('#', "")));
              });
            },
          )
        ],
      )
    ];
  }

  @override
  // ignore: no_logic_in_create_state
  _FSRowState createState() => _state as _FSRowState;

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

class _FSRowState extends State<FSRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.parse(widget._props["width"].toString()),
      height: double.parse(widget._props["height"].toString()),
      color: widget._props["color"],
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: widget._props["crossAxisAlignment"] ,
        children: (widget.children!.isNotEmpty())? widget.children!.getChildren() : []
        ,
      ),
    );
  }
}
