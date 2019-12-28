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
  String timerID  = correspondingTimer.id;
  changeView(correspondingTimer, '');
  return InputChip(
    avatar: CircleAvatar(
      child: Text(
          Room.activeRoom.playerDB.firstWhere((player) =>  player.id == correspondingTimer.playerID).name.substring(0, 1).toUpperCase()
      ),
    ),
    label: Text(
      Timer.stateMap[timerID]=='time'?convertTime(correspondingTimer.BGTimeLeft):
      currentRoom.taskDB.firstWhere((taskPlaceholder) =>  taskPlaceholder.id == correspondingTimer.taskID).descr
    ),
    isEnabled: true,
    backgroundColor: Colors.white,
    onPressed: () {
      Timer.stateMap[timerID]=='time'?
      changeView(correspondingTimer, 'task'):
      changeView(correspondingTimer, 'time');
    },
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
  String convertedTime  = minutes.toString() + ":" + (seconds<10?"0"+seconds.toString():seconds.toString());
  return convertedTime;
}

void changeView(Timer timerToChange, String newView) {
  if  (Timer.stateMap.containsKey(timerToChange.id)==true) {
    var key  = Timer.stateMap.keys.firstWhere((element) => element==timerToChange.id).toString();
    if  (Timer.stateMap[key]==null) {
      Timer.stateMap[key]='time';
    }
    else  {
      switch (newView) {
        case 'time':
          Timer.stateMap[key]='time';
          break;
        case 'task':
          Timer.stateMap[key]='task';
          break;
      }
    }
  }
}