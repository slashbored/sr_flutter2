import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import'webSocket.dart';

import 'timerWidget.dart';

Widget taskViewFourthRow(BuildContext context) {
  if(currentRoom.BGTimerDB.length>0) {
    return Align(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: currentRoom.BGTimerDB.length,
          itemBuilder: (context, int index) {
            int typeIDplaceholder = currentRoom.taskDB.firstWhere((placeholder) =>  placeholder.id == currentRoom.BGTimerDB[index].taskID).typeID;
            if(typeIDplaceholder==3||typeIDplaceholder==6)  {
              return timerWidget(context,currentRoom.BGTimerDB[index]);
            }
            else  {
              return Container();
            }
          }
      ),
      alignment: Alignment.topLeft
    );
  }
    else  {
      return Container();
  }
}