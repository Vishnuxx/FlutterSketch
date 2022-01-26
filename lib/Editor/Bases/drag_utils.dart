import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/canvas_widgets.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/Bases/fsketch_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/traversal_data.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editorpane.dart';
import 'package:flutteruibuilder/Editor/EditorPane/selection_indicator.dart';

class DragUtils {
  //checks if two widgets hits
  static bool isHitting(Offset coordinate, CanvasWidget target) {
    RenderBox box2 = (target.key as GlobalKey)
        .currentContext
        ?.findRenderObject() as RenderBox;

    final size2 = box2.size;
    final pos = box2.localToGlobal(Offset.zero);
    final collide = coordinate.dx > pos.dx &&
        coordinate.dx < (pos.dx + size2.width) &&
        coordinate.dy > pos.dy &&
        coordinate.dy < (pos.dy + size2.height);

    return collide;
  }

  static void findWidgetsAt(
      CWHolder parentlist,
      bool isForSelection,
      Offset location,
      Widget widget,
      void Function(TraversalData data) hasEntered,
      void Function() hasNotEntered) {
    TraversalData? data = TraversalData();
    bool isEntered = false;

    if (widget.runtimeType == EditorPane) {
      if (DragUtils.isHitting(location, (widget as EditorPane).root!)) {
        isEntered = true;
        DragUtils.depth(data, location, widget, parentlist, isForSelection);
      } else {
        isEntered = false;
      }
    } else {
      DragUtils.depth(data, location, widget, parentlist, isForSelection);
      isEntered = true;
    }
    
    if (isEntered && data.canvasWidget != null) {
      hasEntered(data);
    } else {
      hasNotEntered();
    }
  }


  static void depth(TraversalData? data, Offset location, Widget widget,
      CWHolder parentList, bool isForSelection) {
    // TraversalData? data = TraversalData();

    CanvasWidget? canvas;
    if (widget.runtimeType == EditorPane) {
      canvas = (widget as EditorPane).root;
      data?.parentCWHolder = parentList;
      data?.childCWHolder = (widget as EditorPane).root?.widget?.children;
    } else {
      canvas = widget as CanvasWidget;
      data?.parentCWHolder = parentList;
      data?.childCWHolder = canvas.widget!.children;
    }
    data?.canvasWidget = canvas;

    for (CanvasWidget child in data!.childCWHolder!.getChildren()) {
      if (DragUtils.isHitting(location, child)) {
        FlutterSketchWidget fw = child.widget!;
        if (fw.isViewGroup!) {
          if (fw.isMultiChilded!) {
            data.canvasWidget = child;
            DragUtils.depth(data, location, data.canvasWidget!,
                data.childCWHolder!, isForSelection);
          } else {
            if (isForSelection) {
              data.canvasWidget = child;
            DragUtils.depth(data, location, data.canvasWidget!,
                data.childCWHolder!, isForSelection);
            }
            else{
              if(fw.children!.isEmpty()) {
                 data.canvasWidget = child;
            DragUtils.depth(data, location, data.canvasWidget!,
                data.childCWHolder!, isForSelection);
             }else{
              
               CanvasWidget? w = fw.children?.elementAt(0);
                 data.canvasWidget = child;
                   DragUtils.depth(data, location, w! ,
                data.childCWHolder!, isForSelection);
             
          
             }
            }
          }
        } else {
          if (isForSelection) {
            data.canvasWidget = child;
            DragUtils.depth(data, location, data.canvasWidget!,
                data.childCWHolder!, isForSelection);
          }
        }
      }
    }
  }
}
