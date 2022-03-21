import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';

import 'package:flutteruibuilder/Editor/Bases/WidgetController/widget_controller.dart';
import 'package:flutteruibuilder/Editor/EditorPane/components/drag_shadow.dart';
import 'package:flutteruibuilder/Editor/EditorPane/components/selection_indicator.dart';
import 'package:flutteruibuilder/Editor/EditorPane/components/selection_label.dart';
import 'package:flutteruibuilder/Editor/EditorUIPanels/element_treegraph.dart';

class EditorPaneData {
  final List<CanvasWidget> collections = [];
  final selectionIndicatior = SelectionIndicatior();
  final selectionLabel = SelectionLabel();

  CanvasWidget? currentDroppableWidget;
  CanvasWidget? currentDraggingWidget;

  bool? isSelected;
  Offset? pointerLocation;

  CWHolder? hiddenWidgets;
  List<WidgetController>? controllers = [];
  final DragShadow shadow = DragShadow();

  ElementTreeGraph? tree;
}
