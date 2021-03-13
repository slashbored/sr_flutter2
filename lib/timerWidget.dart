import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:sr_flutter2/textStyles.dart';
import 'timerWidgetBloc.dart';
import 'switchEventClass.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import'webSocket.dart';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'customTimerClass.dart';

Widget timerWidget(BuildContext context, CustomTimer correspondingTimer) {

  /*TimerWidgetBloc timerWidgetBloc = TimerWidgetBloc(correspondingTimer);
  timerWidgetBloc.add(switchEvent('playerNames',correspondingTimer));*/
  //changeView(correspondingTimer, '');
  Player correspondingFirstPlayer  = currentRoom.playerDB.firstWhere((player) =>  player.id == correspondingTimer.playerID);
  Player correspondingSecondPlayer;
  Task correspondingTask      = currentRoom.taskDB.firstWhere((taskPlaceholder) =>  taskPlaceholder.id == correspondingTimer.taskID);
  if (correspondingTimer.secondPlayerID!=null&&correspondingTimer.secondPlayerID!="")  {
    correspondingSecondPlayer  = currentRoom.playerDB.firstWhere((player)  =>  player.id == correspondingTimer.secondPlayerID);
    }
    /*return Container(
      width: 56,
      height: 56,
      decoration: ShapeDecoration(
        shape: CircleBorder(),
        gradient: LinearGradient(
          colors:[
            correspondingFirstPlayer.color,
            correspondingSecondPlayer.color
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight
        )
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Center(
            child: RichText(
                textAlign: TextAlign.center,
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
                )
            ),
          )
        ),
      ),
    );*/
    /*return InputChip(
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
          )
        ),
        backgroundColor: Colors.black,
      ),
      label: Text(
        customTimer.stateMap[correspondingTimer.id]=='time'?convertTime(correspondingTimer.BGTimeLeft):
        Task.getStringByLocale(correspondingTask, Localizations.localeOf(context).toString(), 'timerDescr'),
        //correspondingTask.descr,
        style: TextStyle(
          color: Colors.white
        )
      ),
      isEnabled: true,
      backgroundColor: Colors.black,
      onPressed: () {
        onPressInputChip(correspondingTimer);
      },
    );*/
  return LinearPercentIndicator(
    lineHeight: 42.0,
    animationDuration: 2000,
    percent: calculatePercent(correspondingTask, correspondingTimer),
    center: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 5,
              child: Text(
                  Task.getStringByLocale(correspondingTask, Localizations.localeOf(context).toString(), 'timerDescr'),
                  textAlign: TextAlign.center,
                  style: tinyStyleWhite
              ),
            ),
            Flexible(
              flex: 2,
              child: Text(
                  convertTime(correspondingTimer.BGTimeLeft),
                  textAlign: TextAlign.right,
                  style: tinyStyleWhite
              ),
            ),
          ],
        ),
      ],
    ),
    linearStrokeCap: LinearStrokeCap.roundAll,
    progressColor: Colors.blue,
    backgroundColor: Colors.green,
  );
}

double calculatePercent(Task taskToGetDurationFrom, CustomTimer timerToCalculateFrom) {
  return timerToCalculateFrom.BGTimeLeft/(taskToGetDurationFrom.duration.toDouble());
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


void onPressInputChip(CustomTimer correspondingTimer) {
  CustomTimer.stateMap[correspondingTimer.id]=='time'?
  changeView(correspondingTimer, 'task'):
  changeView(correspondingTimer, 'time');
}

void changeView(CustomTimer timerToChange, String newView) {
  if  (CustomTimer.stateMap.containsKey(timerToChange.id)==true) {
    String key  = CustomTimer.stateMap.keys.firstWhere((element) => element==timerToChange.id).toString();
    if  (CustomTimer.stateMap[key]==null) {
      CustomTimer.stateMap[key]='time';
    }
    else  {
      switch (newView) {
        case 'time':
          CustomTimer.stateMap[key]='time';
          break;
        case 'task':
          CustomTimer.stateMap[key]='task';
          break;
      }
    }
  }
}