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
  if(room.BGTimerDB.length>0) {
    return Row(
      children: <Widget>[
        Text(room.BGTimerDB[0].duration)
      ],
    );
  }
    else  {
      return Container();
  }
}