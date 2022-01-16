import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/EditorPane/selection_indicator.dart';

class EditorProvider extends ChangeNotifier {
  // ignore: constant_identifier_names
  static const double WIDGETS_PANEL_W = 150;
  // ignore: constant_identifier_names
  static const double WIDGETS_CONROLLER_PANEL_W = 200;

  // ignore: constant_identifier_names
  static const double SCREEN_W = 300;
  // ignore: constant_identifier_names
  static const double SCREEN_H = 550;

  final SelectionIndicatior _selectionIndicatior = SelectionIndicatior();
  final List<Widget> _widgets = [];
  Widget? _currentDraggingWidget;
  final GlobalKey _key = GlobalKey();
  

  SelectionIndicatior get selectionIndicator => _selectionIndicatior;
  List<Widget> get widgets => _widgets;
  Widget? get currentDraggingWidget => _currentDraggingWidget;
  GlobalKey get gKey => _key;
}
