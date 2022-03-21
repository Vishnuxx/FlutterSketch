// ignore: file_names
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/cw_drag_data.dart';
import 'package:flutteruibuilder/Editor/Bases/FSWidget/fsketch_widget.dart';

abstract class CanvasWidgetFunctions {
  late String id;
  final Map<String, dynamic> _props = {};

  void select(bool isSelected);
  void update();
  // void unselect();
  void setVisible(bool visibility);
  bool isVisible();

  void showWireframe(bool value);

  void setProperty(String property, dynamic value);

  List<CanvasWidget> getChildren();

  void addChild(CanvasWidget widget);
  void removeChild(CanvasWidget widget);
  void insertChild(int index, CanvasWidget child);

  void setParent(CanvasWidget widget);
  CanvasWidget? getParent();

  FlutterSketchWidget getFSWidget();

  CWDragData? pickUp(
      CanvasWidget
          canvas); //picks up the canvas widget and returns its old parent
  void dropTo(CWDragData data, CanvasWidget dropzone);
}
