import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/WidgetController/widget_controller.dart';

// ignore: must_be_immutable
class ControlsPane extends StatefulWidget {
  _ControlsPaneState _state = _ControlsPaneState();

  double? width = 0;
  double? padding = 0;
  List<Widget>? children;

  ControlsPane({Key? key, this.padding, this.width, this.children})
      : super(key: key);

  void setControls(List<WidgetController>? controllers) {
    _state.setState(() {
      children = controllers;
    });
  }

  @override
  State<ControlsPane> createState() => _state;
}

class _ControlsPaneState extends State<ControlsPane> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        decoration: const BoxDecoration(
            border:
                Border(left: BorderSide(width: 0.5, color: Color(0xff666BB4)))),
        padding: EdgeInsets.all(widget.padding!),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: (widget.children != null)? widget.children! : [],
        ));
  }
}
