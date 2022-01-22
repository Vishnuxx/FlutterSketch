import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/fsketch_widget.dart';

// ignore: must_be_immutable
class CanvasWidget extends StatelessWidget {
  
  bool? isDraggableAndSelectable;

  late FlutterSketchWidget? widget;
  late void Function(TapDownDetails details)? onSelect;
  late void Function()? dragStart;
  late void Function(DragUpdateDetails details)? dragMove;
  late void Function(DraggableDetails details)? dragEnd;
  late void Function()? dragCompleted;
  CanvasWidget(this.widget, this.isDraggableAndSelectable,
      {Key? key,
      this.onSelect,
      this.dragStart,
      this.dragMove,
      this.dragEnd,
      this.dragCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isDraggableAndSelectable!) {
      return Draggable(
        key: GlobalKey(),
        child: GestureDetector(
          child: Container(color: Colors.amber, child: IgnorePointer(child: widget!)),
          onTapDown: (TapDownDetails details) => onSelect!(details),
        ),
        feedback: Container(),
        onDragStarted: () => dragStart!(),
        onDragUpdate: dragMove,
        onDragEnd: dragEnd,
        onDragCompleted: dragCompleted,
      );
    } else {
      return Container(color: Colors.amber, child: widget!);
    }
  }
}
