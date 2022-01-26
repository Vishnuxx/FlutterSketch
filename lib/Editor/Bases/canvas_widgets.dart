import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/fsketch_widget.dart';

// ignore: must_be_immutable
class CanvasWidget extends StatefulWidget {
  _CanvasWidgetState _state = _CanvasWidgetState();
  bool _isSelected = false;
  bool _wireframe = true;
  CanvasWidget? _parent;

  GlobalKey _gkey = GlobalKey();
  bool? isDraggableAndSelectable;
  late FlutterSketchWidget? widget;
  late void Function(TapDownDetails details)? onSelect;
  late void Function()? dragStart;
  late void Function(DragUpdateDetails details)? dragMove;
  late void Function(DraggableDetails details)? dragEnd;
  late void Function()? dragCompleted;

  CanvasWidget(this.widget, this.isDraggableAndSelectable,
      {Key? key,
      this.onSelect,
      this.dragStart,
      this.dragMove,
      this.dragEnd,
      this.dragCompleted})
      : super(key: key);

  //shows selection borders
  void select() {
    _state.setState(() {
      _isSelected = true;
    });
  }

  //hides selection borders
  void unselect() {
    _state.setState(() {
      _isSelected = false;
    });
  }

  //for showing outlines
  void showWireframe(bool value) {
    _state.setState(() {
      _wireframe = value;
    });
  }

  //sets this widget"s parent
  void setParent(CanvasWidget? cv) {
    _parent = cv;
  }

  //get its parent
  CanvasWidget? getParent() {
    return _parent;
  }

  //adds child to this widget
  void addChild(CanvasWidget child) {
    if (!widget!.isViewGroup!) {
      throw "This widget is not a viewgroup";
    }
    if (child.getParent() != null) {
      child.setParent(this);
      widget?.children!.add(child);
    } else {
      child.getParent()?.removeChild(child);
      widget?.children!.add(child);
    }
  }

  CanvasWidget? removeChild(CanvasWidget child) {
    if (!widget!.isViewGroup!) {
      throw "This widget is not a viewgroup";
    }
    widget?.children?.remove(child);
    child.setParent(null);
    return child;
  }

  @override
  State<CanvasWidget> createState() => _state;
}

class _CanvasWidgetState extends State<CanvasWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.isDraggableAndSelectable!) {
      return Draggable(
        key: widget._gkey,
        child: GestureDetector(
            child: Container(
              child: IgnorePointer(child: widget.widget!),
              foregroundDecoration:
                  BoxDecoration(border: _borderAndWireframe()),
            ),
            onTapDown: (TapDownDetails details) {
              widget.onSelect!(details);
            }),
        feedback: Container(),
        onDragStarted: () => widget.dragStart!(),
        onDragUpdate: widget.dragMove,
        onDragEnd: widget.dragEnd,
        onDragCompleted: widget.dragCompleted,
      );
    } else {
      return Container(child: widget.widget!);
    }
  }

  Border? _borderAndWireframe() {
    Border? border;
    if (widget._wireframe) {
      border = Border.all(color: Color(0xff000000), width: 1);
    }

    if (widget._isSelected) {
      border = Border.all(color: Color(0xffFF5C00), width: 3);
    }
    return border;
  }
}
