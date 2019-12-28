import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "generated/i18n.dart";
import 'dart:convert';

import'webSocket.dart';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'timerClass.dart';
import 'timerWidget.dart';

Widget taskViewFourthRow(BuildContext context, Room room) {
  //Room.renewActiveTimer(context);
  if(currentRoom.BGTimerDB.length>0) {
    /*Iterable possibleItemCount = currentRoom.BGTimerDB.where((timerPlaceholder)  =>
    (Task.getTaskByID(timerPlaceholder.taskID).typeID ==  3)||(Task.getTaskByID(timerPlaceholder.taskID).typeID ==  6));*/
    return Align(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: currentRoom.BGTimerDB.length,
          itemBuilder: (context, int index) {
            int typeIDplaceholder = Task.getTaskByID(currentRoom.BGTimerDB[index].taskID).typeID;
            print(typeIDplaceholder);
            if(typeIDplaceholder==3||typeIDplaceholder==6)  {
              print("Ok?");
              return timerWidget(context,currentRoom.BGTimerDB[index]);
            }
          }
      ),
      alignment: Alignment.topLeft,
    );
  }
    else  {
      return Container();
  }
}