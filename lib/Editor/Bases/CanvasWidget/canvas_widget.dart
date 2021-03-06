import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widget_functions.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/cw_drag_data.dart';
import 'package:flutteruibuilder/Editor/Bases/FSWidget/fsketch_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editorpane.dart';

// ignore: must_be_immutable
class CanvasWidget extends StatefulWidget implements CanvasWidgetFunctions {
  final _CanvasWidgetState _state = _CanvasWidgetState();
  bool _isSelected = false;
  bool _wireframe = true;
  bool _isVisible = true;
  late final bool isViewGroup;
  late final bool isMultiChilded;

  EditorPane editor;

  CanvasWidget? _parent;

  @override
  String id;

  final GlobalKey _gkey = GlobalKey();
  bool? isDraggableAndSelectable;
  late FlutterSketchWidget? fsWidget;
  void Function(TapDownDetails details)? onSelect;
  void Function()? dragStart;
  void Function(DragUpdateDetails details)? dragMove;
  void Function(DraggableDetails details)? dragEnd;
  void Function()? dragCompleted;

  CanvasWidget(
    this.editor,
    @required this.fsWidget, {
    Key? key,
    this.id = "",
    this.isDraggableAndSelectable = false,
    this.onSelect,
    this.dragStart,
    this.dragMove,
    this.dragEnd,
    this.dragCompleted,
  }) : super(key: key) {
    isViewGroup = fsWidget!.isViewGroup!;
    isMultiChilded = fsWidget!.isMultiChilded!;
  }

  @override
  //shows selection borders
  void select(bool isSelected) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _isSelected = isSelected;
    });
  }

  @override
  void update() {
   
  }

  @override
  //for showing outlines
  void showWireframe(bool value) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _wireframe = value;
    });
  }

  @override
  void setVisible(bool visibility) {
    _state.setState(() {
      _isVisible = visibility;
    });
  }

  @override
  bool isVisible() {
    return _isVisible;
  }

  @override
  //sets this widget"s parent
  void setParent(CanvasWidget? cv) {
    _parent = cv;
  }

  @override
  //get its parent
  CanvasWidget? getParent() {
    return _parent;
  }

  @override
  //returns its corresponding widget
  FlutterSketchWidget getFSWidget() {
    return fsWidget!;
  }

  @override
  List<CanvasWidget> getChildren() {
    return fsWidget!.children!.getChildren();
  }

  @override
  //adds child to this widget if it is a viewgroup
  void addChild(CanvasWidget child) {
    if (!fsWidget!.isViewGroup!) {
      throw "This widget is not a viewgroup";
    }
    if (child.getParent() == null) {
      child.setParent(this);
      fsWidget!.children!.add(child);
    } else {
      child.getParent()!.removeChild(child);
      fsWidget!.children!.add(child);
      child.setParent(this);
    }
  }

  @override
  //removes child from this widget if it is a viewgroup
  CanvasWidget? removeChild(CanvasWidget child) {
    if (!fsWidget!.isViewGroup!) {
      throw "This widget is not a viewgroup";
    }
    child.setParent(null);
    fsWidget?.children?.remove(child);
    return child;
  }

  @override
  //inserts child at specific index if this widget is a viewgroup
  void insertChild(int index, CanvasWidget child) {
    if (!fsWidget!.isViewGroup!) {
      throw "This widget is not a viewgroup";
    }
    if (child.getParent() == null) {
      child.setParent(this);
      fsWidget?.children!.insert(index, child);
    } else {
      child.getParent()!.removeChild(child);
      fsWidget?.children!.add(child);
    }
  }

  @override
  void setProperty(String property, value) {
    fsWidget?.set(property, value);
  }

  @override
  CWDragData? pickUp(CanvasWidget canvas) {
    CWDragData data = CWDragData();
    data.setOldParent(_parent, this);
    return data;
  }

  @override
  void dropTo(CWDragData data, CanvasWidget? dropzone) {}

  //DRAG METHODS
  void pickAndStoreTo(CWHolder temporaryArea) {
    _parent?.removeChild(this);
    temporaryArea.add(this);
  }

  @override
  // ignore: no_logic_in_create_state
  State<CanvasWidget> createState() => _state;
}

//_________________STATE______________________

//
class _CanvasWidgetState extends State<CanvasWidget> {
  FlutterSketchWidget? view;

  @override
  void initState() {
    view = widget.fsWidget;
    super.initState();
  }

  //function to show/hide wireframe
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

  //BUILD
  @override
  Widget build(BuildContext context) {
    if (widget.isDraggableAndSelectable!) {
      return Visibility(
        visible: widget._isVisible,
        maintainState: true,
        child: Draggable(
          key: widget._gkey,
          child: GestureDetector(
            child: Container(
              child: IgnorePointer(child: widget.fsWidget!),
              foregroundDecoration:
                  BoxDecoration(border: _borderAndWireframe()),
            ),
            onTapDown: (details) {
              widget.onSelect!(details);
            },
          ),
          feedback: Container(
            width: 100,
            height: 30,
            child: Center(
                child: Text(
              widget.fsWidget.runtimeType.toString(),
              style: TextStyle(fontSize: 10),
            )),
            decoration: BoxDecoration(
                color: Colors.white60,
                border: Border.all(color: Colors.black26)),
          ),
          //start
          onDragStarted: () {
            widget.dragStart!();
          },
          //update
          onDragUpdate: (details) {
            widget.dragMove!(details);
          },
          //end
          onDragEnd: (drggableDetails) {
            widget.dragEnd!(drggableDetails);
          },
          //co,pleted
          onDragCompleted: () {
            widget.dragCompleted!();
          },
        ),
      );
    } else {
      return Container(child: widget.fsWidget!);
    }
  }
}
