import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widgets.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/fsketch_widget.dart';

import 'package:flutteruibuilder/Editor/EditorPane/editorpane.dart';
import 'package:flutteruibuilder/Editor/UIPanels/canvas_panel.dart';

class DragUtils {
  // static Offset toRelativeOffset(Offset offset) {
  //   final mOff = (EditorPane.panelContext?.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
  //   return offset.translate(-mOff.dx, -mOff.dy);
  // }

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

  // static void findWidgetsAt(
  //     CWHolder parentlist,
  //     bool isForSelection,
  //     Offset location,
  //     Widget widget,
  //     void Function() hasEntered,
  //     void Function() hasNotEntered) {
  //   //

  //   bool isEntered = false;

  //   if (widget.runtimeType == EditorPane) {
  //     if (DragUtils.isHitting(location, (widget as EditorPane).root!)) {
  //       isEntered = true;
  //       DragUtils.depth(data, location, widget, parentlist, isForSelection);
  //     } else {
  //       isEntered = false;
  //     }
  //   } else {
  //     DragUtils.depth(data, location, widget, parentlist, isForSelection);
  //     isEntered = true;
  //   }

  //   if (isEntered && data.canvasWidget != null) {
  //     hasEntered(data);
  //   } else {
  //     hasNotEntered();
  //   }
  // }

  // static void depth(TraversalData? data, Offset location, Widget widget,
  //     CWHolder parentList, bool isForSelection) {
  //   // TraversalData? data = TraversalData();

  //   CanvasWidget? canvas;
  //   if (widget.runtimeType == EditorPane) {
  //     canvas = (widget as EditorPane).root;
  //     data?.parentCWHolder = parentList;
  //     data?.childCWHolder = (widget).root?.fsWidget?.children;
  //   } else {
  //     canvas = widget as CanvasWidget;
  //     data?.parentCWHolder = parentList;
  //     data?.childCWHolder = canvas.fsWidget!.children;
  //   }
  //   data?.canvasWidget = canvas;

  //   data?.canvasWidget?.select();
  //   for (CanvasWidget child in data!.childCWHolder!.getChildren()) {
  //     if (DragUtils.isHitting(location, child)) {
  //       data.canvasWidget?.unselect();
  //       child.select();
  //       FlutterSketchWidget fw = child.fsWidget!;
  //       if (fw.isViewGroup!) {
  //         if (fw.isMultiChilded!) {
  //           data.canvasWidget = child;
  //           DragUtils.depth(data, location, data.canvasWidget!,
  //               data.childCWHolder!, isForSelection);
  //         } else {
  //           if (isForSelection) {
  //             data.canvasWidget = child;
  //             DragUtils.depth(data, location, data.canvasWidget!,
  //                 data.childCWHolder!, isForSelection);
  //           } else {
  //             if (fw.children!.isEmpty()) {
  //               data.canvasWidget = child;
  //               DragUtils.depth(data, location, data.canvasWidget!,
  //                   data.childCWHolder!, isForSelection);
  //             } else {
  //               CanvasWidget? w = fw.children?.elementAt(0);
  //               data.canvasWidget = child;
  //               DragUtils.depth(
  //                   data, location, w!, data.childCWHolder!, isForSelection);
  //             }
  //           }
  //         }
  //       } else if (isForSelection) {
  //         data.canvasWidget = child;
  //         DragUtils.depth(data, location, data.canvasWidget!,
  //             data.childCWHolder!, isForSelection);
  //       }
  //     } else {
  //       child.unselect();
  //     }
  //   }
  // }

  static void findTargetAtLocation(CanvasWidget parent, Offset location,
      {required void Function(CanvasWidget? parent) callback}) {
    if (isHitting(location, parent)) {
      if (!parent.isViewGroup) {
        callback(parent);
        return;
      }

      List<CanvasWidget> children = parent.getChildren();
      if (children.length == 0) {
        callback(parent);
        print("length is 0");
        return;
      }

      for (CanvasWidget child in children) {
        if (isHitting(location, child)) {
          if (child.isMultiChilded) {
            findTargetAtLocation(child, location,
                callback: (par) => callback(par));
          } else {
            if (child.getChildren().isNotEmpty) {
              findTargetAtLocation(child, location,
                  callback: (par) => callback(par));
            } else {
              callback(child);
            }
          }
          return;
        }
      }

      callback(parent);
      return;
    }
  }
}
