import 'dart:ui';

import 'package:flutter/material.dart';

class PaletteWidget extends StatelessWidget {
  late String path ;
  late String label ;
  late bool isDraggable;
  late void Function()? onDragStart;
  late void Function(DragUpdateDetails)? onDragMove;
  late void Function()? onDragCompleted;

  PaletteWidget(
      {Key? key,
      this.path = "/pallette_icons/icon1.png",
      this.label = "widget",
      this.isDraggable = false ,
      this.onDragStart = null,
      this.onDragMove = null,
      this.onDragCompleted = null
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.isDraggable) {
      return Draggable(
        child: getWidget(),
        feedback: getWidget(),
        // Container(
        //   height: 40,
        //   width: 200,
        //   color: Colors.amber,
        // ),
       onDragStarted: this.onDragStart,
       onDragUpdate: this.onDragMove,
       onDragCompleted: this.onDragCompleted ,
    
      );
    } else {
      return getWidget();
    }
  }

  Widget getWidget() {
    return Container(
      width: 150.0,
      height: 40.0,
      margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: Colors.black12,
            width: 1,
          ),
          color: Colors.white30),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          const SizedBox(
            width: 5,
            child: null,
          ),
          Image.asset(
            this.path,
            fit: BoxFit.fill,
            width: 30.0,
            height: 30.0,
            scale: 0.8,
          ),
          SizedBox(
            width: 10,
            child: null,
          ),
          Expanded(
              child: Center(child: Text(this.label , style: TextStyle(fontSize: 15 , color: Colors.black54) , overflow: TextOverflow.ellipsis)))
        ],
      ),
    );
  }
}


