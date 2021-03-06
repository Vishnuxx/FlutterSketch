import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/Bases/FSWidget/fsketch_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/WidgetController/widget_controller.dart';

// ignore: must_be_immutable
class FSStack extends StatefulWidget implements FlutterSketchWidget {
  final State _state = _FSStackState();

   @override
  final Map<String, dynamic> _props = {
    "width": 200,
    "height": 100,
    "color": const Color(0xff3FC5FF)
  };

  @override
  bool? isMultiChilded;

  @override
  bool? isViewGroup;

  @override
  CWHolder? children;

  FSStack({Key? key }) : super(key: key) {
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
  _FSStackState createState() => _state as _FSStackState;

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

class _FSStackState extends State<FSStack> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.parse(widget._props["width"].toString()),
      height: double.parse(widget._props["height"].toString()),
      color: widget._props["color"],
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: (widget.children!.isNotEmpty())? widget.children!.getChildren() : []
        ,
      ),
    );
  }
}
