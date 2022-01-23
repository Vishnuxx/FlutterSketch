import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/canvas_widgets.dart';
import 'package:flutteruibuilder/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Bases/traversal_data.dart';
import 'package:flutteruibuilder/Controls/controls_pane.dart';
import 'package:flutteruibuilder/Editor/EditorPane/drag_shadow.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editor_canvas.dart';
import 'package:flutteruibuilder/Editor/EditorPane/widgets_pallette_list.dart';
import 'package:flutteruibuilder/Editor/drag_utils.dart';
import 'package:flutteruibuilder/Editor/EditorPane/selection_indicator.dart';
import 'package:flutteruibuilder/Bases/fsketch_widget.dart';
import 'package:flutteruibuilder/Bases/palette_widget.dart';
import 'package:flutteruibuilder/Bases/widget_controller.dart';
import 'package:flutteruibuilder/Widgets/fs_column.dart';
import 'package:flutteruibuilder/Widgets/fs_container.dart';

// ignore: must_be_immutable
class EditorPane extends StatefulWidget {
  final _state = _EditorPaneState();

  // ignore: constant_identifier_names
  static const double WIDGETS_PANEL_W = 150;
  // ignore: constant_identifier_names
  static const double WIDGETS_CONROLLER_PANEL_W = 250;
  // ignore: constant_identifier_names
  static double SCREEN_W = 300;
  // ignore: constant_identifier_names
  static double SCREEN_H = 550;

  CWHolder? widgets;
  SelectionIndicatior selectionIndicatior = SelectionIndicatior();

  CanvasWidget? root; //this is the root view of the droppable area

  WidgetsPalletteList pallettelist = WidgetsPalletteList();

  EditorPane({Key? key}) : super(key: key) {
    widgets = CWHolder([], _state);
  }

  void setState(Function callback) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      callback();
    });
  }

  @override
  // ignore: no_logic_in_create_state
  State<EditorPane> createState() => _state;
}

class _EditorPaneState extends State<EditorPane> {
  CanvasWidget? currentDraggingWidget;
  bool? isSelected;
  Offset? pointerLocation;
  int?
      prevIndex; //records the index of the item being dragged.used to restor position of the dragged element if dragging fails

  List<Widget> hiddenWidgets = [];
  List<WidgetController>? controllers = [];
  DragShadow shadow = DragShadow();

  ///late EditorCanvas canvas;
  TraversalData? dragData; //data of the dragging element
  TraversalData? dropData; //data of the drop listening element

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Row(children: [widgetPanel(), canvasPanel(), controlPane()]),
        widget.selectionIndicatior,
        SizedBox(
            width: 0,
            height: 0,
            child: Column(
              children: hiddenWidgets,
            )), //used to store widgets temporarily
        shadow
      ],
    ));
  }

/*
  ______________UI Components______________
*/

  Widget widgetPanel() {
    return Container(
      width: EditorPane.WIDGETS_PANEL_W,
      color: const Color(0xffEDECEC),
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          label("Widgets"),
          draggablePallette("TextWidget", "/pallette_icons/text.png"),
          draggablePallette("Container", "/pallette_icons/container.png"),
          draggablePallette("IconButton", "/pallette_icons/iconbutton.png"),
          draggablePallette("Imageview", "/pallette_icons/imageview.png"),
          draggablePallette("progress bar", "/pallette_icons/progress.png"),
          draggablePallette("seekbar", "/pallette_icons/seekbar.png"),
          draggablePallette("padding", "/pallette_icons/padding.png"),
          draggablePallette("sizedbox", "/pallette_icons/sizedbox.png"),
          label("Layouts"),
          draggablePallette("Row", "/pallette_icons/container.png"),
          draggablePallette("Column", "/pallette_icons/container.png"),
          draggablePallette("Container", "/pallette_icons/container.png"),
          draggablePallette("Wrap", "/pallette_icons/container.png"),
        ],
      ),
    );
  }

  Widget label(String name) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Text(
        name,
        style: const TextStyle(color: Colors.blue, fontSize: 15),
      ),
    );
  }

//canvas for showing the device
  Widget canvasPanel() {
    return Expanded(
      flex: 4,
      child: GestureDetector(
        onTap: () {
          setState(() {
            controllers = null;
          });

          widget.selectionIndicatior.setVisibility(false);
        },
        child: Container(
            color: const Color(0xffEDECEC), child: Center(child: editorPane())),
      ),
    );
  }

  //drop zone
  Widget editorPane() {
    return SizedBox(
      width: EditorPane.SCREEN_W,
      height: EditorPane.SCREEN_H,
      child: deviceScreen(),
    );
  }

//drop zone area
  Widget deviceScreen() {
    EditorCanvas fs = EditorCanvas();
    fs.children = widget.widgets;
    widget.root = CanvasWidget(
      fs,
      false,
      key: GlobalKey(),
    ); //key: GlobalKey(), children: widget.widgets?.getChildren());
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("New Flutter Project"),
        ),
        body: DragTarget(
          builder: (context, candidateData, rejectedData) {
            return widget.root!;
          },
        ),
      ),
    );
  }

//pane to show widget controls
  Widget controlPane() {
    return ControlsPane(
      padding: 5,
      width: EditorPane.WIDGETS_CONROLLER_PANEL_W,
      children: [
        TextField(
          controller:
              TextEditingController(text: EditorPane.SCREEN_W.toString()),
          onSubmitted: (value) {
            setState(() {
              EditorPane.SCREEN_W = double.parse(value);
            });
          },
        ),
        TextField(
          controller:
              TextEditingController(text: EditorPane.SCREEN_H.toString()),
          onSubmitted: (value) {
            setState(() {
              EditorPane.SCREEN_H = double.parse(value);
            });
          },
        ),
        WidgetController(
          "Text",
          controllers: controllers,
        )
      ],
    );
  }

