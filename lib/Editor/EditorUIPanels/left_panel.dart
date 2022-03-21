import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LeftPanel extends StatefulWidget {
  double? width = 50;
  List<Widget>? children;

  LeftPanel({Key? key, this.width, this.children}) : super(key: key);

  @override
  State<LeftPanel> createState() => _LeftPanelState();
}

class _LeftPanelState extends State<LeftPanel> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Row(
        children: [
          sideNavigationBar() ,
          IndexedStack(
            index: index,
            children: [...widget.children!],
          ),
        ],
      ),
    );
  }

   Widget sideNavigationBar() {
    return Container(
      decoration: const BoxDecoration(border: Border(right: BorderSide(width: 0.8, color:  Colors.black12 ))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.auto_awesome_mosaic_outlined   , color: Color(0xffF39423),) , 
            Icon(Icons.account_tree_outlined, color: Color(0xff8E91C5),) , 
  
            Icon(Icons.architecture , color: Color(0xff8E91C5),) , 
        ],),
      ),
    );
  }
}
