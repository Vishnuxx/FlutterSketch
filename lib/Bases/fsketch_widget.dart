/* 

FlutterSketchWidget is the SuperClass of the widgets 
that are being drawn  in the canvas

*/

import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/canvas_widgets.dart';
import 'package:flutteruibuilder/Bases/widget_controller.dart';

// ignore: must_be_immutable
abstract class FlutterSketchWidget extends Widget {
//state of the widget
  String?
      classname; //classname of the widget to get the class of the target widget
  String? id; //id of the widget

//all properties of the widget is deefined here

  bool? isMultiChilded; //checks if it can hold multiple children
  bool? isViewGroup; //checks if it can hold n number of children
  List<CanvasWidget>? children;

  FlutterSketchWidget({Key? key}) : super(key: key); //list of children it can hold

  void set( String property, dynamic value); //used to access and edit properties of the widget in realtime

  List<WidgetController>? controllers;

  Map getProperties(); //returns the _props map

  Object toDataObject(); //converts the _props to map
}
