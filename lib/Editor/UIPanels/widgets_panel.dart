// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
    return Row(
      children: [
        sideNavigationBar(),
        Container(
            width: widget.width,
            decoration: const BoxDecoration(
              
                border: Border(right: const BorderSide(color: const Color(0xff666BB4) , width: 0.5)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                    Text("Reccent" , style: TextStyle(fontSize: 12 , color: Color(0xff9EA9B9)),) , 
                    Text("Default" , style: TextStyle(fontSize: 12  , color: Color(0xff666BB4), fontWeight: FontWeight.bold),) ,
                    Text("Custom" , style: TextStyle(fontSize: 12 , color: Color(0xff9EA9B9) ),)
                  ],),
                ),
                const SizedBox(height:10),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [...?widget.children]),
                ),
              ],
            )),
      ],
    );
  }

  Widget sideNavigationBar() {
    return Container(
      decoration: const BoxDecoration(border: const Border(right: const BorderSide(width: 0.8, color:  Colors.black12 ))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.ac_unit_outlined , color: Color(0xffF39423),) , 
            Icon(Icons.access_alarm , color: Color(0xff8E91C5),) , 
            Icon(Icons.access_time , color: Color(0xff8E91C5),) , 
        ],),
      ),
    );
  }
}
