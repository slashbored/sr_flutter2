import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'playerClass.dart';

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
  bool showBottomList = true;
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  SelectedMode selectedMode = SelectedMode.StrokeWidth;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.black,
    Colors.white
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: currentRoom.activePlayerID==Player.mePlayer.id
            ? [
                Flexible(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: Icon(Icons.album),
                          onPressed: () {
                            setState(() {
                              if (selectedMode == SelectedMode.StrokeWidth)
                                showBottomList == showBottomList;
                              selectedMode = SelectedMode.StrokeWidth;
                            });
                          }),
                      IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              //showBottomList = false;
                              upStream.add(json.encode({'type': 'paintingData', 'content': 'clear'}));
                            });
                          }),
                      IconButton(
                          icon: Icon(Icons.color_lens),
                          onPressed: () {
                            setState(() {
                              if (selectedMode == SelectedMode.Color)
                                showBottomList == showBottomList;
                              selectedMode = SelectedMode.Color;
                            });
                          }),
                    ]
                ),
                fit: FlexFit.tight,
              ),
              picassosWidget(250, 250, true),
              Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Visibility(
                      child: (selectedMode == SelectedMode.Color)
                          ? Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: getColorList(),
                        ),
                      )
                          : RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                            activeColor: Colors.black,
                            inactiveColor: Colors.grey,
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
                      ),
                      visible: showBottomList,
                    )],
                  ),
                  fit: FlexFit.tight
              ),
              ]
            : [
              picassosWidget(250, 250, false)
              ]
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
