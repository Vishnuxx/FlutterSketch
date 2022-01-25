import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/canvas_widgets.dart';

class ElementTreeGraph extends StatefulWidget {
  _ElementTreeGraphState _state = _ElementTreeGraphState();
  double? width = 0;
  List<Widget>? nodes = [];
  void Function(CanvasWidget wid)? onWidgetSelected;

  ElementTreeGraph({Key? key, this.width, this.onWidgetSelected})
      : super(key: key);

  void refresh(List<CanvasWidget>? list) {
    _state.setState(() {
      nodes = [];
      _state.drawTree(list, 0);
    });
  }

  @override
  // ignore: no_logic_in_create_state
  State<ElementTreeGraph> createState() => _state;
}

class _ElementTreeGraphState extends State<ElementTreeGraph> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tree Graph"),
           ...widget.nodes!,
          ]
        ));
  }

  drawTree(List<CanvasWidget>? list, double marg) {
    for (CanvasWidget node in list!) {
      widget.nodes?.add(treeTile(marg ,  node));
      drawTree(node.widget?.children?.getChildren(), marg + 10);
    }
  }

  Widget treeTile(double margin, CanvasWidget? node) {
    return Container(
        padding: EdgeInsets.only(left: margin, top: 3, right: 0, bottom: 0),
        width: double.infinity,
        height: 30.0,
        child: GestureDetector(
          child: Text("Vishnu" + margin.toString()),
          onTapDown: (details) {
            widget.onWidgetSelected!(node!);
          },
        ));
  }
}
