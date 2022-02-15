// ignore: file_names
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widgets.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/fsketch_widget.dart';

abstract class CanvasWidgetFunctions {
  late String id;
  final Map<String, dynamic> _props = {};

  void select(bool isSelected);
  // void unselect();

  void showWireframe(bool value);

  void setProperty(String property, dynamic value);

  void addChild(CanvasWidget widget);
  void removeChild(CanvasWidget widget);
  void insertChild(int index, CanvasWidget child);

  void setParent(CanvasWidget widget);
  CanvasWidget? getParent();

  FlutterSketchWidget getFSWidget();
}
