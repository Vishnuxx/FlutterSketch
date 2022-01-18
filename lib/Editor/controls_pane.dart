import 'package:flutter/material.dart';

class ControllerPane extends StatelessWidget {
  double? width = 0;
  double? padding = 0;
  List<Widget> ?children;

  ControllerPane({Key? key, this.width, this.children}) : super(key: key);

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
