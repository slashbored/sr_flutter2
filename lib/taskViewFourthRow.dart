import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import'webSocket.dart';

import 'roomClass.dart';
import 'timerWidget.dart';

Widget taskViewFourthRow(BuildContext context, /*Room room*/) {
  if(currentRoom.BGTimerDB.length>0) {
    return Align(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: currentRoom.BGTimerDB.length,
          itemBuilder: (context, int index) {
            int typeIDplaceholder = currentRoom.taskDB.firstWhere((placeholder) =>  placeholder.id == currentRoom.BGTimerDB[index].taskID).typeID;
            //int typeIDplaceholder = Task.getTaskByID(currentRoom.BGTimerDB[index].taskID).typeID;
            if(typeIDplaceholder==3||typeIDplaceholder==6)  {
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