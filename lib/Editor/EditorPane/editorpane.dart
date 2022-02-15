import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widgets.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/cw_drag_data.dart';
import 'package:flutteruibuilder/Editor/Bases/cw_holder.dart';
import 'package:flutteruibuilder/Editor/Bases/traversal_data.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editor_canvas.dart';
import 'package:flutteruibuilder/Editor/UIPanels/canvas_panel.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editor_pane_data.dart';
import 'package:flutteruibuilder/Editor/UIPanels/controls_pane.dart';

import 'package:flutteruibuilder/Editor/EditorPane/widgets_pallette_list.dart';
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
        body: Container(
          child: Stack(
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
          ),
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
            child: Center(child: editingDevice()), color: Color(0xffeeeeee)),
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
      false,
      key: GlobalKey(),
    );

    //
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
        //   setState(() {
        try {
          thispane.data.currentDraggingWidget = canvasWidget(label);

          // ignore: empty_catches
        } catch (e) {
          print("draggablePallette()" + e.toString());
        }
        onDragEnd(true, thispane.data.currentDraggingWidget!);
        //  });
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
      true,
      id: newId,
      key: GlobalKey(debugLabel: "vishnu"),
      //on element selected
      onSelect: (tapdetails) {
        onSelect(tapdetails);
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
        onDragEnd(false, thispane.data.currentDraggingWidget!);
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
    thispane.data.isSelected = true;
    thispane.data.controllers = null;
    DragUtils.findTargetAtLocation(
      thispane.root!,
      details.globalPosition,
      callback: (parent) {
        thispane.data.currentDraggingWidget = parent;
      },
    );
    thispane.data.controllers =
        thispane.data.currentDraggingWidget?.fsWidget?.controllers;
  }

  void onDragStart(bool isFromPallette) {
    if (isFromPallette) {}
  }

  void onDragMove(Offset location, bool isFromPallette) {
    DragUtils.findTargetAtLocation(thispane.root!, location,
        callback: (parent) {
      
      thispane.data.currentDroppableWidget = parent;
      print("object");
    });
  }

  void onDragEnd(bool isFromPallette, CanvasWidget widgetToDrop) {
    var editorpanedata = thispane.data;
    CWDragData data = CWDragData();
    if (isFromPallette) {
      thispane.widgets?.add(widgetToDrop);

      if (thispane.data.currentDroppableWidget == thispane.root) {
        widgetToDrop.dropTo(data, thispane.data.currentDroppableWidget);
      }
    }

    editorpanedata.currentDraggingWidget!
        .dropTo(data, editorpanedata.currentDroppableWidget);
    editorpanedata.selectionIndicatior.selectWidget(null);
    editorpanedata.tree?.refresh(thispane.widgets?.getChildren());
  }
}
