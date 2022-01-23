import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/canvas_widgets.dart';
import 'package:flutteruibuilder/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Bases/fsketch_widget.dart';
import 'package:flutteruibuilder/Bases/traversal_data.dart';
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
      void Function(TraversalData data)? hasEntered,
      void Function()? hasNotEntered) {
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

    print(data.canvasWidget.toString() + isEntered.toString());
    data.parentCWHolder?.show();
    if (data.canvasWidget == null && isEntered) {
      print("Entererrerererer");
      data.canvasWidget = (widget as EditorPane).root;
      data.parentCWHolder = parentlist;
      hasEntered!(data);
    } else {
      if (isEntered) {
        hasEntered!(data);
      } else {
        hasNotEntered!();
      }
    }
  }

  static void depth(TraversalData? data, Offset location, Widget widget,
      CWHolder parentList, bool isForSelection) {
    // TraversalData? data = TraversalData();

    for (CanvasWidget child in parentList.getChildren()) {
      if (DragUtils.isHitting(location, child)) {
        data!.canvasWidget = child;
        data.parentCWHolder = child.widget!.children!;
        FlutterSketchWidget fsw = child.widget!;
        if (fsw.isViewGroup!) {
          if (fsw.isMultiChilded!) {
            //multi childed
            DragUtils.depth(
                data, location, child, child.widget!.children!, isForSelection);
          } else {
             //single childed
            if (fsw.children!.isEmpty()) {
             
              data.canvasWidget = child;
              data.parentCWHolder = child.widget!.children!;
            } else {
              DragUtils.depth(data, location, fsw.children!.elementAt(0),
                  child.widget!.children!, isForSelection);
            }
          }
          break;
        } else {
          //no childed
          if (isForSelection) {
            data.canvasWidget = child;
            data.parentCWHolder = parentList;
          }
          break;
        }
      }
    }

    if (data?.canvasWidget == null || data?.parentCWHolder == null) {
      data = null;
    }
  }
}
