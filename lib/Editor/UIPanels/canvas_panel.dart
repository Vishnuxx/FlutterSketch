import 'package:flutter/material.dart';

class CanvasPanel extends StatelessWidget {
 
  final void Function()? onTap;
  final Widget? canvas;

  CanvasPanel({Key? key, @required this.onTap, @required this.canvas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap!();
        },
        child:
            Container(child: Center(child: canvas), color: Color(0xffeeeeee)),
      ),
    );
    ;
  }
}
