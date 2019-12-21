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
  Room.renewActiveTimer(context);
  if(currentRoom.BGTimerDB.length>0) {
    return Align(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: currentRoom.BGTimerDB.length,
          itemBuilder: (context, int index) {
            int typeIDplaceholder = Task.getTaskByID(currentRoom.BGTimerDB[index].taskID).typeID;
            if(typeIDplaceholder==3||typeIDplaceholder==6)  {
              /*print("\nItemcount: " + currentRoom.BGTimerDB.length.toString() +
                    "\nTimerID: " + currentRoom.BGTimerDB[index].id.toString() +
                    "\nTime left:" + currentRoom.BGTimerDB[index].BGTimeLeft.toString());*/
              //print(currentRoom.BGTimerDB[index].BGTimeLeft.toString());
              return timerWidget(context,currentRoom.BGTimerDB[index]);
              /*return new Text(
            currentRoom.BGTimerDB[index].BGTimeLeft.toString(),
            textAlign: TextAlign.center,
          );*/
            }
            else {
              return Text(
                  "Somethings wrong here..."
              );
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