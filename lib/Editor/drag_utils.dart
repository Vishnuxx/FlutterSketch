import 'package:flutter/material.dart';

class DragUtils {
  //checks if two widgets hits
  static bool hitTest(Offset coordinate, Widget target) {
    RenderBox box2 = (target.key as GlobalKey)
        .currentContext
        ?.findRenderObject() as RenderBox;

    final size2 = box2.size;
    final pos = box2.localToGlobal(Offset.zero);
    final collide = coordinate.dx > pos.dx && coordinate.dx < (pos.dx + size2.width) && coordinate.dy > pos.dy && coordinate.dy < (pos.dy + size2.height);

    return collide;
  }
}
