import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/EditorPane/widgets_pallette_list.dart';
import 'package:flutteruibuilder/Bases/fsketch_widget.dart';

class CanvasWidget extends StatelessWidget {
  String? type;


  late FlutterSketchWidget? widget;
  late void Function(FlutterSketchWidget widget)? onSelect;
  late void Function()? dragStart;
  late void Function(DragUpdateDetails details)? dragMove;
  late void Function(DraggableDetails details)? dragEnd;
  CanvasWidget(
    this.type,
    this.widget,
    {Key? key, 
    this.onSelect, 
    this.dragStart, 
    this.dragMove, 
    this.dragEnd
    }) : super(key: key) {
  
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
        key: GlobalKey(),
        child: GestureDetector(
          child: Container(
              color: Colors.amber, child: IgnorePointer(child: widget!)),
          onTap: () => onSelect!(widget!),
        ),
        feedback: Container(
            key: GlobalKey(),
            color: Colors.amber,
            width: 200,
            height: 60,
            clipBehavior: Clip.none),
        onDragStarted: () => dragStart!(),
        onDragUpdate: dragMove,
        onDragEnd: dragEnd);
  }
}
