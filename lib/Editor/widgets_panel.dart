import 'package:flutter/material.dart';

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
            decoration: BoxDecoration(
              
                border: Border(right: BorderSide(color: Colors.black12 , width: 0.5)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Reccent" , style: TextStyle(fontSize: 12 , color: Color(0xff9EA9B9)),) , 
                    Text("Default" , style: TextStyle(fontSize: 12  , color: Color(0xff666BB4), fontWeight: FontWeight.bold),) ,
                    Text("Custom" , style: TextStyle(fontSize: 12 , color: Color(0xff9EA9B9) ),)
                  ],),
                ),
                SizedBox(height:10),
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
      decoration: BoxDecoration(border: Border(right: BorderSide(width: 0.8, color:  Colors.black12 ))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.ac_unit_outlined , color: Color(0xffF39423),) , 
            Icon(Icons.access_alarm , color: Color(0xff8E91C5),) , 
            Icon(Icons.access_time , color: Color(0xff8E91C5),) , 
        ],),
      ),
    );
  }
}
