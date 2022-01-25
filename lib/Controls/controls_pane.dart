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
              decoration: BoxDecoration(color: Color(0xffE9ECF2), borderRadius: BorderRadius.all(Radius.circular(10)) ) ,
              padding: EdgeInsets.all(padding!),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: children!,
              )),
        ));
  }
}
