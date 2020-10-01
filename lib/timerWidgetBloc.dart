import 'textStyles.dart';
import 'switchEventClass.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sr_flutter2/customTimerClass.dart';
import 'webSocket.dart';
import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'timerWidget.dart';
import 'timerViewDialogWidget.dart';


class TimerWidgetBloc extends Bloc<switchEvent, Container>  {

  @override
  Container get initialState  {
    return Container(
        child: Text(
            "Hi"
        )
    );
  }

  @override
  Stream<Container> mapEventToState(switchEvent event) async*{
    CustomTimer correspondingTimer  = event.timer;
    Player correspondingFirstPlayer  = currentRoom.playerDB.firstWhere((player) =>  player.id == correspondingTimer.playerID);
    Player correspondingSecondPlayer;
    Task correspondingTask      = currentRoom.taskDB.firstWhere((taskPlaceholder) =>  taskPlaceholder.id == correspondingTimer.taskID);
    if (correspondingTimer.secondPlayerID!=null&&correspondingTimer.secondPlayerID!="")  {
      correspondingSecondPlayer  = currentRoom.playerDB.firstWhere((player)  =>  player.id == correspondingTimer.secondPlayerID);
      }
    switch (event.order)  {
      case 'playerNames':
        if (correspondingSecondPlayer!=null)  {
          yield Container(
            child: GestureDetector(
              child: Text(
                correspondingFirstPlayer.name + " & " + correspondingSecondPlayer.name,
                textAlign: TextAlign.center,
                style: normalStyleWhite,
              ),
              onTap: () {
                this.dispatch(switchEvent('taskName',correspondingTimer));
              },
            ),
          );
        }
        else  {
          yield Container(
            child: GestureDetector(
              child: Text(
                correspondingFirstPlayer.name,
                textAlign: TextAlign.center,
                style: normalStyleWhite,
              ),
              onTap: () {
                this.dispatch(switchEvent('taskName',correspondingTimer));
              },
            ),
          );
        }
        break;
      case  'taskName':
        yield Container(
          child: GestureDetector(
            child: Text(
              Task.getStringByLocale(correspondingTask, Localizations.localeOf(taskViewPageContext).toString(), 'timerDescr'),
              textAlign: TextAlign.center,
              style: normalStyleWhite,
            ),
            onTap: () {
              this.dispatch(switchEvent('timeLeft',correspondingTimer));
            },
          )
        );
        break;
      case  'timeLeft':
        yield Container(
          child: GestureDetector(
            child: Text(
              convertTime(correspondingTimer.BGTimeLeft),
              textAlign: TextAlign.center,
              style: normalStyleWhite,
            ),
            onTap: () {
              this.dispatch(switchEvent('playerNames',correspondingTimer));
            },
          )
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

}