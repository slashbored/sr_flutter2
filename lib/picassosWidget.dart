import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'webSocket.dart';
import 'dart:convert';
import 'drawingPointsClass.dart';
import 'colorCircleWidget.dart';

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'webSocket.dart';
import 'dart:convert';
import 'drawingPointsClass.dart';
import 'drawingPainterClass.dart';
import 'colorCircleWidget.dart';

//enum SelectedMode { StrokeWidth, Opacity, Color }


Widget picassosWidget(double maxHeight, double maxWidth, bool interactive) {
  double xx;
  double yy;

  void checkXY()  {
    if (yy<0) {
      yy=0;
    }
    if (yy>maxHeight) {
      yy=300;
    }
    if (xx<0) {
      xx=0;
    }
    if (xx>maxWidth) {
      xx=300;
    }
  }

  return SizedBox(
    height: maxHeight,
    width: maxWidth,
    child: ClipRect(
      child: interactive
        ?GestureDetector(
          onPanUpdate: (details) {
              xx=details.localPosition.dx;
              yy=details.localPosition.dy;
              checkXY();
              upStream.add(json.encode({'type':'paintingData','content':xx.toString()+";"+yy.toString()}));
          },
          onPanStart: (details) {
              xx=details.localPosition.dx;
              yy=details.localPosition.dy;
              checkXY();
              upStream.add(json.encode({'type':'paintingData','content':xx.toString()+";"+yy.toString()}));
          },
          onPanEnd: (details) {
              upStream.add(json.encode({'type':'paintingData','content':'nullPoint'}));
          },
          child: theCustompaint(),
        )
        :theCustompaint()
    ),
  );
}

Widget theCustompaint() {
  return CustomPaint(
    size: Size.infinite,
    painter: DrawingPainter(
      pointsList: pointList,
    ),
  );
}