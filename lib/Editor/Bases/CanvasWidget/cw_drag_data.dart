import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widget.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editorpane.dart';

class CWDragData {
  CanvasWidget? _oldParent;
  int _oldindex = -1;

  CanvasWidget? get oldParent => _oldParent;
  int get oldIndex => _oldindex;


  void setOldParent(CanvasWidget? parent , CanvasWidget canvas) {
    _oldParent = parent;
    if(parent != null) {
          _oldindex = (parent as CanvasWidget).fsWidget!.children!.indexOf(canvas);

    }
  }
}
