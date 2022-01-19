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
        child: Container(
            padding: EdgeInsets.all(padding!),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children!,
            )));
  }
}
