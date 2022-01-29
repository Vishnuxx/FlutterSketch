// ignore: file_names
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widgets.dart';

abstract class CanvasWidgetFunctions {
  late String id;
  final Map<String, dynamic> _props = {};

  void select();
  void unselect();

  

  void showWireframe(bool value);

  void setProperty(String property, dynamic value);

  void addChild(CanvasWidget widget);
  void removeChild(CanvasWidget widget);
  void insertChild(int index, CanvasWidget child);

  void setParent(CanvasWidget widget);
  CanvasWidget? getParent();
}
