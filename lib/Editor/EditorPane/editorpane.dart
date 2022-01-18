import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutteruibuilder/Editor/EditorPane/canvas_widgets.dart';
import 'package:flutteruibuilder/Editor/device_selectorUI.dart';
import 'package:flutteruibuilder/Editor/EditorPane/widgets_pallette_list.dart';
import 'package:flutteruibuilder/Editor/drag_utils.dart';
import 'package:flutteruibuilder/Editor/EditorPane/selection_indicator.dart';
import 'package:flutteruibuilder/Bases/fsketch_widget.dart';
import 'package:flutteruibuilder/Widgets/fs_text.dart';
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
  static const double SCREEN_W = 300;
  // ignore: constant_identifier_names
  static const double SCREEN_H = 550;

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
  State<EditorPane> createState() => state;
}

class _EditorPaneState extends State<EditorPane> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: Stack(
      children: [
        Row(children: [widgetPanel(), canvasPanel(), controlPane()]),
        widget.selectionIndicatior,
        SizedBox(
            width: 100,
            height: 100,
            child: Column(
              children: widget.hiddenWidgets,
            )), //used to store widgets temporarily
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
      padding: EdgeInsets.all(10),
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
      margin: EdgeInsets.all(10),
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
        onTap: () => widget.selectionIndicatior.setVisibility(false),
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
      child: droppable(),
    );
  }

//drop zone area
  Widget droppable() {
    return DragTarget(
      builder: (BuildContext con, List<Object?> l, List<dynamic> d) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("New Flutter Project"),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              children: widget.widgets,
            ),
          ),
        );
      },
    );
  }

//pane to show widget controls
  Widget controlPane() {
    return SizedBox(
        width: EditorPane.WIDGETS_CONROLLER_PANEL_W,
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetController(
                "Text",
                controllers: [
                  TextField(
                    onChanged: (value) {
                      try {
                        (widget.currentDraggingWidget as FlutterSketchWidget)
                            .set("text", value);
                      } catch (e) {
                        print("k : " + e.toString());
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ));
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
          } on Exception {}
        });
      },
    );
  }

//this widget is generated everytime when user drags widget from pallette
  // Widget sampleWidget(String type) {
  //   Widget? draggable; //main widget

  //   // Widget txt = TextWidget(
  //   //   //widget which we want to build
  //   //   key: GlobalKey(),
  //   // );

  //   Widget? txt = widget.pallettelist.generateWidget(type, GlobalKey());

  //   Widget containerBox =
  //       Container(color: Colors.amber, child: IgnorePointer(child: txt));

  //   Widget view = GestureDetector(
  //     child: containerBox,
  //     onTap: () {
  //       widget.selectionIndicatior.setVisibility(true);
  //       widget.selectionIndicatior.selectWidget(txt);
  //     },
  //   );

  //   Widget feedback = Container(
  //       key: GlobalKey(),
  //       color: Colors.amber,
  //       width: 200,
  //       height: 60,
  //       clipBehavior: Clip.none);

  //   void dragStart() {
  //     setState(() {
  //       widget.currentDraggingWidget = draggable;
  //       widget.widgets.remove(draggable);
  //       widget.hiddenWidgets.add(widget.currentDraggingWidget!);
  //     });
  //     widget.selectionIndicatior.selectWidget(draggable!);
  //     widget.selectionIndicatior.setVisibility(false);
  //   }

  //   void dragMove(DragUpdateDetails details) {
  //     for (CanvasWidget wid in widget.widgets) {
  //       if (DragUtils.hitTest(details.globalPosition, wid)) {
  //         widget.selectionIndicatior.selectWidget(wid);
  //         widget.selectionIndicatior.setVisibility(true);
  //       } else {
  //         widget.selectionIndicatior.setVisibility(true);
  //       }
  //     }
  //   }

  //   void drop() {
  //     setState(() {
  //       widget.hiddenWidgets.remove(widget.currentDraggingWidget!);
  //       widget.widgets.add(widget.currentDraggingWidget!);
  //       widget.selectionIndicatior.setVisibility(true);
  //       widget.selectionIndicatior.selectWidget(widget.currentDraggingWidget!);
  //     });
  //   }

  //   draggable = Draggable(
  //       key: GlobalKey(),
  //       child: view,
  //       feedback: feedback,
  //       onDragStarted: () {
  //         dragStart();
  //       },
  //       onDragUpdate: (DragUpdateDetails details) {
  //         debugPrint(details.globalPosition.toString());
  //         dragMove(details);
  //       },
  //       onDragEnd: (details) {
  //         try {
  //           drop();
  //         } catch (e) {
  //           print("drop: " + e.toString());
  //         }
  //       });

  //   return draggable;
  // }

  CanvasWidget canvasWidget(String type) {
    CanvasWidget? cWidget;

    cWidget = CanvasWidget(
      type,
      WidgetsPalletteList().generateWidget(type , GlobalKey()),
      key: GlobalKey(),
      onSelect: (FlutterSketchWidget fsw) {
        widget.selectionIndicatior.setVisibility(true);
        widget.selectionIndicatior.selectWidget(cWidget);
      },
      dragStart: () {
        setState(() {
          widget.currentDraggingWidget = cWidget;
          widget.hiddenWidgets.add(widget.currentDraggingWidget!);
          widget.widgets.remove(widget.currentDraggingWidget!);
        });
        widget.selectionIndicatior.selectWidget(cWidget);
        widget.selectionIndicatior.setVisibility(false);
      
      },
      dragMove: (details) {
          for (CanvasWidget wid in widget.widgets) {
          if (DragUtils.hitTest(details.globalPosition, wid)) {
            widget.selectionIndicatior.selectWidget(wid);
            widget.selectionIndicatior.setVisibility(true);
          } else {
            widget.selectionIndicatior.setVisibility(false);
          }
        }
      
      },
      dragEnd: (details) {
        setState(() {
          widget.hiddenWidgets.remove(widget.currentDraggingWidget!);
          widget.widgets.add(widget.currentDraggingWidget!);
        });
          widget.selectionIndicatior.setVisibility(true);
          widget.selectionIndicatior
              .selectWidget(widget.currentDraggingWidget!);
        print("end");
      },
    );

    return cWidget;
  }
}
