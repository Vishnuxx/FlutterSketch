import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/FSWidget/fsketch_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/WidgetController/widget_controller.dart';

class FSWrapController {
  static List<WidgetController> getControllers(FlutterSketchWidget widget) {
    Map props = widget.getProperties();

    return [
      WidgetController(
        "width",
        controllers: [
          TextField(
            controller: TextEditingController(text: props["width"].toString()),
            onChanged: (value) {
              // ignore: invalid_use_of_protected_member
              widget.set("width", double.parse(value));
            },
          )
        ],
      ),
      WidgetController(
        "height",
        controllers: [
          TextField(
            controller: TextEditingController(text: props["height"].toString()),
            onChanged: (value) {
              // ignore: invalid_use_of_protected_member
              widget.set("height", double.parse(value));
            },
          )
        ],
      ),
      WidgetController(
        "Color",
        controllers: [
          TextField(
            controller: TextEditingController(text: props["color"].toString()),
            onSubmitted: (value) {
              widget.set(
                  "color",
                  Color(int.parse(
                      "0xff" + ((value).toString()).replaceAll('#', ""))));
            },
          )
        ],
      )
    ];
  }
}
