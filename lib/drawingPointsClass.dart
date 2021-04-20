import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'webSocket.dart';
import 'dart:convert';
import 'package:quiver/collection.dart';


class DrawingPoints {
  Paint paint = Paint()
    ..strokeCap = (kIsWeb) ? StrokeCap.butt : (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round
    ..isAntiAlias = true
    ..color = color
    ..strokeWidth = strokeWidth;
  Offset points;

  DrawingPoints(String data)  {
      List<String> tempStringList=data.split(";");
      points=Offset(double.parse(tempStringList[0]),double.parse(tempStringList[1]));
  }
}

