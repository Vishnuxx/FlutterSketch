import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/canvas_widgets.dart';
import 'package:flutteruibuilder/Bases/fsketch_widget.dart';

// ignore: must_be_immutable
class SelectionIndicatior extends StatefulWidget {
  final _state = _SelectionIndicatiorState();
  Widget? _widget;
  bool _isVisible = false;
  Map _map = {
    "isVisible": true,
    "height": 0.0,
    "width": 0.0,
    "x": 0.0,
    "y": 0.0
  };

  SelectionIndicatior({Key? key}) : super(key: key);

  //set only one property at a time
  void set(String key, value) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _map[key] = value;
    });
  }

  //sets multiple properties at a time
  void setProperties(Map map) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      for (dynamic key in map.keys) {
        _map[key] = map[key];
      }
    });
  }

  void setVisibility(bool isvisible) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _isVisible = isvisible;
      _map = _map;
    });
  }

  //if visible, then highlihts the selected widget
  void selectWidget(CanvasWidget? widget, {double dx = 0, double dy = 0}) {
    try {
      if (_isVisible && widget != null) {
        _widget = widget;
        final RenderBox box = (widget.key as GlobalKey)
            .currentContext
            ?.findRenderObject() as RenderBox;
        final offset = Offset(dx, dy);
        final position = box.localToGlobal(offset);

        // ignore: invalid_use_of_protected_member
        _state.setState(() {
          _map["width"] = box.size.width;
          _map["height"] = box.size.height;
          _map["x"] = position.dx;
          _map["y"] = position.dy;
        });
      }
    } catch (e) {
      print("selectWidget : " + e.toString());
    }
  }

  //returns the selected widget
  Widget getSelectedWidget() {
    return _widget!;
  }

  @override
  // ignore: no_logic_in_create_state
  _SelectionIndicatiorState createState() => _state;
}

class _SelectionIndicatiorState extends State<SelectionIndicatior> {
  @override
  Widget build(BuildContext context) {
    if (widget._isVisible) {
      return Positioned(
          left: double.parse(widget._map["x"].toString()),
          top: double.parse(widget._map["y"].toString()),
          child: IgnorePointer(
            child: Container(
              width: double.parse(widget._map["width"].toString()),
              height: double.parse(widget._map["height"].toString()),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: const Color(0xffde0085),
                  width: 2,
                ),
              ),
            ),
          ));
    } else {
      return Container();
    }
  }
}
