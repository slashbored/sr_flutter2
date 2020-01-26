import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/taskViewFirstRow.dart';
import 'package:sr_flutter2/taskViewFourthRow.dart';
import 'package:sr_flutter2/taskViewSecondRow.dart';
import 'package:sr_flutter2/taskViewThirdRow.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';


class taskViewPage extends StatefulWidget{
  @override
  taskViewPageState createState() => new taskViewPageState();
}

class taskViewPageState extends State<taskViewPage>{

  Task currentTask;
  Player currentPlayer;
  Player currentSecondPlayer;

  @override
  Widget build(BuildContext context)  {
    return mainBody(context);
  }

  Widget mainBody(BuildContext context)  {
    taskOverviewContext = context;
    if  (isWorkingAtAll()) {
      currentTask   = currentRoom.taskDB.firstWhere((taskPlaceholder) =>  taskPlaceholder.id == currentRoom.activeTaskID);
      currentPlayer = Room.activeRoom.playerDB.firstWhere((player) =>  player.id == currentRoom.activePlayerID);
      if  (currentRoom.activeSecondPlayerID!=null)  {
        currentSecondPlayer = Room.activeRoom.playerDB.firstWhere((player) =>  player.id == currentRoom.activeSecondPlayerID);
      }
      return WillPopScope(
        onWillPop: () =>  null,
        child: Scaffold(
          body: StreamBuilder(
              stream: downStream,
              builder:  (context, snapShot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Expanded(
                        child: taskViewFirstRow(context, currentPlayer, currentSecondPlayer, currentTask),
                        flex: 315
                    ),
                    new Expanded(
                        child: taskViewSecondRow(context, currentPlayer, currentSecondPlayer, currentTask),
                        flex: 315
                    ),
                    new Expanded(
                        child: taskViewThirdRow(context, currentPlayer, currentSecondPlayer, currentTask),
                        flex: 315
                    ),
                    new Expanded(
                        child: taskViewFourthRow(context),
                        flex: 55
                    )
                  ],
                );
              }
          ),
        )
      );
    }
    else  {
      return Text("Something went HORRIBLY wrong!");
    }
  }

  bool isWorkingAtAll() {

    print(currentRoom.activeTaskID);
    print(currentRoom.activePlayerID);
    print(currentRoom.activeSecondPlayerID);
    if(currentRoom != null && currentRoom.activeTaskID != null &&
        currentRoom.activePlayerID != null) {
      return true;
    }
    else  {
      return false;
    }
  }


  void nextTaskOnThisPage(theContext) async {
    await new Future.delayed(const Duration(milliseconds: 50));
    //Navigator.push(context, CupertinoPageRoute(builder: (context) => taskViewPage()));
    Navigator.of(theContext).push(CupertinoPageRoute(builder: (context) => taskViewPage()));
  }
}