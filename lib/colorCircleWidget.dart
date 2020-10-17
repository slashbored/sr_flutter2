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
      else if (colorPlaceholder == Colors.pink) {
        upStream.add(json.encode({'type':'paintingColor','content':'Colors.pink'}));
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
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorPlaceholder,
          border: Border.all(
            color: Colors.black,
            width: 3
          )
        ),
        padding: const EdgeInsets.only(bottom: 16.0),
        height: 25,
        width: 25,
      )
    )
  );
}