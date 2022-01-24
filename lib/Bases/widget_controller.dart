import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetController extends StatefulWidget {
  List<Widget>? controllers;
  String title;

  WidgetController(this.title, {Key? key, this.controllers}) : super(key: key);

  @override
  State<WidgetController> createState() => _WidgetControllerState();
}

class _WidgetControllerState extends State<WidgetController> {
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
    isOpened = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isOpened = !isOpened;
            });
          },
          child: Text(
            widget.title,
            style: const TextStyle(color: Colors.blue, fontSize: 15),
          ),
        ),
        Container(
            height: isOpened ? null: 0,
            child: Column(
              children: [
                ...?widget.controllers,
              ],
            ))
      ],
    );
  }
}
