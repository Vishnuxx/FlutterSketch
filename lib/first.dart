import 'package:flutter/material.dart';

class First extends StatelessWidget {
  const First({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: Column(children: [
          ElevatedButton(
              child: Text("GO to Editor"),
              onPressed: () {
                Navigator.pushNamed(context, "/editor");
                // navigatorKey.currentState?.push(
                //   MaterialPageRoute(builder: (context) => const EditorScreen()),
                // );
              }),
        ]),
      )
    );
  }
}