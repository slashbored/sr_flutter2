import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import'webSocket.dart';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'timerClass.dart';

Widget timerWidget(BuildContext context, Timer correspondingTimer) {
  changeView(correspondingTimer, '');
  Player correspondingFirstPlayer  = Room.activeRoom.playerDB.firstWhere((player) =>  player.id == correspondingTimer.playerID);
  Player correspondingSecondPlayer;
  Task correspondingTask      = currentRoom.taskDB.firstWhere((taskPlaceholder) =>  taskPlaceholder.id == correspondingTimer.taskID);
  if (correspondingTimer.secondPlayerID!=null)  {
    correspondingSecondPlayer  = Room.activeRoom.playerDB.firstWhere((player)  =>  player.id == correspondingTimer.secondPlayerID);
    return InputChip(
      avatar: CircleAvatar(
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: correspondingFirstPlayer.name.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: correspondingFirstPlayer.color
                )
              ),
              TextSpan(
                  text: correspondingSecondPlayer.name.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      color: correspondingSecondPlayer.color
                  )
              )
            ]
          ),
        ),
        backgroundColor: Colors.black,
      ),
      label: Text(
        Timer.stateMap[correspondingTimer.id]=='time'?convertTime(correspondingTimer.BGTimeLeft):
        Task.getStringByLocale(correspondingTask, Localizations.localeOf(context).toString(), 'timerDescr'),
        //correspondingTask.descr,
        style: TextStyle(
          color: Colors.white
        ),
      ),
      isEnabled: true,
      backgroundColor: Colors.black,
      onPressed: () {
        onPressInputChip(correspondingTimer);
      },
    );
  }
  else  {
    return InputChip(
      avatar: CircleAvatar(
        child: Text(
            correspondingFirstPlayer.name.substring(0, 1).toUpperCase()
        ),
        backgroundColor: correspondingFirstPlayer.color,
      ),
      label: Text(
          Timer.stateMap[correspondingTimer.id]=='time'?convertTime(correspondingTimer.BGTimeLeft):
          Task.getStringByLocale(correspondingTask, Localizations.localeOf(context).toString(), 'timerDescr')
          //correspondingTask.descr
      ),
      isEnabled: true,
      backgroundColor: correspondingFirstPlayer.color,
      onPressed: () {
        onPressInputChip(correspondingTimer);
      },
    );
  }
}


String convertTime(int timeToConvert) {
  int minutes = timeToConvert ~/ 60;
  int seconds;
  if  (timeToConvert>60)  {
    seconds=timeToConvert-minutes*60;
    seconds==60?seconds=0:seconds=seconds;
  }
  else  {
    seconds=timeToConvert;
  }
  return minutes.toString() + ":" + (seconds<10?"0"+seconds.toString():seconds.toString());
}


void onPressInputChip(Timer correspondingTimer) {
  Timer.stateMap[correspondingTimer.id]=='time'?
  changeView(correspondingTimer, 'task'):
  changeView(correspondingTimer, 'time');
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