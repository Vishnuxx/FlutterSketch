import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/fsketch_widget.dart';

// ignore: must_be_immutable
class CanvasWidget extends StatelessWidget {
  String? type;


  late FlutterSketchWidget? widget;
  late void Function(TapDownDetails details)? onSelect;
  late void Function()? dragStart;
  late void Function(DragUpdateDetails details)? dragMove;
  late void Function(DraggableDetails details)? dragEnd;
  late void Function()? dragCompleted;
  CanvasWidget(
    this.type,
    this.widget,
    {Key? key, 
    this.onSelect, 
    this.dragStart, 
    this.dragMove, 
    this.dragEnd,
    this.dragCompleted
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
        key: GlobalKey(),
        child: GestureDetector(
          child: Container(
              color: Colors.amber, child: widget!),
          onTapDown: (TapDownDetails details) => onSelect!(details),
        ),
        feedback: Container(),
        onDragStarted: () => dragStart!(),
        onDragUpdate: dragMove,
        onDragEnd: dragEnd,
        onDragCompleted: dragCompleted
        ,);
  }
}
