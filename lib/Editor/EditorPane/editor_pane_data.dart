import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widgets.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/Bases/traversal_data.dart';
import 'package:flutteruibuilder/Editor/Bases/widget_controller.dart';
import 'package:flutteruibuilder/Editor/EditorPane/drag_shadow.dart';
import 'package:flutteruibuilder/Editor/EditorPane/selection_indicator.dart';
import 'package:flutteruibuilder/Editor/UIPanels/element_treegraph.dart';

class EditorPaneData {


  List<CanvasWidget> collections = [];
  SelectionIndicatior selectionIndicatior = SelectionIndicatior();

  CanvasWidget? currentDroppableWidget;
  CanvasWidget? currentDraggingWidget;

  bool? isSelected;
  Offset? pointerLocation;

  CWHolder? hiddenWidgets;
  List<WidgetController>? controllers = [];
  DragShadow shadow = DragShadow();

  TraversalData? dragData; //data of the dragging element
  TraversalData? dropData; //data of the drop listening element

  ElementTreeGraph? tree;
}
