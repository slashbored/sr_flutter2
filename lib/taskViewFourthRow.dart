import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "generated/i18n.dart";
import 'dart:convert';

import'webSocket.dart';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'timerClass.dart';

Widget taskViewFourthRow(BuildContext context, Room room) {
  //print("Redrawn! v2");
  if(currentRoom.BGTimerDB.length>0) {
    //print(room.BGTimerDB[0].BGTimeLeft.toString());
    return Row(
      children: <Widget>[
        Text(currentRoom.BGTimerDB[0].BGTimeLeft.toString())
      ],
    );
  }
    else  {
      return Container();
  }
}