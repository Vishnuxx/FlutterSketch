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
                    style:  TextStyle(color: const Color(0xff666BB4), fontSize: 16 , fontWeight: isOpened? FontWeight.bold : FontWeight.normal),
                  ),
                ),
              RotatedBox(quarterTurns: isOpened? 90 : 0 , child: const Icon(Icons.arrow_drop_down ,),)
               
              ],
            ),
          ),
          const SizedBox(height:15.0),
          Container(
            decoration: const BoxDecoration(border:Border(bottom: BorderSide(width: 0.5, color:  Colors.black12 )) , color: Color(0xffDEDEDE), ),
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
