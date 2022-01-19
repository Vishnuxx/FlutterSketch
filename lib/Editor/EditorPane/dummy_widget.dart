import 'package:flutter/material.dart';

class Dummy extends StatefulWidget {
  final _state = _DummyState();
  final _map = {"width": 0.0, "height": 0.0, "isVisible": true};

  Dummy({Key? key}) : super(key: key);

  void set(String key, String value) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _map[key] = value;
    });
  }

  @override
  // ignore: no_logic_in_create_state
  _DummyState createState() => _state;
}

class _DummyState extends State<Dummy> {
  @override
  Widget build(BuildContext context) {
    if (widget._map["isVisible"] as bool) {
      return SizedBox(
        width: double.parse(widget._map["width"].toString()),
        height: double.parse(widget._map["height"].toString()),
      );
    } else {
      return const SizedBox(width: 0, height: 0);
    }
  }
}
