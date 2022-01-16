
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PaletteWidget extends StatelessWidget {
  late String path = "/pallette_icons/icon1.png";
  late String label ;
  late bool isDraggable;
  late void Function()? onDragStart;
  late void Function(DragUpdateDetails)? onDragMove;
  late void Function()? onDragCompleted;

  PaletteWidget(
      {Key? key,
      this.path = "/pallette_icons/icon1.png" ,
      this.label = "widget",
      this.isDraggable = false ,
      this.onDragStart,
      this.onDragMove,
      this.onDragCompleted
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isDraggable) {
      return Draggable(
        child: getWidget(),
        feedback: getWidget(),
        // Container(
        //   height: 40,
        //   width: 200,
        //   color: Colors.amber,
        // ),
       onDragStarted: onDragStart,
       onDragUpdate: onDragMove,
       onDragCompleted: onDragCompleted ,
    
      );
    } else {
      return getWidget();
    }
  }

  Widget getWidget() {
    return Container(
      width: 150.0,
      height: 40.0,
      margin: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
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
            path,
            fit: BoxFit.fill,
            width: 30.0,
            height: 30.0,
            scale: 0.8,
          ),
          const SizedBox(
            width: 10,
            child: null,
          ),
          Expanded(
              child: Center(child: Text(label , style: const TextStyle(fontSize: 15 , color: Colors.black54) , overflow: TextOverflow.ellipsis)))
        ],
      ),
    );
  }
}


