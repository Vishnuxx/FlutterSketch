/* 

FlutterSketchWidget is the SuperClass of the widgets 
that are being dragged and dropped in the canvas

*/

import 'package:flutter/material.dart';

abstract class FlutterSketchWidget extends Widget {
  State? _state;  //state of the widget
  String? classname; //classname of the widget to get the class of the target widget 
  String? id; //id of the widget

  Map? _props; //all properties of the widget is deefined here

  bool? isMultiChilded; //checks if it can hold multiple children
  bool? isViewGroup; //checks if it can hold children
  List<Widget>? children; //list of children it can hold

  void set(String property , dynamic value); //used to access and edit properties of the widget in realtime

  Map getProperties(); //returns the _props map

  Object toDataObject(); //converts the _props to map
}
