import 'package:flutter/material.dart';

class EditorPane extends StatefulWidget {
  const EditorPane({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<EditorPane> createState() => _EditorPaneState();
}



class _EditorPaneState extends State<EditorPane> {
  var txt = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(children: [
        Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xffE5E5E5),
              child: Column(
                children: [draggableBox()],
              ),
            )),
        Expanded(
            flex: 4,
            child:
                Container(color: const Color(0xffF6F4F4), child: editorPane()))
      ]),
    );
  }

  Widget editorPane() {
    return Center(
        child: SizedBox(
      width: 600.0,
      height: 450.0,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Screen1"),
          ),
          body: droppable(),
        ),
      ),
    ));
  }

  Widget draggableBox() {
    return Draggable(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.lightGreenAccent,
        child: Center(
          child: Text(txt.toString()),
        ),
      ),
      feedback: const Text("Dragging"),
      onDragUpdate: (DragUpdateDetails details) {
        setState(() {
          txt = details.globalPosition.dx;
        });
      },
    );
  }

  Widget droppable() {
    return DragTarget(
      builder: (BuildContext context, List<dynamic> accepted,
          List<dynamic> rejected) {
        return Container(
          height: 100.0,
          width: 100.0,
          color: Colors.cyan,
          child: const Center(
            child: Text('Value is updated to'),
          ),
        );
      },
      onAccept: (int data) {},
    );
  }
}
