import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widgets.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/cw_drag_data.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';

import 'package:flutteruibuilder/Editor/EditorPane/editor_canvas.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editor_pane_data.dart';
import 'package:flutteruibuilder/Editor/UIPanels/controls_pane.dart';

import 'package:flutteruibuilder/Editor/EditorPane/widgets_pallette_list.dart';
import 'package:flutteruibuilder/Editor/Bases/drag_utils.dart';
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

  late CWDragData dropdata;

  EditorPane({Key? key}) : super(key: key) {
    widgets = CWHolder([], _state);
    data = EditorPaneData();
    dropdata = CWDragData();
  }

  @override
  // ignore: no_logic_in_create_state
  State<EditorPane> createState() => _state;
}

class _EditorPaneState extends State<EditorPane> {
  //List<CanvasWidget> collections = [];
  ///late EditorCanvas canvas;

  late EditorPane thispane; //this editorpane

  @override
  void initState() {
    super.initState();
    thispane = widget;

    thispane.data.hiddenWidgets = CWHolder([], this);
    thispane.data.tree = ElementTreeGraph(
      width: 200,
      onWidgetSelected: (wid) {
        wid.select(true);
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
          elevation: 1,
          backgroundColor: const Color(0xffffffff),
        ),
        body: Stack(
          children: [
            Row(children: [
              widgetPanel(thispane),
              graph(thispane),
              canvasPanel(),
              controlPane(thispane)
            ]),

            thispane.data.selectionIndicatior,

            SizedBox(
                width: 0,
                height: 0,
                child: Column(
                  children: thispane.data.hiddenWidgets!.getChildren(),
                )), //used to store widgets temporarily
            thispane.data.shadow
          ],
        ));
  }

  //Tree Graph
  ElementTreeGraph graph(EditorPane editor) {
    return thispane.data.tree!;
  }

  //canvas for showing the device
  Widget canvasPanel() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            thispane.data.controllers = null;
          });

          thispane.data.currentDraggingWidget = null;
        },
        child: Container(
            child: Center(child: editingDevice()),
            color: const Color(0xffeeeeee)),
      ),
    );
  }

  //drop zone
  Widget editingDevice() {
    //white screen to display UI

    //editor canvas is wrapped inside CanvasWidget
    thispane.root = CanvasWidget(
      thispane,
      EditorCanvas(
        children: thispane.widgets,
      ),
      isDraggableAndSelectable: false,
      key: GlobalKey(),
      onSelect: (details) {},
      dragStart: () {},
      dragMove: (details) {},
      dragEnd: (details) {},
      dragCompleted: () {},
    );

    return SizedBox(
      width: EditorPane.SCREEN_W,
      height: EditorPane.SCREEN_H,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("New Flutter Project"),
        ),
        body: DragTarget(
          builder: (context, candidateData, rejectedData) {
            return thispane.root!;
          },
        ),
      ),
    );
  }

  //pane to show widget controls
  Widget controlPane(EditorPane editor) {
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
                  print("sj");
                });
              },
            ),
          ],
        ),
        ...?thispane.data.controllers,
      ],
    );
  }

  //widget panel
  Widget widgetPanel(EditorPane editor) {
    thispane.root?.select(true);
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

  //widetpanel -> label
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
      onDragStart: () {},
      onDragMove: (details) {
        onDragMove(details.globalPosition, true);
      },
      onDragCompleted: () {
        thispane.data.currentDraggingWidget = canvasWidget(label);
        onDragEnd(true, thispane.data.currentDraggingWidget!);
        if (thispane.data.currentDroppableWidget != null) {
          thispane.data.currentDroppableWidget =
              thispane.data.currentDroppableWidget;
          thispane.data.currentDroppableWidget
              ?.addChild(thispane.data.currentDraggingWidget!);
        }
      },
    );
  }

  //this widget is generated everytime when user drags widget from pallette
  CanvasWidget canvasWidget(String type) {
    CanvasWidget? cWidget;
    String newId = type + (thispane.widgetId++).toString();

    cWidget = CanvasWidget(
      thispane,
      WidgetsPalletteList().generateWidget(type, GlobalKey()),
      isDraggableAndSelectable: true,
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
        onDragMove(details.globalPosition, false);
      },

      //onDrop
      dragEnd: (details) {
        final draggingView = thispane.data.currentDraggingWidget;
        onDragEnd(false, draggingView!);
        if (thispane.data.currentDroppableWidget != null) {
          print("deleted");

          draggingView.getParent()?.removeChild(draggingView);
          thispane.data.currentDroppableWidget?.addChild(draggingView);
          draggingView.setParent(thispane.data.currentDroppableWidget);
        }
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
    thispane.data.currentDroppableWidget?.select(false);
    thispane.data.currentDraggingWidget?.select(false);
    DragUtils.findTargetAtLocation(thispane.root!, details.globalPosition,
        callback: (parent) {
      print(parent);
      thispane.data.currentDraggingWidget = parent;
      thispane.data.currentDraggingWidget?.select(true);
    });
  }

  void onDragStart(bool isFromPallette) {
    if (isFromPallette) {
    } else {
     
    }
  }

  void onDragMove(Offset location, bool isFromPallette) {
    thispane.data.currentDroppableWidget?.select(false);
    thispane.data.currentDraggingWidget?.select(false);
    DragUtils.findTargetAtLocation(thispane.root!, location,
        callback: (parent) {
      if (parent!.isViewGroup) {
        if (parent.isMultiChilded) {
          thispane.data.currentDroppableWidget = parent;
          parent.select(true);
        } else if (parent.getChildren().isEmpty) {
          thispane.data.currentDroppableWidget = parent;
          parent.select(true);
        }
      }
      thispane.data.currentDroppableWidget = parent;
    });
  }

  void onDragEnd(bool isFromPallette, CanvasWidget widgetToDrop) {
    thispane.data.currentDroppableWidget?.select(false);
  }
}
