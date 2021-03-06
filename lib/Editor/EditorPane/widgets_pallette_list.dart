/*
   FlutterSketch widgets are registered here
   this class makes to identify the type of the widget and returns it to InstanceWidget class
 */

import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Widgets/Wrap/fs_wrap.dart';
import 'package:flutteruibuilder/Widgets/column/fs_column.dart';
import 'package:flutteruibuilder/Widgets/container/fs_container.dart';
import 'package:flutteruibuilder/Widgets/iconbutton/fs_iconbutton.dart';
import 'package:flutteruibuilder/Editor/Bases/FSWidget/fsketch_widget.dart';
import 'package:flutteruibuilder/Widgets/row/fs_row.dart';
import 'package:flutteruibuilder/Widgets/stack/fs_stack.dart';
import 'package:flutteruibuilder/Widgets/text/fs_text.dart';

class WidgetsPalletteList {
  final Map<String, Widget> _widgets = {};

  void registerWidget(String key, Widget widget) {
    if (_widgets[key] == null) {
      _widgets[key] = widget;
    } else {
      throw "The Key { $key } already being used by another widget. Try another id";
    }
  }

  void unRegisterWidget(String key) {
    _widgets.remove(key);
  }

  //always call with a new keyword to avoid calling by reference
  // ignore: empty_constructor_bodies
  FlutterSketchWidget? generateWidget(String type , GlobalKey key) {
    switch (type) {
      case "TextWidget":
        return FSText(
          key: key , 
          
        );

      case "Container":
        return FSContainer(
          key: key , 
       
        );

      case "IconButton":
        return FSIconButton(
          key: key,
         
        );

      case "Column":
        return FSColumn(
          key: key,
     
        );

      case "Row":
        return FSRow(
          key: key,
         
        );

      case "Stack":
        return FSStack(
          key: key,
      
        );

      case "Wrap":
        return FSWrap(
          key: key,
        );

      default:
        break;
    }
    return null;
  }
}
