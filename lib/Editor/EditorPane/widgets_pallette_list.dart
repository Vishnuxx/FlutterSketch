/*
   FlutterSketch widgets are registered here
   this class makes to identify the type of the widget and returns it to InstanceWidget class
 */

import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Palette/Widgets/fs_container.dart';
import 'package:flutteruibuilder/Palette/Widgets/fs_iconbutton.dart';
import 'package:flutteruibuilder/Palette/fsketch_widget.dart';
import 'package:flutteruibuilder/Palette/Widgets/fs_text.dart';

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
  Widget? generateWidget(String type, GlobalKey key) {
    switch (type) {
      case "TextWidget":
        return FSText(key: key);
      case "Container":
        return FSContainer(key: key);

      case "IconButton":
        return FSIconButton(key: key,);

      case "":
        break;

      case "":
        break;

      case "":
        break;

      case "":
        break;

      default:
        break;
    }
  }
}
