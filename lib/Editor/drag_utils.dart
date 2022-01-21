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

  static TraversalData? findWidgetAt(
      Offset location,
      Widget widget,
      SelectionIndicatior indicatior,
      void Function(TraversalData data) hasEntered,
      void Function()? hasNotEntered) {
    TraversalData data = TraversalData();
    CanvasWidget? cv;
    List<CanvasWidget> canvasWidgets;

    if (widget.runtimeType == EditorPane) {
      data.parentList = (widget as EditorPane).widgets;
    } else {
      data.canvasWidget = (widget as CanvasWidget);
      data.parentList =
          (widget as CanvasWidget).widget!.children!.getChildren();
    }

    for (CanvasWidget cWid in data.parentList!) {
      if (DragUtils.isHitting(location, cWid)) {
        FlutterSketchWidget fsWidget = cWid.widget!;
        if (fsWidget.isViewGroup!) {
          //data.parentList = fsWidget.children!.getChildren();
          if (fsWidget.isMultiChilded!) {
           
            data = findWidgetAt(
                location, cWid, indicatior, hasEntered, hasNotEntered)!;
            print(data.canvasWidget);
            break;
          } else {
            CWHolder fsWChildren = fsWidget.children!;
            if (fsWChildren.isNotEmpty()) {
              data = findWidgetAt(
                  location, cWid, indicatior, hasEntered, hasNotEntered)!;
              break;
            } else {
              data.canvasWidget = cWid;
              break;
            }
          }
        } else {
          data.canvasWidget = cWid;
          break;
        }
      }
    }
    if (data.canvasWidget != null) hasEntered(data);
    //data.widget = cv!;
    return data;
  }

  static CanvasWidget getTappedWidget(
      CanvasWidget widget,
      Offset location,
      SelectionIndicatior indicatior,
      void Function(CanvasWidget target) hasEntered,
      void Function() hasNotEntered) {
    CanvasWidget cv = widget;
    for (CanvasWidget cWid in widget.widget!.children!.getChildren()) {
      if (DragUtils.isHitting(location, cWid)) {
        FlutterSketchWidget fsWidget = cWid.widget!;
        if (fsWidget.isViewGroup!) {
          CWHolder fsWChildren = fsWidget.children!;
          if (fsWidget.isMultiChilded!) {
            cv = cWid;
            break;
          } else {
            if (fsWChildren.isNotEmpty()) {
              cv = getTappedWidget(fsWChildren.elementAt(0), location,
                  indicatior, hasEntered, hasNotEntered);
              break;
            } else {
              cv = cWid;
              break;
            }
          }
        } else {
          cv = cWid;
          break;
        }
      }
    }
    hasEntered(cv);
    print(cv);
    return cv;
  }
}
