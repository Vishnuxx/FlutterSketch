import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/canvas_widgets.dart';
import 'package:flutteruibuilder/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Bases/fs_controller.dart';
import 'package:flutteruibuilder/Bases/fsketch_widget.dart';
import 'package:flutteruibuilder/Editor/EditorPane/selection_indicator.dart';

class DragUtils {
  //checks if two widgets hits
  static bool hitTest(Offset coordinate, CanvasWidget target) {
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

  static CanvasWidget? findCanvasWidget(
      Offset location,
      List<CanvasWidget> widgets,
      SelectionIndicatior indicatior,
      void Function()? hasEntered,
      void Function()? hasNotEntered) {
    for (CanvasWidget cWid in widgets) {
      if (DragUtils.hitTest(location, cWid)) {
        FlutterSketchWidget fsWidget = cWid.widget!;
        if (fsWidget.isViewGroup!) {
          CWHolder fsWChildren = fsWidget.children!;
          if (fsWidget.isMultiChilded!) {
            hasEntered!();

            return findCanvasWidget(location, fsWChildren.getChildren(),
                indicatior, hasEntered, hasNotEntered);
          } else {
            if (fsWChildren.isNotEmpty()) {
              hasEntered!();

              return findCanvasWidget(location, fsWChildren.getChildren(),
                  indicatior, hasEntered, hasNotEntered);
            } else {
              hasEntered!();
              return cWid;
            }
          }
        } else {
          hasEntered!();
          return cWid;
        }
      }
    }
    hasNotEntered!();
    return null;
  }

  static CanvasWidget getTappedWidget(
      CanvasWidget widget,
      Offset location,
      SelectionIndicatior indicatior,
      void Function()? hasEntered,
      void Function()? hasNotEntered) {

    for (CanvasWidget cWid in widget.widget!.children!.getChildren()) {
      if (DragUtils.hitTest(location, cWid)) {
        FlutterSketchWidget fsWidget = cWid.widget!;
        if (fsWidget.isViewGroup!) {
          CWHolder fsWChildren = fsWidget.children!;
          if (fsWidget.isMultiChilded!) {
            hasEntered!();

            return getTappedWidget(cWid, location, indicatior, hasEntered, hasNotEntered);
          } else {
            if (fsWChildren.isNotEmpty()) {
              hasEntered!();

              return getTappedWidget(cWid.widget!.children!.elementAt(0), location, indicatior, hasEntered, hasNotEntered);
            } else {
              hasEntered!();
              return cWid;
            }
          }
        } else {
          hasEntered!();
          return cWid;
        }
      }
    }
    print("none");
    hasEntered!();
    return widget;
  }
}
