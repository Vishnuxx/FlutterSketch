import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widgets.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editorpane.dart';

class CWDragData {
  Widget? _oldParent;
  int _oldindex = -1;

  Widget? get oldParent => _oldParent;
  int get oldIndex => _oldindex;


  void setOldParent(Widget? parent , CanvasWidget canvas) {
    _oldParent = parent;
    if(parent != null) {
      switch (parent.runtimeType.toString()) {
        case "EditorPane":
          _oldindex = (parent as EditorPane).root!.fsWidget!.children!.indexOf(canvas);
          break;

        case "CanvasWidget":
          _oldindex = (parent as CanvasWidget).fsWidget!.children!.indexOf(canvas);
          break;
      }
    }
  }
}
