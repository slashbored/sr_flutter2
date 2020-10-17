import 'package:flutter/material.dart';

import 'webSocket.dart';

import 'picassosWidget.dart';
import 'paintingMenuBarWidget.dart';

class Draw extends StatefulWidget {
  @override
  DrawState createState() => DrawState();
}

class DrawState extends State<Draw> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: downStream,
      builder: (context, snapShot)  {
        return Scaffold(
          body:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: picassosWidget(300, 300, true)
              ),
              paintingMenuBarWidget(),
              Center(
                  child: picassosWidget(300, 300, false)
              ),
            ],
          ),
        );
      }
    );
  }


}