//pallette widgets
  Widget draggablePallette(String label, String imgsrc) {
    return PaletteWidget(
      isDraggable: true,
      path: imgsrc,
      label: label,
      onDragStart: () {},
      onDragMove: (details) {
        onDragMove(details, true);
      },
      onDragCompleted: () {
        //   setState(() {
        try {
          currentDraggingWidget = canvasWidget(label); //sampleWidget(label);
          // widget.widgets?.add(currentDraggingWidget!);
          onDragEnd(true);
          // ignore: empty_catches
        } on Exception {}
        //  });
      },
    );
  }

  //this widget is generated everytime when user drags widget from pallette
  CanvasWidget canvasWidget(String type) {
    CanvasWidget? cWidget;

    cWidget = CanvasWidget(
      WidgetsPalletteList().generateWidget(type, GlobalKey()),
      true,
      key: GlobalKey(debugLabel: "vishnu"),
      //on element selected
      onSelect: (TapDownDetails details) {
        onSelect(details);
      },

      //on starting drag
      dragStart: () {
        print("started");
        onDragStart(false);
      },

      //on moving the drag
      dragMove: (details) {
        onDragMove(details, false);
      },

      //onDrop
      dragEnd: (details) {
        onDragEnd(false);
      },

      //onCompleted
      dragCompleted: () {
        // widget.selectionIndicatior.setVisibility(false);
      },
    );

    return cWidget;
  }

//

//

  //drag methods

  void onSelect(TapDownDetails details) {
    setState(() {
      DragUtils.findWidgetsAt(
          widget.widgets!, true, details.globalPosition, widget,
          //onSuccess
          (cv) {
        isSelected = true;
        dragData = cv;
        controllers = null;
        widget.selectionIndicatior.setVisibility(true);
        widget.selectionIndicatior.selectWidget(cv.canvasWidget);
        controllers = cv.canvasWidget?.widget?.controllers!;
        currentDraggingWidget = cv.canvasWidget;
        print(cv.parentCWHolder!.getChildren());
        cv.parentCWHolder!.show();
      },
          //onFail
          () {
        print("fail");
      });

      //print(dragData?.canvasWidget);
      // print()
    });
  }

  void onDragStart(bool isFromPallette) {
    if (isFromPallette) {
    } else {
      //is not from pallette
      if (isSelected!) {
        if (dragData != null) {
          shadow.setSizeOf(dragData!.canvasWidget!);
          dragData?.parentCWHolder?.remove(currentDraggingWidget!);
          setState(() {
            hiddenWidgets.add(currentDraggingWidget!);
          });
          controllers = null;
          widget.selectionIndicatior.selectWidget(dragData?.canvasWidget);
          widget.selectionIndicatior.setVisibility(false);
          print("DragStarted");
        }
      }
    }
  }

  void onDragMove(DragUpdateDetails details, bool isFromPallette) {
    if (isFromPallette) {
      print(details.globalPosition);
      DragUtils.findWidgetsAt(
          widget.widgets!, false, details.globalPosition, widget, (data) {
        //hasEntered
        dropData = data;
        widget.selectionIndicatior.selectWidget(data.canvasWidget);
        widget.selectionIndicatior.setVisibility(true);
        print("entered");
      }, () {
        //hasNotEntered
        print("not ENtered");
        dropData?.canvasWidget = null;
        widget.selectionIndicatior.setVisibility(false);
      });
    } else {
      //is not from pallette
      if (isSelected!) {
        if (dragData != null) {
          shadow.setVisibility(true);
          shadow.setPosition(details);
          print(details.globalPosition);
          DragUtils.findWidgetsAt(
              widget.widgets!, false, details.globalPosition, widget, (data) {
            //hasEntered
            dropData = data;
            widget.selectionIndicatior.selectWidget(data.canvasWidget);
            widget.selectionIndicatior.setVisibility(true);
            print("entered");
          }, () {
            //hasNotEntered
            print("not ENtered");
            dropData?.canvasWidget = null;
            widget.selectionIndicatior.setVisibility(false);
          });
        }
      }
    }
  }

  void onDragEnd(bool isFromPallette) {
    if (isFromPallette) {
      if (dropData?.canvasWidget != null) {
        dropData?.parentCWHolder?.add(currentDraggingWidget!);
      }
    } else {
      //is not from pallette
      if (isSelected!) {
        shadow.setVisibility(false);
        setState(() {
          if (dropData?.canvasWidget != null) {
            isSelected = false;
            //if target is multichilded
            FlutterSketchWidget? fs = dropData?.canvasWidget?.widget;
            if (fs != null && fs.isViewGroup!) {
              hiddenWidgets.remove(currentDraggingWidget!);
              fs.children!.add(currentDraggingWidget!);
            } else {
              // hiddenWidgets.remove(currentDraggingWidget!);
              // fs.children!.add(currentDraggingWidget!);
            }
          } else {
            //if target is root
            print("hjks");
            hiddenWidgets.remove(currentDraggingWidget!);
            dragData?.parentCWHolder?.getChildren().add(currentDraggingWidget!);
            //widget.widgets?.add(currentDraggingWidget!);
          }
        });
      }
    }
  }
}
