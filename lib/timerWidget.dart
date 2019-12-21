import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "generated/i18n.dart";
import 'dart:convert';

import'webSocket.dart';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'timerClass.dart';

Widget timerWidget(BuildContext context, Timer correspondingTimer) {
  return InputChip(
    avatar: CircleAvatar(
      child: Text(
          Player.getPlayerByID(correspondingTimer.playerID).name.substring(0, 1).toUpperCase()
      ),
    ),
    label: Text(
        convertTime(correspondingTimer.BGTimeLeft),
    ),
    isEnabled: true,
    backgroundColor: Colors.white,
    onPressed: () {},
  );
}


String convertTime(int timeToConvert) {
  int minutes = timeToConvert ~/ 60;
  int seconds;
  if  (timeToConvert>60)  {
    seconds=timeToConvert-minutes*60;
  }
  else  {
    seconds=timeToConvert;
  }
  //timeToConvert>60?seconds=timeToConvert-minutes*60:seconds=timeToConvert;
  String convertedTime  = minutes.toString() + ":" + (seconds<10?"0"+seconds.toString():seconds.toString());
  return convertedTime;
}