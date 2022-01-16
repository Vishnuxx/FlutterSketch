import 'package:flutter/material.dart';

class Dummy extends StatefulWidget {
  final _state = _DummyState();
  final _map = {
    "width" : 0.0 ,
    "height" : 0.0 ,
    "isVisible" : true
   };

  Dummy({Key? key}) : super(key: key);

  void set(String key, String value) {}

  @override
  // ignore: no_logic_in_create_state
  _DummyState createState() => _state;
}

class _DummyState extends State<Dummy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:double.parse(widget._map["width"].toString()),
    );
  }
}
