import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ControlsPane extends StatelessWidget {
  double? width = 0;
  double? padding = 0;
  List<Widget> ?children;

  ControlsPane({Key? key, this.padding , this.width, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: const BoxDecoration( border: Border(left: BorderSide(width: 0.5, color:  Color(0xff666BB4) ))),
              padding: EdgeInsets.all(padding!),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: children!,
              )),
        ));
  }
}
