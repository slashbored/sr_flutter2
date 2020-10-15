import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'webSocket.dart';
import 'dart:convert';
import 'drawingPointsClass.dart';



Widget colorCircle(Color colorPlaceholder) {
  return GestureDetector(
    onTap: () {
      if (colorPlaceholder == Colors.red) {
        upStream.add(json.encode({'type':'paintingColor','content':'Colors.red'}));
      }
      else if (colorPlaceholder == Colors.green) {
        upStream.add(json.encode({'type':'paintingColor','content':'Colors.green'}));
      }
      else if (colorPlaceholder == Colors.blue) {
        upStream.add(json.encode({'type':'paintingColor','content':'Colors.blue'}));
      }
      else if (colorPlaceholder == Colors.yellow) {
        upStream.add(json.encode({'type':'paintingColor','content':'Colors.yellow'}));
      }
      else if (colorPlaceholder == Colors.black) {
        upStream.add(json.encode({'type':'paintingColor','content':'Colors.black'}));
      }
      else if (colorPlaceholder == Colors.white) {
        upStream.add(json.encode({'type':'paintingColor','content':'Colors.white'}));
      }
    },
    child: ClipOval(
      child: Container(
        padding: const EdgeInsets.only(bottom: 16.0),
        height: 36,
        width: 36,
        color: colorPlaceholder,
      )
    )
  );
}