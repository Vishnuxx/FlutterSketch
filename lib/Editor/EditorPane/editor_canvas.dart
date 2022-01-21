/*
  place where widgets are dropped and arranged
 */

import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/canvas_widgets.dart';
import 'package:flutteruibuilder/Bases/cw_holder.dart';

class EditorCanvas extends StatefulWidget {
  _EditorCanvasState _state = _EditorCanvasState();
  List<CanvasWidget>? children;
  CWHolder? _cwHolder;

  EditorCanvas({Key? key, this.children}) : super(key: key) {
    this._cwHolder = CWHolder(children!, _state);
  }

  CWHolder? getHolder() {
    return _cwHolder;
  }

  @override
  _EditorCanvasState createState() => _state;
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
