import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widgets.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editor_pane_data.dart';
import 'package:flutteruibuilder/Editor/UIPanels/controls_pane.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editor_canvas.dart';
import 'package:flutteruibuilder/Widgets/widgets_pallette_list.dart';
import 'package:flutteruibuilder/Editor/Bases/drag_utils.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/fsketch_widget.dart';
import 'package:flutteruibuilder/Editor/EditorPane/palette_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/widget_controller.dart';
import 'package:flutteruibuilder/Editor/UIPanels/element_treegraph.dart';
import 'package:flutteruibuilder/Editor/UIPanels/widgets_panel.dart';

// ignore: must_be_immutable
class EditorPane extends StatefulWidget {
  final _state = _EditorPaneState();

  // ignore: constant_identifier_names
  static const double WIDGETS_PANEL_W = 250;
  // ignore: constant_identifier_names
  static const double WIDGETS_CONROLLER_PANEL_W = 300;
  // ignore: constant_identifier_names, non_constant_identifier_names
  static double SCREEN_W = 300;
  // ignore: constant_identifier_names, non_constant_identifier_names
  static double SCREEN_H = 550;

  CWHolder? widgets;

  int widgetId = 0;

  CanvasWidget? root; //this is the root view of the droppable area

  late EditorPaneData data;

  EditorPane({Key? key}) : super(key: key) {
    widgets = CWHolder([], _state);
    data = EditorPaneData();
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
  //List<CanvasWidget> collections = [];

  ///late EditorCanvas canvas;

  @override
  void initState() {
    super.initState();
    widget.data.hiddenWidgets = CWHolder([], this);
    widget.data.tree = ElementTreeGraph(
      width: 200,
      onWidgetSelected: (wid) {
        //selectionIndicatior.selectWidget(wid);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            "FlutterSketch",
            style: TextStyle(
                color: Color(0xff70839E), fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: const Color(0xffF2F3F4),
        ),
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Row(children: [
                widgetPanel(),
                graph(),
                canvasPanel(),
                controlPane()
              ]),
              widget.data.selectionIndicatior,

              SizedBox(
                  width: 0,
                  height: 0,
                  child: Column(
                    children: widget.data.hiddenWidgets!.getChildren(),
                  )), //used to store widgets temporarily
              widget.data.shadow
            ],
          ),
        ));
  }

/*
  ______________UI Components______________
*/

  ElementTreeGraph graph() {
    return widget.data.tree!;
  }

//canvas for showing the device
  Widget canvasPanel() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.data.controllers = null;
          });

          widget.data.currentDraggingWidget = null;
        },
        child: Center(child: editingDevice()),
      ),
    );
  }

  //drop zone
  Widget editingDevice() {
    EditorCanvas fs = EditorCanvas();
    fs.children = widget.widgets;
    widget.root = CanvasWidget(
      widget,
      fs,
      false,
      key: GlobalKey(),
    );
    return SizedBox(
        width: EditorPane.SCREEN_W,
        height: EditorPane.SCREEN_H,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
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
        ));
  }

//pane to show widget controls
  Widget controlPane() {
    return ControlsPane(
      padding: 5,
      width: EditorPane.WIDGETS_CONROLLER_PANEL_W,
      children: [
        WidgetController(
          "Device Size",
          controllers: [
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
          ],
        ),
        ...?widget.data.controllers,
      ],
    );
  }

  Widget widgetPanel() {
    return WidgetPanel(
      EditorPane.WIDGETS_PANEL_W,
      children: [
        label("Widgets"),
        GridView.count(
          crossAxisCount: 3,
          physics:
              const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
          shrinkWrap: true,
          children: [
            draggablePallette("TextWidget", "/pallette_icons/text.png"),
            draggablePallette("Container", "/pallette_icons/container.png"),
            draggablePallette("IconButton", "/pallette_icons/iconbutton.png"),
            draggablePallette("Imageview", "/pallette_icons/imageview.png"),
            draggablePallette("progress bar", "/pallette_icons/progress.png"),
            draggablePallette("seekbar", "/pallette_icons/seekbar.png"),
            draggablePallette("padding", "/pallette_icons/padding.png"),
            draggablePallette("sizedbox", "/pallette_icons/sizedbox.png"),
          ],
        ),
        label("Layouts"),
        GridView.count(
          crossAxisCount: 3,
          physics:
              const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
          shrinkWrap: true,
          children: [
            draggablePallette("Row", "/pallette_icons/container.png"),
            draggablePallette("Column", "/pallette_icons/container.png"),
            draggablePallette("Container", "/pallette_icons/container.png"),
            draggablePallette("Wrap", "/pallette_icons/container.png"),
            draggablePallette("Stack", "/pallette_icons/container.png"),
          ],
        ),
      ],
    );
  }

  Widget label(String name) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Text(
        name,
        style: const TextStyle(color: Colors.blue, fontSize: 14),
      ),
    );
  }

