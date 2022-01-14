import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Palette/Widgets/text_widget.dart';
import 'package:flutteruibuilder/Palette/palette_widget.dart';

class EditorPane extends StatefulWidget {
  EditorPane({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<EditorPane> createState() => _EditorPaneState();
}

class _EditorPaneState extends State<EditorPane> {
  List<Widget> widgets = [TextWidget()];
  var key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    widgets = widgets;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Row(children: [
          widgetPanel(),
          Expanded(
              flex: 4,
              child: Container(
                  color: const Color(0xffF6F4F4), child: editorPane())),
          Expanded(flex: 1, child: Container())
        ]),
        floatingActionButton: FloatingActionButton(onPressed: () {
          (widgets[0] as TextWidget).set("text", "hello im vishnu");
          print("hello im vishnu");
        }));
  }

  Widget widgetPanel() {
    return Expanded(
        flex: 1,
        child: Container(
          color: const Color(0xffE5E5E5),
          child: ListView(
            children: [
              draggable("Widget1"),
              draggable("Widget2"),
              draggable("Widget3"),
              draggable("Widget4"),
              draggable("Widget5"),
              draggable("Widget6"),
              draggable("Widget7"),
              draggable("Widget8"),
            ],
          ),
        ));
  }

  Widget draggable(String label) {
    return PaletteWidget(
      isDraggable: true,
      label: label,
      onDragCompleted: () {
        setState(() {
          try {
            widgets.add(TextWidget());
            print((widgets[0] as TextWidget).props["text"]);
          } on Exception catch (e) {
            print("added");
          }
        });
      },
    );
  }

  Widget editorPane() {
    return Center(
        child: SizedBox(
      width: 350.0,
      height: 650.0,
      child: droppable(),
    ));
  }

  Widget droppable() {
    return DragTarget(
      builder: (BuildContext con, List<Object?> l, List<dynamic> d) {
        return MaterialApp(
            home: Scaffold(
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
        ));
      },
    );
  }
}
