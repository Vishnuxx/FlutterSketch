import 'package:flutter/material.dart';

class WidgetController extends StatelessWidget {
  List<Widget>? controllers;
  String title;

  WidgetController(this.title , {Key? key, List<Widget>? this.controllers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title , style: TextStyle(color: Colors.blue , fontSize: 10),),
        ...?controllers,
      ],
    );
  }
}
