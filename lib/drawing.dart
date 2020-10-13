import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'webSocket.dart';
import 'dart:convert';
import 'drawingPointsClass.dart';


class Draw extends StatefulWidget {
  @override
  DrawState createState() => DrawState();
}

class DrawState extends State<Draw> {
  Color selectedColor = Colors.black;
  Color pickerColor = Colors.black;
  double strokeWidth = 3.0;
  static List<DrawingPoints> points = List();
  bool showBottomList = false;
  double opacity = 1.0;
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  SelectedMode selectedMode = SelectedMode.StrokeWidth;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.black,
    Colors.white
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: downStream,
      builder: (context, snapShot)  {
        return Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.grey),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.album),
                              onPressed: () {
                                setState(() {
                                  if (selectedMode == SelectedMode.StrokeWidth)
                                    showBottomList = !showBottomList;
                                  selectedMode = SelectedMode.StrokeWidth;
                                });
                              }),
                          IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  showBottomList = false;
                                  pointList.clear();
                                });
                              }),
                          /*IconButton(
                          icon: Icon(Icons.opacity),
                          onPressed: () {
                            setState(() {
                              if (selectedMode == SelectedMode.Opacity)
                                showBottomList = !showBottomList;
                              selectedMode = SelectedMode.Opacity;
                            });
                          }),*/
                          IconButton(
                              icon: Icon(Icons.color_lens),
                              onPressed: () {
                                setState(() {
                                  if (selectedMode == SelectedMode.Color)
                                    showBottomList = !showBottomList;
                                  selectedMode = SelectedMode.Color;
                                });
                              }),

                        ]
                      ),
                      Visibility(
                        child: (selectedMode == SelectedMode.Color)
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: getColorList(),
                        )
                            : Slider(
                            value: (selectedMode == SelectedMode.StrokeWidth)
                                ? strokeWidth
                                : opacity,
                            max: (selectedMode == SelectedMode.StrokeWidth)
                                ? 50.0
                                : 1.0,
                            min: 0.0,
                            onChanged: (val) {
                              setState(() {
                                if (selectedMode == SelectedMode.StrokeWidth)
                                {strokeWidth = val;
                                  //upStream.add(json.encode({'type':'paintingStrokeWidth','content':val.toString()}));
                                }
                                else
                                {opacity = val;
                                  //upStream.add(json.encode({'type':'paintingOpacity','content':val.toString()}));
                                }
                              });
                            }),
                        visible: showBottomList,
                      ),
                    ],
                  ),
                )),
          ),
          body: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject();
                /*points.add(DrawingPoints(
                points: renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = selectedColor.withOpacity(opacity)
                  ..strokeWidth = strokeWidth)
            );*/
                upStream.add(json.encode({'type':'paintingOffsetsAdd','content':renderBox.globalToLocal(details.globalPosition).dx.toString()+";"+renderBox.globalToLocal(details.globalPosition).dy.toString()}));
                //print(renderBox.globalToLocal(details.globalPosition).dx.toString() + ";" + renderBox.globalToLocal(details.globalPosition).dy.toString());
              });
            },
            onPanStart: (details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject();
                /*points.add(DrawingPoints(
                points: renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = selectedColor.withOpacity(opacity)
                  ..strokeWidth = strokeWidth));*/
                upStream.add(json.encode({'type':'paintingOffsetsAdd','content':renderBox.globalToLocal(details.globalPosition).dx.toString()+";"+renderBox.globalToLocal(details.globalPosition).dy.toString()}));
                //print(renderBox.globalToLocal(details.globalPosition).dx.toString() + ";" + renderBox.globalToLocal(details.globalPosition).dy.toString());
              });
            },
            onPanEnd: (details) {
              setState(() {
                upStream.add(json.encode({'type':'paintingOffsetsAdd','content':'0;0'}));
              });
            },
            child: CustomPaint(
              size: Size.infinite,
              painter: DrawingPainter(
                pointsList: pointList,
              ),
            ),
          ),
        );
      },
    );
  }

  getColorList() {
    List<Widget> listWidget = List();
    for (Color color in colors) {
      listWidget.add(colorCircle(color));
    }
    /*Widget colorPicker = GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          child: AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: pickerColor,
                onColorChanged: (color) {
                  pickerColor = color;
                },
                showLabel: true,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('Save'),
                onPressed: () {
                  setState(() => selectedColor = pickerColor);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          height: 36,
          width: 36,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.green, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
        ),
      ),
    );
    //listWidget.add(colorPicker);*/
    return listWidget;
  }

  Widget colorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
          upStream.add(json.encode({'type':'color','content':color.toString()}));
        });
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          height: 36,
          width: 36,
          color: color,
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  DrawingPainter({this.pointsList});
  List<DrawingPoints> pointsList;
  List<Offset> offsetPoints = List();
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(
            pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));
        canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

enum SelectedMode { StrokeWidth, Opacity, Color }