//pallette widgets
  Widget draggablePallette(String label, String imgsrc) {
    return PaletteWidget(
      isDraggable: true,
      path: imgsrc,
      label: label,
      onDragStart: () {
        // previousSelectedWidget?.unselect();
        widget.data.currentDraggingWidget = null;
      },
      onDragMove: (details) {
        onDragMove(details, true);
      },
      onDragCompleted: () {
        //   setState(() {
        try {
          widget.data.currentDraggingWidget =
              canvasWidget(label); //sampleWidget(label);
          // widget.widgets?.add(widget.data.currentDraggingWidget!);
          onDragEnd(true);
          // ignore: empty_catches
        } on Exception {}
        //  });
      },
    );
  }

  //used to select widgets
  // void selectWidget(CanvasWidget? cwid) {
  //   for (int i = 0; i < collections.length; ++i) {
  //     if (cwid != null && cwid == widget.widgets?.getChildren()[i]) {
  //       cwid.select();
  //     } else {
  //       widget.widgets?.getChildren()[i].unselect();
  //     }
  //   }
  // }

  //this widget is generated everytime when user drags widget from pallette
  CanvasWidget canvasWidget(String type) {
    CanvasWidget? cWidget;
    String newId = type + (widget.widgetId++).toString();

    cWidget = CanvasWidget(
      widget,
      WidgetsPalletteList().generateWidget(type , GlobalKey()),
      true,
      id: newId,
      key: GlobalKey(debugLabel: "vishnu"),
      //on element selected
      onSelect: (TapDownDetails details) {
        onSelect(details);
      },

      //on starting drag
      dragStart: () {
        onDragStart(false);
      },

      //on moving the drag
      dragMove: (details) {
        // print(details);
        onDragMove(details, false);
      },

      //onDrop
      dragEnd: (details) {
        onDragEnd(false);
      },

      //onCompleted
      dragCompleted: () {
        // selectionIndicatior.setVisibility(false);
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
        widget.data.isSelected = true;
        widget.data.dragData = cv;
        widget.data.controllers = null;

        widget.data.currentDraggingWidget = cv.canvasWidget;
        widget.data.controllers =
            widget.data.currentDraggingWidget?.widget?.controllers;
      },
          //onFail
          () {});
    });
  }

  void onDragStart(bool isFromPallette) {
    if (isFromPallette) {
    } else {
      //is not from pallette
      if (widget.data.isSelected!) {
        if (widget.data.dragData != null) {
          widget.data.currentDraggingWidget =
              widget.data.dragData?.canvasWidget;
          widget.data.shadow.setSizeOf(widget.data.dragData!.canvasWidget!);
          //picks this object for dragging
          widget.data.currentDraggingWidget
              ?.pickAndStoreTo(widget.data.hiddenWidgets!);
          widget.data.controllers = null;
        }
      }
    }
  }

  void onDragMove(DragUpdateDetails details, bool isFromPallette) {
    if (isFromPallette) {
      DragUtils.findWidgetsAt(
          widget.widgets!, false, details.globalPosition, widget,
          //hasEntered
          (data) {
        // widget.data.currentDroppableWidget?.unselect();
        widget.data.dropData = data;
        widget.data.currentDroppableWidget = data.canvasWidget;
      }, () {});
    } else {
      //is not from pallette
      if (widget.data.isSelected!) {
        if (widget.data.dragData != null) {
          widget.data.shadow.setVisibility(true);
          widget.data.shadow.setPosition(details);
          DragUtils.findWidgetsAt(
              widget.widgets!, false, details.globalPosition, widget, (data) {
            //hasEntered

            widget.data.dropData = data;
          }, () {
            //hasNotEntered
          });
        }
      }
    }
  }

  void onDragEnd(bool isFromPallette) {
    if (isFromPallette) {
      if (widget.data.dropData?.canvasWidget != null) {
        widget.data.collections.add(widget.data.currentDraggingWidget!);
        //widget.data.dropData?.canvasWidget?.addChild(widget.data.currentDraggingWidget!);
        widget.data.currentDraggingWidget
            ?.dropTo(widget.data.dropData!.canvasWidget!);
      }
    } else {
      //is not from pallette
      if (widget.data.isSelected!) {
        widget.data.shadow.setVisibility(false);

        if (widget.data.dropData?.canvasWidget != null) {
          widget.data.isSelected = false;
          //if target is multichilded
          FlutterSketchWidget? fs = widget.data.dropData?.canvasWidget?.widget;
          if (fs != null && fs.isViewGroup!) {
            widget.data.hiddenWidgets
                ?.remove(widget.data.currentDraggingWidget!);

            widget.data.currentDraggingWidget
                ?.dropTo(widget.data.dropData!.canvasWidget!);
          } else {}
        }
        // else {
        //   //if target is root
        //   print("ksldksjdlkslfdkf");
        //   widget.data.hiddenWidgets?.remove(widget.data.currentDraggingWidget!);
        //   widget.data.dragData?.canvasWidget
        //       ?.getParent()
        //       ?.addChild(widget.data.currentDraggingWidget!);
        //   //widget.widgets?.add(widget.data.currentDraggingWidget!);
        // }

      }
    }
    widget.data.selectionIndicatior.selectWidget(null);
    widget.data.tree?.refresh(widget.widgets?.getChildren());
  }
}
