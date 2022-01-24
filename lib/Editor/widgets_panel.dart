import 'package:flutter/material.dart';

class WidgetPanel extends StatefulWidget {
  double width = 0;
  List<Widget>? children = [];
  WidgetPanel(this.width, {Key? key , this.children}) : super(key: key);

  @override
  State<WidgetPanel> createState() => _WidgetPanelState();
}

class _WidgetPanelState extends State<WidgetPanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: widget.width,
          decoration: BoxDecoration(
              color: const Color(0xffEDECEC),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(10),
          child: ListView(children: [...?widget.children])),
    );
  }
}
