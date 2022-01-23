import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Bases/fsketch_widget.dart';
import 'package:flutteruibuilder/Bases/widget_controller.dart';

// ignore: must_be_immutable
class FSContainer extends StatefulWidget implements FlutterSketchWidget {
  final State _state = _FSContainerState();

  final Map _props = {
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

  FSContainer({Key? key}) : super(key: key) {
    isMultiChilded = false;
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
  _FSContainerState createState() => _state as _FSContainerState;

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

class _FSContainerState extends State<FSContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.parse(widget._props["width"].toString()),
      height: double.parse(widget._props["height"].toString()),
      color: widget._props["color"],
      padding: const EdgeInsets.all(10),
      child: (widget.children!.isNotEmpty())? widget.children!.elementAt(0) : null,
    );
  }
}
