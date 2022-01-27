import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widgets.dart';

abstract class CanvasWidgetFunctions {
  void setProperty(String property, dynamic value);

  void addChild(CanvasWidget widget);
  void removeChild(CanvasWidget widget);
  void insertChild(int index, CanvasWidget widget);

  void setParent(CanvasWidget widget);
  CanvasWidget getParent();

  void onSelect();
  void onDragStart();
  void onDragMove();
  void onEnter();
  void onExit();
  void onDrop();
}
