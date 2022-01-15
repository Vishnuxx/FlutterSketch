/* 

FlutterSketchWidget is the SuperClass of the widgets 
that are being dragged and dropped in the canvas

*/

import 'package:flutter/material.dart';

abstract class FlutterSketchWidget {
  bool? isMultiChilded;
  bool? isViewGroup;
  String? classname;
  String? id;

  Map getProperties();

  Object toDataObject();
}
