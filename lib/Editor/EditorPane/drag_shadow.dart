import 'package:flutter/material.dart';

class DragShadow extends StatefulWidget {
  _DragShadowState _state = _DragShadowState();
  double? x;
  double? y;
  bool? visible = false;

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
              width: 100,
              height: 40,
              decoration: BoxDecoration(color: Colors.black26 ),
              clipBehavior: Clip.none),
        ),
      );
    } else {
      return Container();
    }
  }
}
