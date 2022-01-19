// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DeviceSelector extends StatefulWidget {
  const DeviceSelector({Key? key}) : super(key: key);

  @override
  _DeviceSelectorState createState() => _DeviceSelectorState();
}

class _DeviceSelectorState extends State<DeviceSelector> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.fromLTRB(100, 50, 100, 150),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Device",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              const Text(
                  "FlutterSketch provides you to select custom device sizes to preview in different device configurations"),
              const SizedBox(height: 30,),
             deviceList()
            ],
          ),
        ));
  }

  Widget deviceList() {
    return Column(
      children: [
        listTile("Generic Android", 400 , 310),
        listTile("Generic Android", 400 , 310),
        listTile("Generic Android", 400 , 310),
        listTile("Generic Android", 400 , 310),
        listTile("Generic Android", 400 , 310),
        listTile("Generic Android", 400 , 310),
        listTile("Generic Android", 400 , 310),
        listTile("Generic Android", 400 , 310),
        listTile("Generic Android", 400 , 310),
        listTile("Generic Android", 400 , 310),
        listTile("Generic Android", 400 , 310),
        listTile("Generic Android", 400 , 310)
      ],
    );
  }

  Widget listTile(String name, double height, double width) {
    return Container(
      width: 300,
      height: 20,
      decoration: const BoxDecoration( color: Colors.black12 ,  borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Row(children: [
        Expanded(child: Text(name), flex: 1,) ,
        Expanded(child: Text(height.toString()), flex: 1,),
        Expanded(child: Text(width.toString()), flex: 1,)
        
      ],),
    );
  }
}
