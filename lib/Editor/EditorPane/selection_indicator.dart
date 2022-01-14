import 'package:flutter/material.dart';

class SelectionIndicatior extends StatefulWidget {
  final _state = _SelectionIndicatiorState();
  Widget? _widget;
  bool _isVisible = false;
  final _map = {
    "isVisible": true,
    "height": 0.0,
    "width": 0.0,
    "x": 0.0,
    "y": 0.0
  };

  SelectionIndicatior({Key? key}) : super(key: key);

  void set(String key, value) {
    _state.setState(() {
      _map[key] = value;
    });
  }

  void setVisibility(bool isvisible) {
    _isVisible = isvisible;
  }

  void selectWidget(Widget widget, {double dx = 0, double dy = 0}) {
    _widget = widget;
    final RenderBox box = (widget.key as GlobalKey)
        .currentContext
        ?.findRenderObject() as RenderBox;
    final translation = box.getTransformTo(null).getTranslation();
    final offset = Offset(dx, dy);
    final position = box.localToGlobal(offset);

    _state.setState(() {
      _map["width"] = box.size.width;
      // size.width;
      _map["height"] = box.size.height;
      _map["x"] = position.dx;
      _map["y"] = position.dy;
    });
  }

  Widget getSelectedWidget() {
    return _widget!;
  }

  @override
  _SelectionIndicatiorState createState() => _state;
}

class _SelectionIndicatiorState extends State<SelectionIndicatior> {
  @override
  Widget build(BuildContext context) {
    if (widget._isVisible) {
      return Positioned(
          left: double.parse(widget._map["x"].toString()),
          top: double.parse(widget._map["y"].toString()),
          child: Container(
            width: double.parse(widget._map["width"].toString()),
            height: double.parse(widget._map["height"].toString()),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Color(0x0ffDE0085),
                width: 2,
              ),
            ),
          ));
    } else {
      return Container();
    }
  }
}
