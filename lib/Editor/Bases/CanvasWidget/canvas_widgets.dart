import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widget_functions.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/fsketch_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editorpane.dart';

// ignore: must_be_immutable
class CanvasWidget extends StatefulWidget implements CanvasWidgetFunctions {
  final _CanvasWidgetState _state = _CanvasWidgetState();
  bool _isSelected = false;
  bool _wireframe = true;

  EditorPane editor;

  CanvasWidget? _parent;

  @override
  String id;

  final GlobalKey _gkey = GlobalKey();
  bool? isDraggableAndSelectable;
  late FlutterSketchWidget? widget;
  late void Function(TapDownDetails details)? onSelect;
  late void Function()? dragStart;
  late void Function(DragUpdateDetails details)? dragMove;
  late void Function(DraggableDetails details)? dragEnd;
  late void Function()? dragCompleted;

  CanvasWidget(this.editor, this.widget, this.isDraggableAndSelectable,
      {Key? key,
      this.id = "",
      this.onSelect,
      this.dragStart,
      this.dragMove,
      this.dragEnd,
      this.dragCompleted})
      : super(key: key);

  //shows selection borders
  @override
  void select() {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _isSelected = true;
    });
  }

  //hides selection borders
  @override
  void unselect() {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _isSelected = false;
    });
  }

  //for showing outlines
  @override
  void showWireframe(bool value) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _wireframe = value;
    });
  }

  //sets this widget"s parent
  @override
  void setParent(CanvasWidget? cv) {
    _parent = cv;
  }

  //get its parent
  @override
  CanvasWidget? getParent() {
    return _parent;
  }

  //adds child to this widget
  @override
  void addChild(CanvasWidget child) {
    if (!widget!.isViewGroup!) {
      throw "This widget is not a viewgroup";
    }
    if (child.getParent() == null) {
      child.setParent(this);
      widget?.children!.add(child);
    } else {
      child.getParent()!.removeChild(child);
      widget?.children!.add(child);
    }
  }

  @override
  CanvasWidget? removeChild(CanvasWidget child) {
    if (!widget!.isViewGroup!) {
      throw "This widget is not a viewgroup";
    }
    widget?.children?.remove(child);
    child.setParent(null);
    return child;
  }

  //DRAG METHODS
  void pickAndStoreTo(CWHolder temporaryArea) {
    _parent?.removeChild(this);
    temporaryArea.add(this);
  }

  void dropTo(CanvasWidget dropRegion) {
    dropRegion.addChild(this);
  }

  @override
  void insertChild(int index, CanvasWidget child) {
    if (!widget!.isViewGroup!) {
      throw "This widget is not a viewgroup";
    }
    if (child.getParent() == null) {
      child.setParent(this);
      widget?.children!.insert(index, child);
    } else {
      child.getParent()!.removeChild(child);
      widget?.children!.add(child);
    }
  }

  @override
  void setProperty(String property, value) {
    widget?.set(property, value);
  }

  @override
  // ignore: no_logic_in_create_state
  State<CanvasWidget> createState() => _state;
}

class _CanvasWidgetState extends State<CanvasWidget> {
  FlutterSketchWidget? view;
  @override
  void initState() {
    view = widget.widget;
    super.initState();
  }

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
        onDragStarted: () {
          view?.onDragStart();
          widget.dragStart!();
        },
        onDragUpdate: (details) {
          view?.onDragMove();
          widget.dragMove!(details);
        },
        onDragEnd: (drggableDetails) {
          view?.onDrop();
          widget.dragEnd!(drggableDetails);
        },
        onDragCompleted: widget.dragCompleted,
      );
    } else {
      return Container(child: widget.widget!);
    }
  }

  Border? _borderAndWireframe() {
    Border? border;

    if (widget._wireframe) {
      border = Border.all(color: const Color(0xff000000), width: 1);
    }

    if (widget._isSelected) {
      border = Border.all(color: const Color(0xffFF5C00), width: 3);
    }

    return border;
  }
}
