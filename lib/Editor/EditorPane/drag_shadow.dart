import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/canvas_widgets.dart';

class DragShadow extends StatefulWidget {
  _DragShadowState _state = _DragShadowState();
  double? x;
  double? y;
  bool? visible = false;
  double? _width;
  double? _height;

  DragShadow({Key? key}) : super(key: key);

  void setPosition(DragUpdateDetails details) {
    _state.setState(() {
      x = details.globalPosition.dy;
      y = details.globalPosition.dx;
    });
  }

  void setVisibility(bool visibility) {
    _state.setState(() {
      visible = visibility;
    });
  }

  void setSizeOf(CanvasWidget widget) {
      RenderBox box = (widget.key as GlobalKey)
        .currentContext
        ?.findRenderObject() as RenderBox;

    final size = box.size;
    _state.setState(() {
      _width = size.width;
      _height = size.height;
    });
  }

  @override
  _DragShadowState createState() => _state;
}

class _DragShadowState extends State<DragShadow> {
  @override
  Widget build(BuildContext context) {
    if (widget.visible!) {
      return Positioned(
        top: widget.x,
        left: widget.y,
        child: IgnorePointer(
          child: Container(
              key: GlobalKey(),
              width: widget._width,
              height: widget._height,
              decoration: BoxDecoration(color: Colors.black26 ),
              clipBehavior: Clip.none),
        ),
      );
    } else {
      return Container();
    }
  }
}
