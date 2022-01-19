/*
  place where widgets are dropped and arranged
 */

import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/canvas_widgets.dart';
import 'package:flutteruibuilder/Editor/drag_utils.dart';

class EditorCanvas extends StatefulWidget {

  List<CanvasWidget>? children;

  EditorCanvas({Key? key, this.children}) : super(key: key);

  bool hasEntered(Offset offset) {
    RenderBox box2 = (key as GlobalKey).currentContext?.findRenderObject() as RenderBox;
    final size2 = box2.size;
    final pos = box2.localToGlobal(Offset.zero);
    final collide = offset.dx > pos.dx &&
        offset.dx < (pos.dx + size2.width) &&
        offset.dy > pos.dy &&
        offset.dy < (pos.dy + size2.height);
    return collide;
  }

  @override
  _EditorCanvasState createState() => _EditorCanvasState();
}

class _EditorCanvasState extends State<EditorCanvas> {
  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.children!,
          ),
        );
      },
    );
  }
}
