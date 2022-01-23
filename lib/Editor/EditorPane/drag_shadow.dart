import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/canvas_widgets.dart';

// ignore: must_be_immutable
class DragShadow extends StatefulWidget {
  final _DragShadowState _state = _DragShadowState();
  double? x;
  double? y;
  bool? visible = false;
  double? _width;
  double? _height;

  DragShadow({Key? key}) : super(key: key);

  void setPosition(DragUpdateDetails details) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      x = details.globalPosition.dy;
      y = details.globalPosition.dx;
    });
  }

  void setVisibility(bool visibility) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      visible = visibility;
    });
  }

  void setSizeOf(CanvasWidget widget) {
      RenderBox box = (widget.key as GlobalKey)
        .currentContext
        ?.findRenderObject() as RenderBox;

    final size = box.size;
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _width = size.width;
      _height = size.height;
    });
  }

  @override
  // ignore: no_logic_in_create_state
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
              decoration: const BoxDecoration(color: Colors.black26 ),
              clipBehavior: Clip.none),
        ),
      );
    } else {
      return Container();
    }
  }
}
