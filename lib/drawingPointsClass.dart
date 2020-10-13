import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'webSocket.dart';
import 'dart:convert';
import 'package:quiver/collection.dart';


class DrawingPoints {
  static List<DrawingPoints> pointList;
  Paint paint = Paint()
    ..strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round
    ..isAntiAlias = true
    ..color = Colors.black.withOpacity(0)
    ..strokeWidth = 10;
  Offset points;
  //DrawingPoints({this.points, this.paint});

  DrawingPoints(Map<String, dynamic> data)  {
    /*paint = Paint()
      ..strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round
      ..isAntiAlias = true
      ..color = Colors.black.withOpacity(0)
      ..strokeWidth = 10;*/
    List<String> tempStringList=data.toString().split(";");
    points=Offset(double.parse(tempStringList[1]),double.parse(tempStringList[2]));
  }
}