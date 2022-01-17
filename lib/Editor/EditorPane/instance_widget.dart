import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/EditorPane/editorpane.dart';
import 'package:flutteruibuilder/Editor/drag_utils.dart';
import 'package:flutteruibuilder/Palette/Widgets/fs_text.dart';
import 'package:flutteruibuilder/Palette/fsketch_widget.dart';

class InstanceWidget extends StatefulWidget {
  final _state = _InstanceWidgetState();
  final _editor = EditorPane();

  InstanceWidget(EditorPane editor, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _InstanceWidgetState createState() => _state;

  
}

class _InstanceWidgetState extends State<InstanceWidget> {
  @override
  Widget build(BuildContext context) {
    return sampleWidget();
  }

//this widget is generated everytime when user drags widget from pallette
  Widget sampleWidget() {
    Widget? draggable; //main widget

    Widget txt = FSText(
      //widget which we want to build
    );

    Widget containerBox =
        Container(key: GlobalKey(), color: Colors.amber, child: txt);

    Widget view = GestureDetector(
      child: Wrap(
        children: [
          containerBox,
        ],
      ),
      onTap: () {
        widget._editor.selectionIndicatior.setVisibility(true);
        (txt as FlutterSketchWidget).set("text", "this widget is selected \n ihihd\n");
        widget._editor.selectionIndicatior.selectWidget(txt);
      },
    );

    Widget feedback = Container(
        key: GlobalKey(),
        color: Colors.amber,
        width: 200,
        height: 60,
        clipBehavior: Clip.none);

    void dragStart() {
      widget._editor.setState(() {
        widget._editor.currentDraggingWidget = draggable;
        widget._editor.widgets.remove(draggable as Widget);
        widget._editor.hiddenWidgets.add(widget._editor.currentDraggingWidget!);
      });
      try {
        debugPrint((widget._editor.widgets[widget._editor.widgets.length - 1] ==
                widget._editor.currentDraggingWidget)
            .toString());
        widget._editor.selectionIndicatior.selectWidget(draggable!);
        widget._editor.selectionIndicatior.setVisibility(false);
      } catch (e) {
        //   print("_______________");
      }
    }

    void dragMove(DragUpdateDetails details) {
      for (Widget wid in widget._editor.widgets) {
        if (DragUtils.hitTest(details.globalPosition, wid)) {
          widget._editor.selectionIndicatior.selectWidget(wid);
          widget._editor.selectionIndicatior.setVisibility(true);
        } else {
          widget._editor.selectionIndicatior.setVisibility(true);
        }
      }
    }

    void drop() {
     widget._editor.setState(() {
        widget._editor.hiddenWidgets
            .remove(widget._editor.currentDraggingWidget!);
        widget._editor.widgets.add(widget._editor.currentDraggingWidget!);
        widget._editor.selectionIndicatior.setVisibility(true);
        widget._editor.selectionIndicatior
            .selectWidget(widget._editor.currentDraggingWidget!);
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
          debugPrint(details.globalPosition.toString());
          dragMove(details);
        },
        onDragEnd: (details) {
          drop();
        });

    return draggable;
  }
}
