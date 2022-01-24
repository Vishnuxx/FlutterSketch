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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isOpened = !isOpened;
              });
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),

               Icon(Icons.arrow_drop_down)
              ],
            ),
          ),
          SizedBox(height:15.0),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)) , color: const Color(0xffDEDEDE), ),
              height: isOpened ? null: 0,
              child: Column(
                children: [
                  ...?widget.controllers,
                ],
              ))
        ],
      ),
    );
  }
}
