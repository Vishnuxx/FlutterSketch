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

  // static TraversalData? findWidgetAt(
  //     bool isForSelection,
  //     Offset location,
  //     Widget widget,
  //     void Function(TraversalData data) hasEntered,
  //     void Function()? hasNotEntered) {
  //   TraversalData data = TraversalData();

  //   if (widget.runtimeType == EditorPane) {
  //     //data.canvasWidget = (widget as EditorPane).root as CanvasWidget;
  //     data.parentCWHolder = (widget as EditorPane).widgets;
  //   } else {
  //     data.canvasWidget = (widget as CanvasWidget);
  //     data.parentCWHolder = (widget as CanvasWidget).widget?.children;
  //   }

  //   for (CanvasWidget cWid in data.parentCWHolder!.getChildren()) {
  //     if (DragUtils.isHitting(location, cWid)) {
  //       //  data.canvasWidget = cWid;
  //       FlutterSketchWidget fsWidget = cWid.widget!;
  //       //if is a viewgroup
  //       if (fsWidget.isViewGroup!) {
  //         // if is multichilded
  //         if (fsWidget.isMultiChilded!) {
  //           //if children is empty
  //           if (fsWidget.children!.isEmpty()) {
  //             data.canvasWidget = cWid;
  //           } else {
  //             //if not empty
  //             data = findWidgetAt(
  //                 isForSelection, location, cWid, hasEntered, hasNotEntered)!;
  //           }
  //           break;
  //         } else {
  //           //is is single childed
  //           if (fsWidget.children!.isEmpty()) {
  //             data.canvasWidget = cWid;
  //             break;
  //           } else {
  //             data = findWidgetAt(
  //                 isForSelection,
  //                 location,
  //                 cWid.widget!.children!.elementAt(0),
  //                 hasEntered,
  //                 hasNotEntered)!;
  //             break;
  //           }
  //         }
  //       } else if (isForSelection) {
  //         //if no childed
  //         data.canvasWidget = cWid;
  //         print('no chid');
  //         break;
  //       }
  //     } else {
  //       //is not hitting
  //     }
  //   }

  //   if (data.canvasWidget != null)
  //     hasEntered(data);
  //   else
  //     hasNotEntered!();
  //   //data.widget = cv!;
  //   return data;
  // }

  //

  // static CanvasWidget getTappedWidget(
  //     CanvasWidget widget,
  //     Offset location,
  //     SelectionIndicatior indicatior,
  //     void Function(CanvasWidget target) hasEntered,
  //     void Function() hasNotEntered) {
  //   CanvasWidget cv = widget;
  //   for (CanvasWidget cWid in widget.widget!.children!.getChildren()) {
  //     if (DragUtils.isHitting(location, cWid)) {
  //       FlutterSketchWidget fsWidget = cWid.widget!;
  //       if (fsWidget.isViewGroup!) {
  //         CWHolder fsWChildren = fsWidget.children!;
  //         if (fsWidget.isMultiChilded!) {
  //           cv = cWid;
  //           break;
  //         } else {
  //           if (fsWChildren.isNotEmpty()) {
  //             cv = getTappedWidget(fsWChildren.elementAt(0), location,
  //                 indicatior, hasEntered, hasNotEntered);
  //             break;
  //           } else {
  //             cv = cWid;
  //             break;
  //           }
  //         }
  //       } else {
  //         cv = cWid;
  //         break;
  //       }
  //     }
  //   }
  //   hasEntered(cv);
  //   print(cv);
  //   return cv;
  // }

//

//

  static void findWidgetsAt(
      CWHolder parentlist,
      bool isForSelection,
      Offset location,
      Widget widget,
      void Function(TraversalData data)? hasEntered,
      void Function()? hasNotEntered) {
    TraversalData? data = TraversalData();


    DragUtils.depth(data, location, widget, parentlist, isForSelection);
    
    if (data == null ||
        data.canvasWidget != null && data.parentCWHolder != null) {
      hasEntered!(data);
    } else {
      hasNotEntered!();
    }
  }

  

  static TraversalData? depth(TraversalData? data, Offset location,
      Widget widget, CWHolder parentList, bool isForSelection) {
    // TraversalData? data = TraversalData();

    for (CanvasWidget child in parentList.getChildren()) {
      if (DragUtils.isHitting(location, child)) {
        data!.canvasWidget = child;
        data.parentCWHolder = parentList;
        FlutterSketchWidget fsw = child.widget!;
        if (fsw.isViewGroup!) {
          if (fsw.isMultiChilded!) {
            //multi childed
            DragUtils.depth(
                data, location, child, child.widget!.children!, isForSelection);
          } else if (fsw.children!.isEmpty()) {
            //single childed
            data.canvasWidget = child;
            data.parentCWHolder = parentList;
          } else {
            DragUtils.depth(data, location, fsw.children!.elementAt(0),
                child.widget!.children!, isForSelection);
          } 
          break;
        } else {
            //no childed
            data.canvasWidget = child;
            data.parentCWHolder = parentList;
        }
      }
    }

    if (data?.canvasWidget == null || data?.parentCWHolder == null) {
      data = null;
    }
    // print("jfksj" + data!.parentCWHolder!.getChildren().toString());
    return data;
  }
}
