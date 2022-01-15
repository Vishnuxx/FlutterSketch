import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutteruibuilder/Editor/EditorPane/drag_utils.dart';
import 'package:flutteruibuilder/Editor/EditorPane/selection_indicator.dart';
import 'package:flutteruibuilder/Palette/Widgets/text_widget.dart';
import 'package:flutteruibuilder/Palette/palette_widget.dart';

class EditorPane extends StatefulWidget {
  EditorPane({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<EditorPane> createState() => _EditorPaneState();
}

class _EditorPaneState extends State<EditorPane> {
  final double WIDGETS_PANEL_W = 150;
  final double WIDGETS_CONROLLER_PANEL_W = 200;

  final double SCREEN_W = 300;
  final double SCREEN_H = 550;

  SelectionIndicatior selectionIndicatior = SelectionIndicatior();

  List<Widget> widgets = [];
  Widget? currentDraggingWidget;
  List<Widget> hiddenWidgets = [];

  var key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: Stack(
      children: [
        Row(children: [widgetPanel(), canvasPanel(), controlPane()]),
        selectionIndicatior
      ],
    ));
  }

/*
  ______________UI Components______________
*/

  Widget widgetPanel() {
    return Container(
      width: WIDGETS_PANEL_W,
      color: const Color(0xffffffff),
      child: Column(
        children: [
          label("Widgets"),
          draggablePallette("Text"),
          draggablePallette("Button"),
          draggablePallette("IconButton"),
          draggablePallette("Imageview"),
          draggablePallette("progress bar"),
          draggablePallette("seekbar"),
          draggablePallette("padding"),
          draggablePallette("sizedbox"),
          label("Layouts"),
          draggablePallette("Row"),
          draggablePallette("Column"),
          draggablePallette("Container"),
          draggablePallette("Wrap"),
        ],
      ),
    );
  }

  Widget label(String name) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Text(
          name,
          style: TextStyle(color: Colors.blue, fontSize: 20),
        ),
      ),
    );
  }

//canvas for showing the device
  Widget canvasPanel() {
    return Expanded(
      flex: 4,
      child: GestureDetector(
        onTap: () => selectionIndicatior.setVisibility(false),
        child: Container(
            color: const Color(0xffEDECEC), child: Center(child: editorPane())),
      ),
    );
  }

  //drop zone
  Widget editorPane() {
    return SizedBox(
      width: SCREEN_W,
      height: SCREEN_H,
      child: droppable(),
    );
  }

//drop zone area
  Widget droppable() {
    return DragTarget(
      builder: (BuildContext con, List<Object?> l, List<dynamic> d) {
        return Scaffold(
          appBar: AppBar(
            title: Text("New Flutter Project"),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              children: widgets,
            ),
          ),
        );
      },
    );
  }

//pane to show widget controls
  Widget controlPane() {
    return Container(
      width: WIDGETS_CONROLLER_PANEL_W,
      child: Column(
        children: hiddenWidgets,
      ),
    );
  }

//pallette widgets
  Widget draggablePallette(String label) {
    return PaletteWidget(
      isDraggable: true,
      label: label,
      onDragCompleted: () {
        setState(() {
          try {
            widgets.add(sampleWidget());
            //print((widgets[0] as TextWidget).props["text"]);
          } on Exception catch (e) {
            print("added");
          }
        });
      },
    );
  }

//this widget is generated everytime when user drags widget from pallette
  Widget sampleWidget() {
    Widget? draggable = null;

    Widget txt = TextWidget(
      key: GlobalKey(),
    );
    Widget widget =
        Container(key: GlobalKey(), color: Colors.amber, child: txt);
    Widget view = GestureDetector(
      child: Wrap(
        children: [
          widget,
        ],
      ),
      onTap: () {
        selectionIndicatior.setVisibility(true);
        (txt as TextWidget)
            .set("text", "this is sel ejh ejshe selected \n ihihd\n");
        selectionIndicatior.selectWidget(txt);
      },
    );

    Widget feedback = Container(
        key: GlobalKey(),
        color: Colors.amber,
        width: 200,
        height: 60,
        clipBehavior: Clip.none);

    void dragStart() {
      setState(() {
        currentDraggingWidget = draggable;
        widgets.remove(draggable as Widget);
        hiddenWidgets.add(currentDraggingWidget!);
      });
      try {
        debugPrint(
            (widgets[widgets.length - 1] == currentDraggingWidget).toString());
        selectionIndicatior.selectWidget(draggable!);
        selectionIndicatior.setVisibility(false);
      } catch (e) {
        //   print("_______________");
      }
    }

    void dragMove(DragUpdateDetails details) {
      for (Widget wid in widgets) {
        if (DragUtils.hitTest(details.globalPosition, wid)) {
          selectionIndicatior.selectWidget(wid);
          selectionIndicatior.setVisibility(true);
        
        } else {
          selectionIndicatior.setVisibility(true);
        }
      }
    }

    void drop() {
      setState(() {
      hiddenWidgets.remove(currentDraggingWidget!);
      widgets.add(currentDraggingWidget!);
      selectionIndicatior.setVisibility(true);
      selectionIndicatior.selectWidget(currentDraggingWidget!);
      });
     
    }

    draggable = Draggable(
        key: GlobalKey(),
        child: view,
        feedback: feedback,
        onDragStarted: () {
          dragStart();
        },
        onDragUpdate: (DragUpdateDetails details) {
          print(details.globalPosition.toString());
          dragMove(details);
        },
        onDragEnd: (DraggableDetails) {
          drop();
        });

    return draggable;
  }
}
