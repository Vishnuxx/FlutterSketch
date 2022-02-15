import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widgets.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/cw_drag_data.dart';

abstract class CWDragMethods {
  CWDragData? pickUp(
      CanvasWidget
          canvas); //picks up the canvas widget and returns its old parent
  void dropTo(CWDragData data ,  CanvasWidget dropzone);
}
