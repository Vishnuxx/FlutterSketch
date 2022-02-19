import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widgets.dart';
import 'package:flutteruibuilder/Editor/Bases/drag_utils.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editorpane.dart';

class SelectionLabel extends StatefulWidget {
  final _state = _SelectionLabelState();
  double _x = 0;
  double _y = 0;
  String label = "";
  SelectionLabel({Key? key}) : super(key: key);

  setLabelOf(CanvasWidget? canvasWidget) {
    if (canvasWidget != null) {
      RenderBox box2 = (canvasWidget.key as GlobalKey)
          .currentContext
          ?.findRenderObject() as RenderBox;
      final pos = DragUtils.toRelativeOffset(box2.localToGlobal(Offset.zero));

      _state.setState(() {
        _x = pos.dx + 1;
        _y = pos.dy - 66;
        label = canvasWidget.fsWidget.runtimeType.toString();
      });
      return;
    }
    _state.setState(() {
      _x = 0;
      _y = 0;
      label = "";
    });
  }

  @override
  State<SelectionLabel> createState() => _state;
}

class _SelectionLabelState extends State<SelectionLabel> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget._x,
      top: widget._y,
      child: Container(
        color: Colors.deepOrange,
        child: Wrap(
          children: [
            Text(
              widget.label,
              style: TextStyle(fontSize: 10, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
