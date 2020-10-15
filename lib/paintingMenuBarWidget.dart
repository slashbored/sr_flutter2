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

class paintingMenuBarWidget extends StatefulWidget {
  @override
  paintingMenuBarWidgetState createState() => paintingMenuBarWidgetState();
}

class paintingMenuBarWidgetState extends State<paintingMenuBarWidget> {
  bool showBottomList = false;
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
    return Container(
        child: Padding(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.album),
                                    onPressed: () {
                                      setState(() {
                                        if (selectedMode ==
                                            SelectedMode.StrokeWidth)
                                          showBottomList = !showBottomList;
                                        selectedMode = SelectedMode.StrokeWidth;
                                      });
                                    }),
                                IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        showBottomList = false;
                                        upStream.add(json.encode({
                                          'type': 'paintingData',
                                          'content': 'clear'
                                        }));
                                      });
                                    }),
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
                                value: strokeWidth,
                                max: 50,
                                min: 1.0,
                                onChanged: (val) {
                                  setState(() {
                                    if (selectedMode ==
                                        SelectedMode.StrokeWidth) {
                                      upStream.add(json.encode({
                                        'type': 'paintingWidth',
                                        'content': val.toString()
                                      }));
                                    }
                                  });
                                }),
                            visible: showBottomList,
                          )
                        ]
                    )
                )
            )
        )
    );
  }

  getColorList() {
    List<Widget> listWidget = List();
    for (Color colorPlaceholder in colors) {
      listWidget.add(colorCircle(colorPlaceholder));
    }
    return listWidget;
  }
}
enum SelectedMode { StrokeWidth, Color }
