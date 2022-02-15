import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widget_drag_methods.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widget_functions.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/cw_drag_data.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/fsketch_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/Bases/drag_utils.dart';
import 'package:flutteruibuilder/Editor/Bases/traversal_data.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editorpane.dart';

// ignore: must_be_immutable
class CanvasWidget extends StatefulWidget
    implements CanvasWidgetFunctions, CWDragMethods {
  final _CanvasWidgetState _state = _CanvasWidgetState();
  bool _isSelected = false;
  bool _wireframe = true;
  late final bool isViewGroup;
  late final bool isMultiChilded;

  EditorPane editor;

  CanvasWidget? _parent;

  @override
  String id;

  final GlobalKey _gkey = GlobalKey();
  bool? isDraggableAndSelectable;
  late FlutterSketchWidget? fsWidget;
  late void Function(TapDownDetails details)? onSelect;
  late void Function()? dragStart;
  late void Function(DragUpdateDetails details)? dragMove;
  late void Function(DraggableDetails details)? dragEnd;
  late void Function()? dragCompleted;

  CanvasWidget(
      this.editor, @required this.fsWidget, this.isDraggableAndSelectable,
      {Key? key,
      this.id = "",
      this.onSelect,
      this.dragStart,
      this.dragMove,
      this.dragEnd,
      this.dragCompleted})
      : super(key: key) {
    this.isViewGroup = this.fsWidget!.isViewGroup!;
    this.isMultiChilded = this.fsWidget!.isMultiChilded!;
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
  //for showing outlines
  void showWireframe(bool value) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _wireframe = value;
    });
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
  //adds child to this widget if it is a viewgroup
  void addChild(CanvasWidget child) {
    if (!fsWidget!.isViewGroup!) {
      throw "This widget is not a viewgroup";
    }
    if (child.getParent() == null) {
      child.setParent(this);
      fsWidget?.children!.add(child);
    } else {
      child.getParent()!.removeChild(child);
      fsWidget?.children!.add(child);
    }
  }

  @override
  //removes child from this widget if it is a viewgroup
  CanvasWidget? removeChild(CanvasWidget child) {
    if (!fsWidget!.isViewGroup!) {
      throw "This widget is not a viewgroup";
    }
    fsWidget?.children?.remove(child);
    child.setParent(null);
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
  void dropTo(CWDragData data, Widget? dropzone) {
    if (data.oldParent != null) {
      if (data.oldParent.runtimeType.toString() == CanvasWidget) {
        (data.oldParent as CanvasWidget).fsWidget!.children!.remove(this);
      } else {
        (data.oldParent as EditorPane).widgets!.remove(this);
      }
    }
    (dropzone as CanvasWidget).addChild(this);
  }

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
      return Draggable(
        key: widget._gkey,
        child: GestureDetector(
            child: Container(
              child: IgnorePointer(child: widget.fsWidget!),
              foregroundDecoration:
                  BoxDecoration(border: _borderAndWireframe()),
            ),
            //on Tap
            onTapDown: (TapDownDetails details) {
              widget.onSelect!(details);
            }),
        feedback: Container(),
        //start
        onDragStarted: () {
          view?.onDragStart();
          widget.dragStart!();
        },
        //update
        onDragUpdate: (details) {
          view?.onDragMove();
          widget.dragMove!(details);
        },
        //end
        onDragEnd: (drggableDetails) {
          widget.dragEnd!(drggableDetails);
        },
        //co,pleted
        onDragCompleted: widget.dragCompleted,
      );
    } else {
      return Container(child: widget.fsWidget!);
    }
  }
}
