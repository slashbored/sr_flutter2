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
    if (currentRoom.taskDB
        .firstWhere((task) => task.id == currentRoom.activeTaskID)
        .typeID == 7) {                                             //comparison
      if (currentRoom.winnerIDArray != null) {
        if (currentRoom.winnerIDArray.any((player) =>
        player.id == Player.mePlayer.id)) {
          return Center(
            child: Text(
              Task.getStringByLocale(
                  currentRoom.taskDB.firstWhere((task) => task.id ==
                      currentRoom.activeTaskID), locale, 'compare_win'),
              textAlign: TextAlign.center,
            ),
          );
        }
        else {
          return Center(
            child: Text(
              Task.getStringByLocale(
                  currentRoom.taskDB.firstWhere((task) => task.id ==
                      currentRoom.activeTaskID), locale, 'compare_loose'),
              textAlign: TextAlign.center,
            ),
          );
        }
      }
    }
    if (currentRoom.taskDB
        .firstWhere((task) => task.id == currentRoom.activeTaskID)
        .typeID == 11) {                                          //would you rather
        switch (currentRoom.compareWinnerSide)  {
          case 0:
            return Center(
              child: Text(
                S.of(context).comparisonDraw,
                textAlign: TextAlign.center,
              ),
            );
            break;
          case 1:
            if (Player.mePlayer.compareValue==currentRoom.compareWinnerSide)  {
              return Center(
                child: Text(
                  Task.getStringByLocale(
                      currentRoom.taskDB.firstWhere((task) => task.id ==
                          currentRoom.activeTaskID), locale, 'wyr_a_won'),
                  textAlign: TextAlign.center,
                ),
              );
            }
            else  {
              return Center(
                child: Text(
                  Task.getStringByLocale(
                      currentRoom.taskDB.firstWhere((task) => task.id ==
                          currentRoom.activeTaskID), locale, 'wyr_a_lost'),
                  textAlign: TextAlign.center,
                ),
              );
            }
            break;
          case 2:
            if (Player.mePlayer.compareValue==currentRoom.compareWinnerSide)  {
              return Center(
                child: Text(
                  Task.getStringByLocale(
                      currentRoom.taskDB.firstWhere((task) => task.id ==
                          currentRoom.activeTaskID), locale, 'wyr_b_won'),
                  textAlign: TextAlign.center,
                ),
              );
            }
            else  {
              return Center(
                child: Text(
                  Task.getStringByLocale(
                      currentRoom.taskDB.firstWhere((task) => task.id ==
                          currentRoom.activeTaskID), locale, 'wyr_b_lost'),
                  textAlign: TextAlign.center,
                ),
              );
            }
            break;
        }
    }
  }
  else  {
    return Center(
      child: Text(S.of(context).waitingForOthersToInput),
    );
  }
}