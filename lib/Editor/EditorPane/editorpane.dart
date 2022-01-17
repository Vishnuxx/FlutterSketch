import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/EditorPane/widgets_pallette_list.dart';
import 'package:flutteruibuilder/Editor/drag_utils.dart';
import 'package:flutteruibuilder/Editor/EditorPane/selection_indicator.dart';
import 'package:flutteruibuilder/Palette/fsketch_widget.dart';
import 'package:flutteruibuilder/Palette/Widgets/fs_text.dart';
import 'package:flutteruibuilder/Palette/palette_widget.dart';

// ignore: must_be_immutable
class EditorPane extends StatefulWidget {
  final state = _EditorPaneState();

  // ignore: constant_identifier_names
  static const double WIDGETS_PANEL_W = 150;
  // ignore: constant_identifier_names
  static const double WIDGETS_CONROLLER_PANEL_W = 200;
  // ignore: constant_identifier_names
  static const double SCREEN_W = 300;
  // ignore: constant_identifier_names
  static const double SCREEN_H = 550;

  List<Widget> widgets = [];
  SelectionIndicatior selectionIndicatior = SelectionIndicatior();
  Widget? currentDraggingWidget;

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
        SizedBox(
            width: 0,
            height: 0,
            child: Column(
              children: widget.hiddenWidgets,
            )), //used to store widgets temporarily
        Row(children: [widgetPanel(), canvasPanel(), controlPane()]),
        widget.selectionIndicatior
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
      color: const Color(0xffffffff),
      child: Column(
        children: [
          label("Widgets"),
          draggablePallette("TextWidget"),
          draggablePallette("Container"),
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
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Text(
          name,
          style: const TextStyle(color: Colors.blue, fontSize: 20),
        ),
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
    return const SizedBox(
        width: EditorPane.WIDGETS_CONROLLER_PANEL_W, child: null);
  }

//pallette widgets
  Widget draggablePallette(String label) {
    return PaletteWidget(
      isDraggable: true,
      label: label,
      onDragCompleted: () {
        setState(() {
          try {
            widget.widgets.add(sampleWidget(label));
          } on Exception {}
        });
      },
    );
  }

//this widget is generated everytime when user drags widget from pallette
  Widget sampleWidget(String type) {
    Widget? draggable; //main widget

    // Widget txt = TextWidget(
    //   //widget which we want to build
    //   key: GlobalKey(),
    // );

    Widget? txt = widget.pallettelist.generateWidget(type , GlobalKey());

    Widget containerBox = Container(color: Colors.amber, child: IgnorePointer(child: txt));

    Widget view = GestureDetector(
      child: containerBox,
      onTap: () {
        widget.selectionIndicatior.setVisibility(true);
        widget.selectionIndicatior.selectWidget(txt);
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
        widget.currentDraggingWidget = draggable;
        widget.widgets.remove(draggable as Widget);
        widget.hiddenWidgets.add(widget.currentDraggingWidget!);
      });
      widget.selectionIndicatior.selectWidget(draggable!);
      widget.selectionIndicatior.setVisibility(false);
    }

    void dragMove(DragUpdateDetails details) {
      for (Widget wid in widget.widgets) {
        if (DragUtils.hitTest(details.globalPosition, wid)) {
          widget.selectionIndicatior.selectWidget(wid);
          widget.selectionIndicatior.setVisibility(true);
        } else {
          widget.selectionIndicatior.setVisibility(true);
        }
      }
    }

    void drop() {
      setState(() {
        widget.hiddenWidgets.remove(widget.currentDraggingWidget!);
        widget.widgets.add(widget.currentDraggingWidget!);
        widget.selectionIndicatior.setVisibility(true);
        widget.selectionIndicatior.selectWidget(widget.currentDraggingWidget!);
      });
    }

    draggable = Draggable(
        key: GlobalKey(),
        child: view ,
        feedback: feedback,
        onDragStarted: () {
          dragStart();
        },
        onDragUpdate: (DragUpdateDetails details) {
          debugPrint(details.globalPosition.toString());
          dragMove(details);
        },
        onDragEnd: (details) {
          try {
            drop();
          } catch (e) {
            print("drop: " + e.toString());
          }
        });

    return draggable;
  }
}
