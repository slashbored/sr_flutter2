import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/taskViewFourthRow.dart';
import 'generated/i18n.dart';

import 'playerClass.dart';
import 'roomClass.dart';
import 'taskClass.dart';
import 'package:sr_flutter2/betweenViewBody.dart';
import 'package:sr_flutter2/betweenViewButton.dart';
import 'package:sr_flutter2/webSocket.dart';

Widget betweenViewBody(BuildContext context){
  String locale = Localizations.localeOf(context).toString();
  if (currentRoom.isWaiting==false) {
    if (currentRoom.winnerIDArray!=null)  {
      if (currentRoom.winnerIDArray.any((player)  =>  player.id == Player.mePlayer.id)) {
        return Center(
          child: Text(
            Task.getStringByLocale(currentRoom.taskDB.firstWhere((task) =>  task.id == currentRoom.activeTaskID), locale, 'compare_win'),
            textAlign: TextAlign.center,
          ),
        );
      }
      else  {
        return Center(
          child: Text(
            Task.getStringByLocale(currentRoom.taskDB.firstWhere((task) =>  task.id == currentRoom.activeTaskID), locale, 'compare_loose'),
            textAlign: TextAlign.center,
          ),
        );
      }
    }
  }
  else  {
    return Center(
      child: Text(S.of(context).waitingForOthersToInput),
    );
  }
}