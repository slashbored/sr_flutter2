import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import'webSocket.dart';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'timerClass.dart';

Widget timerWidget(BuildContext context, Timer correspondingTimer) {
  Player correspondingPlayer  = Room.activeRoom.playerDB.firstWhere((player) =>  player.id == correspondingTimer.playerID);
  Task correspondingTask      = currentRoom.taskDB.firstWhere((taskPlaceholder) =>  taskPlaceholder.id == correspondingTimer.taskID);
  changeView(correspondingTimer, '');
  return InputChip(
    avatar: CircleAvatar(
      child: Text(
          correspondingPlayer.name.substring(0, 1).toUpperCase()
      ),
      backgroundColor: correspondingPlayer.color,
    ),
    label: Text(
      Timer.stateMap[correspondingTimer.id]=='time'?convertTime(correspondingTimer.BGTimeLeft):
      correspondingTask.descr
    ),
    isEnabled: true,
    backgroundColor: correspondingPlayer.color,
    onPressed: () {
      Timer.stateMap[correspondingTimer.id]=='time'?
      changeView(correspondingTimer, 'task'):
      changeView(correspondingTimer, 'time');
    },
  );
}


String convertTime(int timeToConvert) {
  String convertedTime;
  int minutes = timeToConvert ~/ 60;
  int seconds;
  if  (timeToConvert>60)  {
    seconds=timeToConvert-minutes*60;
  }
  else  {
    seconds=timeToConvert;
  }
  convertedTime  = minutes.toString() + ":" + (seconds<10?"0"+seconds.toString():seconds.toString());
  return convertedTime;
}

void changeView(Timer timerToChange, String newView) {
  if  (Timer.stateMap.containsKey(timerToChange.id)==true) {
    String key  = Timer.stateMap.keys.firstWhere((element) => element==timerToChange.id).toString();
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