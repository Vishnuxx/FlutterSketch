
import 'package:flutter/material.dart';
import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widget.dart';

// ignore: must_be_immutable
class ElementTreeGraph extends StatefulWidget {
  final _ElementTreeGraphState _state = _ElementTreeGraphState();
  double? width = 0;
  List<Widget>? nodes = [];
  void Function(CanvasWidget wid)? onWidgetSelected;

  ElementTreeGraph({Key? key, this.width, this.onWidgetSelected})
      : super(key: key);

  void refresh(List<CanvasWidget>? list) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      nodes = [];
      _state.drawTree(list, 0);
    });
  }

  @override
  // ignore: no_logic_in_create_state
  State<ElementTreeGraph> createState() => _state;
}

class _ElementTreeGraphState extends State<ElementTreeGraph> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Text("Tree Graph"),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                 ...widget.nodes!,
                ]
              ),
            ),
          ],
        ));
  }

  drawTree(List<CanvasWidget>? list, double marg) {
    for (CanvasWidget node in list!) {
      widget.nodes?.add(treeTile(marg ,  node));
      drawTree(node.fsWidget?.children?.getChildren(), marg + 14);
    }
  }

  Widget treeTile(double margin, CanvasWidget? node) {
    return Container(
        padding: EdgeInsets.only(left: margin, top: 0, right: 0, bottom: 0),
        width: double.infinity,
        height: 30.0,
        child: GestureDetector(
          child: Text("|__" + node!.id  , style: const TextStyle(color: Colors.black54),),
          onTapDown: (details) {
            widget.onWidgetSelected!(node);
          },
        ));
  }
}
