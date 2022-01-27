import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widgets.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/Bases/traversal_data.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editor_pane_state.dart';
import 'package:flutteruibuilder/Editor/UIPanels/controls_pane.dart';
import 'package:flutteruibuilder/Editor/EditorPane/drag_shadow.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editor_canvas.dart';
import 'package:flutteruibuilder/Editor/EditorPane/widgets_pallette_list.dart';
import 'package:flutteruibuilder/Editor/Bases/drag_utils.dart';
import 'package:flutteruibuilder/Editor/EditorPane/selection_indicator.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/fsketch_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/palette_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/widget_controller.dart';
import 'package:flutteruibuilder/Editor/UIPanels/element_treegraph.dart';
import 'package:flutteruibuilder/Editor/UIPanels/left_panel.dart';
import 'package:flutteruibuilder/Editor/UIPanels/widgets_panel.dart';
import 'package:flutteruibuilder/Widgets/fs_container.dart';

// ignore: must_be_immutable
class EditorPane extends StatefulWidget {
  final _state = _EditorPaneState();

  // ignore: constant_identifier_names
  static const double WIDGETS_PANEL_W = 250;
  // ignore: constant_identifier_names
  static const double WIDGETS_CONROLLER_PANEL_W = 300;
  // ignore: constant_identifier_names
  static double SCREEN_W = 300;
  // ignore: constant_identifier_names
  static double SCREEN_H = 550;

  CWHolder? widgets;

  CanvasWidget? root; //this is the root view of the droppable area

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
  EditorPaneState ep = EditorPaneState();
  List<CanvasWidget> collections = [];
  SelectionIndicatior selectionIndicatior = SelectionIndicatior();
  CanvasWidget? currentDroppableWidget;

  CanvasWidget? currentDraggingWidget;

  bool? isSelected;
  Offset? pointerLocation;

  List<Widget>? hiddenWidgets = [];
  List<WidgetController>? controllers = [];
  DragShadow shadow = DragShadow();

  ///late EditorCanvas canvas;
  TraversalData? dragData; //data of the dragging element
  TraversalData? dropData; //data of the drop listening element

  ElementTreeGraph? tree;

  @override
  void initState() {
    super.initState();
    hiddenWidgets = ep.hiddenWidgets;
    tree = ElementTreeGraph(
      width: 200,
      onWidgetSelected: (wid) {
        selectWidget(wid);
        //selectionIndicatior.selectWidget(wid);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "FlutterSketch",
            style: TextStyle(
                color: Color(0xff70839E), fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Color(0xffF2F3F4),
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
              selectionIndicatior,

              SizedBox(
                  width: 0,
                  height: 0,
                  child: Column(
                    children: hiddenWidgets!,
                  )), //used to store widgets temporarily
              shadow
            ],
          ),
        ));
  }

/*
  ______________UI Components______________
*/

  ElementTreeGraph graph() {
    return tree!;
  }

//canvas for showing the device
  Widget canvasPanel() {
    return Expanded(
      child: Container(
        // width: double.infinity,
        // height: double.infinity,
        // color: Colors.deepPurple,
        child: GestureDetector(
          onTap: () {
            setState(() {
              controllers = null;
            });
            selectWidget(null);

            currentDraggingWidget = null;
          },
          child: Center(child: editingDevice()),
        ),
      ),
    );
  }

  //drop zone
  Widget editingDevice() {
    EditorCanvas fs = EditorCanvas();
    fs.children = widget.widgets;
    widget.root = CanvasWidget(
      fs,
      false,
      key: GlobalKey(),
    );
    return Container(
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
        ...?controllers,
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
              NeverScrollableScrollPhysics(), // to disable GridView's scrolling
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
              NeverScrollableScrollPhysics(), // to disable GridView's scrolling
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
        currentDraggingWidget = null;
      },
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

  //used to select widgets
  void selectWidget(CanvasWidget? cwid) {
    for (int i = 0; i < collections.length; ++i) {
      if (cwid != null && cwid == widget.widgets?.getChildren()[i]) {
        cwid.select();
      } else {
        widget.widgets?.getChildren()[i].unselect();
      }
    }
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
        isSelected = true;
        dragData = cv;
        controllers = null;

        currentDraggingWidget = cv.canvasWidget;

        // selectionIndicatior.setVisibility(true);
        // selectionIndicatior.selectWidget(cv.canvasWidget,
        //     color: Color(0xffFF5C00));
        selectWidget(currentDraggingWidget);
        controllers = currentDraggingWidget?.widget?.controllers;
      },
          //onFail
          () {});
    });
  }

  void onDragStart(bool isFromPallette) {
    if (isFromPallette) {
    } else {
      //is not from pallette
      if (isSelected!) {
        if (dragData != null) {
          currentDraggingWidget = dragData?.canvasWidget;
          shadow.setSizeOf(dragData!.canvasWidget!);

          //removes the widget from its parent
          dragData?.parentCWHolder?.remove(currentDraggingWidget!);
          //stores the wid=get inside hiddden widgets
          setState(() {
            hiddenWidgets?.add(currentDraggingWidget!);
          });
          controllers = null;

          // selectWidget(currentDraggingWidget);
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
        // currentDroppableWidget?.unselect();
        dropData = data;
        currentDroppableWidget = data.canvasWidget;

        //selectWidget(data.canvasWidget);
      }, () {});
    } else {
      //is not from pallette
      if (isSelected!) {
        if (dragData != null) {
          shadow.setVisibility(true);
          shadow.setPosition(details);
          DragUtils.findWidgetsAt(
              widget.widgets!, false, details.globalPosition, widget, (data) {
            //hasEntered

            dropData = data;
            selectWidget(dropData?.canvasWidget);
          }, () {
            //hasNotEntered
          });
        }
      }
    }
  }

  void onDragEnd(bool isFromPallette) {
    if (isFromPallette) {
      if (dropData?.canvasWidget != null) {
        collections.add(currentDraggingWidget!);
        dropData?.childCWHolder?.add(currentDraggingWidget!);
        //selectWidget(currentDraggingWidget);
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
              hiddenWidgets?.remove(currentDraggingWidget!);
              dropData?.childCWHolder?.add(currentDraggingWidget!);
            } else {
              // hiddenWidgets.remove(currentDraggingWidget!);
              // fs.children!.add(currentDraggingWidget!);
            }
          } else {
            //if target is root

            hiddenWidgets?.remove(currentDraggingWidget!);
            dragData?.parentCWHolder?.getChildren().add(currentDraggingWidget!);
            //widget.widgets?.add(currentDraggingWidget!);
          }
        });
      }
    }
    selectionIndicatior.selectWidget(null);
    tree?.refresh(widget.widgets?.getChildren());
  }
}
