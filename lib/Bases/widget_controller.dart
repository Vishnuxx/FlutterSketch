import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetController extends StatelessWidget {
  List<Widget>? controllers;
  String title;

  WidgetController(this.title , {Key? key, this.controllers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title , style: const TextStyle(color: Colors.blue , fontSize: 15),),
        ...?controllers,
      ],
    );
  }
}
