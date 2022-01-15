import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/EditorPane/selection_indicator.dart';

class EditorProvider extends ChangeNotifier {
  final double WIDGETS_PANEL_W = 150;
  final double WIDGETS_CONROLLER_PANEL_W = 200;

  final double SCREEN_W = 300;
  final double SCREEN_H = 550;

  SelectionIndicatior _selectionIndicatior = SelectionIndicatior();
  List<Widget> _widgets = [];
  Widget? _currentDraggingWidget;
  GlobalKey _key = GlobalKey();
  

  SelectionIndicatior get selectionIndicator => _selectionIndicatior;
  List<Widget> get widgets => _widgets;
  Widget? get currentDraggingWidget => _currentDraggingWidget;
  GlobalKey get gKey => _key;
}
