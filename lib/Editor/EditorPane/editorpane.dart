import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Bases/canvas_widgets.dart';
import 'package:flutteruibuilder/Controls/controls_pane.dart';
import 'package:flutteruibuilder/Editor/EditorPane/drag_shadow.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editor_canvas.dart';
import 'package:flutteruibuilder/Editor/EditorPane/widgets_pallette_list.dart';
import 'package:flutteruibuilder/Editor/drag_utils.dart';
import 'package:flutteruibuilder/Editor/EditorPane/selection_indicator.dart';
import 'package:flutteruibuilder/Bases/fsketch_widget.dart';
import 'package:flutteruibuilder/Bases/palette_widget.dart';
import 'package:flutteruibuilder/Bases/widget_controller.dart';

// ignore: must_be_immutable
class EditorPane extends StatefulWidget {
  final state = _EditorPaneState();

  // ignore: constant_identifier_names
  static const double WIDGETS_PANEL_W = 150;
  // ignore: constant_identifier_names
  static const double WIDGETS_CONROLLER_PANEL_W = 250;
  // ignore: constant_identifier_names
  static double SCREEN_W = 300;
  // ignore: constant_identifier_names
  static double SCREEN_H = 550;

  List<CanvasWidget> widgets = [];
  SelectionIndicatior selectionIndicatior = SelectionIndicatior();
  CanvasWidget? currentDraggingWidget;

  Widget? dummyBox; //dummy widget is used to indicate the  droppable region
  List<Widget> hiddenWidgets = [];

  WidgetsPalletteList pallettelist = WidgetsPalletteList();

  EditorPane({Key? key}) : super(key: key);

  void setState(Function callback) {
    // ignore: invalid_use_of_protected_member
    state.setState(() {
      callback();
    });
  }

  @override
  // ignore: no_logic_in_create_state
  State<EditorPane> createState() => state;
}

class _EditorPaneState extends State<EditorPane> {
  List<WidgetController>? controllers = [];
  DragShadow shadow = DragShadow();
  late EditorCanvas canvas;
  CanvasWidget? dropTarget;

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
              children: widget.hiddenWidgets,
            )), //used to store widgets temporarily
        shadow
      ],
    ));
  }

/*
  ______________UI Components______________
*/

  Widget dummy() {
    return Container(
      width: 100,
      height: 50,
      color: Colors.black26,
    );
  }

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
          draggablePallette("Row", "/pallette_icons/icon1.png"),
          draggablePallette("Column", "/pallette_icons/icon1.png"),
          draggablePallette("Container", "/pallette_icons/icon1.png"),
          draggablePallette("Wrap", "/pallette_icons/icon1.png"),
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("New Flutter Project"),
        ),
        body: DragTarget(
          builder: (context, candidateData, rejectedData) {
            return EditorCanvas(key: GlobalKey(), children: widget.widgets);
            ;
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
      onDragCompleted: () {
        setState(() {
          try {
            var a = canvasWidget(label); //sampleWidget(label);
            widget.widgets.add(a);
            widget.currentDraggingWidget = a;
            // ignore: empty_catches
          } on Exception {}
        });
      },
    );
  }


  //this widget is generated everytime when user drags widget from pallette  
  CanvasWidget canvasWidget(String type) {
    CanvasWidget? cWidget;

    cWidget = CanvasWidget(
      type,
      WidgetsPalletteList().generateWidget(type, GlobalKey()),
      key: GlobalKey(),
      onSelect: (TapDownDetails details) {
        setState(() {
          widget.currentDraggingWidget = DragUtils.getTappedWidget(
              cWidget!, details.globalPosition, widget.selectionIndicatior,
              (cv) {
            widget.selectionIndicatior.setVisibility(true);
            widget.selectionIndicatior.selectWidget(cv);
            
            controllers = null;
            controllers = cv.widget!.controllers!;
            print(cv);
          }, () {
          
          });
          
        });
      },
      dragStart: () {
        shadow.setSizeOf(cWidget!);
        setState(() {
          widget.currentDraggingWidget = cWidget;
          widget.widgets.remove(widget.currentDraggingWidget!);
          widget.hiddenWidgets.add(widget.currentDraggingWidget!);
          controllers = null;

          widget.selectionIndicatior.selectWidget(cWidget);
          widget.selectionIndicatior.setVisibility(false);
        });
      },
      dragMove: (details) {
        shadow.setVisibility(true);
        shadow.setPosition(details);

        dropTarget = DragUtils.findCanvasWidget(
            details.globalPosition, widget , widget.selectionIndicatior,
            (target) {
          //hasEntered

          widget.selectionIndicatior.selectWidget(target);
          widget.selectionIndicatior.setVisibility(true);
        }, () {
          //hasNotEntered

          widget.selectionIndicatior.setVisibility(false);
        });

      
      },
      dragEnd: (details) {
        shadow.setVisibility(false);
        setState(() {
          if (dropTarget != null && dropTarget!.widget!.isViewGroup!) {
            if (dropTarget!.widget!.isMultiChilded!) {
              widget.hiddenWidgets.remove(widget.currentDraggingWidget!);
              dropTarget!.widget!.children!.add(widget.currentDraggingWidget!);
            } else if (dropTarget!.widget!.children!.isEmpty()) {
              widget.hiddenWidgets.remove(widget.currentDraggingWidget!);
              dropTarget!.widget!.children!
                  .insert(0, widget.currentDraggingWidget!);
            }
          } else {
            widget.hiddenWidgets.remove(widget.currentDraggingWidget!);
            widget.widgets.add(widget.currentDraggingWidget!);
          }
          // widget.hiddenWidgets.remove(widget.currentDraggingWidget!);
          // widget.widgets.add(widget.currentDraggingWidget!);
        });
      },
      dragCompleted: () {
        widget.selectionIndicatior.setVisibility(false);
      },
    );

    return cWidget;
  }
}
