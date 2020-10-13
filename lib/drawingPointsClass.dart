import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'webSocket.dart';
import 'dart:convert';
import 'package:quiver/collection.dart';


class DrawingPoints {
  Paint paint = Paint()
    ..strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round
    ..isAntiAlias = true
    ..color = Colors.black
    ..strokeWidth = 10;
  Offset points;
  //DrawingPoints({this.points, this.paint});

  DrawingPoints(String data)  {
    /*paint = Paint()
      ..strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round
      ..isAntiAlias = true
      ..color = Colors.black.withOpacity(0)
      ..strokeWidth = 10;*/
    if (data!=null) {
      List<String> tempStringList=data.split(";");
      points=Offset(double.parse(tempStringList[0]),double.parse(tempStringList[1]));
    }
  }
}