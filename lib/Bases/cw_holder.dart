import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/canvas_widgets.dart';

class CWHolder {
  List<CanvasWidget> _list;
  State _state;

  CWHolder(this._list, this._state);

  void add(CanvasWidget widget) {
    _state.setState(() {
      _list.add(widget);
    });
  }

  void remove(CanvasWidget widget) {
    _state.setState(() {
      _list.remove(widget);
    });
  }

  void insert(int index, CanvasWidget widget) {
    _state.setState(() {
      _list.insert(index, widget);
    });
  }

  CanvasWidget elementAt(int index) {
    return _list.elementAt(index);
  }

  int indexOf(CanvasWidget widget) => _list.indexOf(widget);

  int length() => _list.length;

  bool isNotEmpty() => _list.length != 0;
  bool isEmpty() => _list.length == 0;

  List<CanvasWidget> getChildren() => _list;
}
