import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'webSocket.dart';
import 'dart:convert';
import 'drawingPointsClass.dart';
import 'drawingPainterClass.dart';
import 'colorCircleWidget.dart';
import 'picassosWidget.dart';
import 'paintingMenuBarWidget.dart';

class Draw extends StatefulWidget {
  @override
  DrawState createState() => DrawState();
}

class DrawState extends State<Draw> {
  //static List<DrawingPoints> points = List();

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
                  child: picassosWidget(300, 300)
              ),
              paintingMenuBarWidget(),
            ],
          ),

        );
      }
    );
  }


}

