/* A special kind of List<CanvasWidget> used to store canvas widgets and update the state on list operations*/

import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widget.dart';

class CWHolder {
  
  final List<CanvasWidget> _list;
  final State _state;


  CWHolder(this._list, this._state);


  void add(CanvasWidget? widget) {
    // ignore: invalid_use_of_protected_member
    if(widget != null) {
      _state.setState(() {
        _list.add(widget);
      });
    }
   
  }


  void remove(CanvasWidget? widget) {
    // ignore: invalid_use_of_protected_member
     if (widget != null) {
        _state.setState(() {
        _list.remove(widget);
        
        
      });
     }
   
  }


  void insert(int index, CanvasWidget? widget) {
    // ignore: invalid_use_of_protected_member
     if (widget != null) {
        _state.setState(() {
        _list.insert(index, widget);
      });
     }
   
  }


  void show() {
   
   
  }


  CanvasWidget elementAt(int index) {
    return _list.elementAt(index);
  }


  int indexOf(CanvasWidget widget) => _list.indexOf(widget);


  int length() => _list.length;


  bool isNotEmpty() => _list.isNotEmpty;


  bool isEmpty() => _list.isEmpty;


  List<CanvasWidget> getChildren() => _list;
}
