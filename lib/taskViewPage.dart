import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/taskViewFirstRow.dart';
import 'package:sr_flutter2/taskViewFourthRow.dart';
import 'package:sr_flutter2/taskViewSecondRow.dart';
import 'package:sr_flutter2/taskViewThirdRow.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'package:sr_flutter2/generated/i18n.dart';
import 'dart:convert';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';


class taskViewPage extends StatefulWidget{
  @override
  taskViewPageState createState() => new taskViewPageState();
}

class taskViewPageState extends State<taskViewPage>{

  Room currentRoom;
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
      currentRoom   = Room.activeRoom;
      currentTask   = Task.getTaskByID(currentRoom.activeTaskID);
      currentPlayer = Player.getPlayerByID(currentRoom.activePlayerID);
      if  (currentRoom.activeSecondPlayerID!=null)  {
        currentSecondPlayer = Player.getPlayerByID(currentRoom.activeSecondPlayerID);
      }
        return Scaffold(
          body: StreamBuilder(
              stream: downStream,
              builder:  (context, snapShot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Expanded(
                      child: taskViewFirstRow(context, currentPlayer, currentSecondPlayer, currentTask),
                      flex: 325
                    ),
                    new Expanded(
                      child: taskViewSecondRow(context, currentPlayer, currentSecondPlayer, currentTask),
                      flex: 325
                    ),
                    new Expanded(
                      child: taskViewThirdRow(context, currentPlayer, currentSecondPlayer, currentTask),
                      flex: 325
                    ),
                    new Expanded(
                      child: taskViewFourthRow(context, currentPlayer, currentSecondPlayer, currentTask),
                      flex: 25
                    )
                  ],
                );
                /*return Center(
            child: taskStringColumn(context)
          );*/
              }
          ),
        );

    }
    else  {
      return Text("Something went HORRIBLY wrong!");
    }
  }

  bool isWorkingAtAll() {
    if(Room.activeRoom != null && Room.activeRoom.activeTaskID != null &&
        Room.activeRoom.activePlayerID != null) {
      return true;
    }
    else  {
      return false;
    }
  }


  void nextTaskOnThisPage(theContext) async {
    await new Future.delayed(const Duration(milliseconds: 500));
    //Navigator.push(context, CupertinoPageRoute(builder: (context) => taskViewPage()));
    Navigator.of(theContext).push(CupertinoPageRoute(builder: (context) => taskViewPage()));
  }

/*Widget taskStringColumn(BuildContext context) {
    if  (isWorkingAtAll()) { //does it work?
      currentRoom   = Room.activeRoom;
      currentTask   = Task.getTaskByID(currentRoom.activeTaskID);
      currentPlayer = Player.getPlayerByID(currentRoom.activePlayerID);
      if(isPantoOrTaboo(currentTask)) {
        if  (currentPlayer.id==Player.mePlayer.id) { // is activeplayer me?
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text(currentTask.nString_en),
              ),
              FloatingActionButton.extended(
                  heroTag:'RANDOM',
                  label: Text('RANDOM!'),
                  onPressed: () {
                    upStream.add(json.encode({'type':'randomPlayer','content':''}));
                    upStream.add(json.encode({'type':'randomTask','content':''}));
                  }
              )
            ],
          );
        }
        else  {
          return Text("🤐",
            style: TextStyle(
              fontSize:90
            ),);
        }
      }
      else  {
        if  (currentPlayer.id==Player.mePlayer.id)  {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text("Something else"),
              )
              /*FloatingActionButton.extended(
                heroTag:'RANDOM',
                label: Text('RANDOM!'),
                onPressed: () {
                  upStream.add(json.encode({'type':'randomPlayer','content':''}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                }
            )*/
            ],
          );
        }
        else  {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text("Something else"),
              ),
              FloatingActionButton.extended(
                heroTag:'RANDOM',
                label: Text('RANDOM!'),
                onPressed: () {
                  upStream.add(json.encode({'type':'randomPlayer','content':''}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                }
            )
            ],
          );
        }
      }
    }
    else  {
      return Text("Something went HORRIBLY wrong!");
    }
  }

  bool isChoice(Task taskplaceholder) {
    if  ( taskplaceholder.typeID == 4 || //4,5,6 are choicetasks
          taskplaceholder.typeID == 5 ||
          taskplaceholder.typeID == 6) {
      return true;
    }
    else  {
      return false;
    }
  }

  bool isPantoOrTaboo(Task taskplaceholder) {
    if  ( taskplaceholder.typeID == 9 || //9 Panto, 10 Taboo
          taskplaceholder.typeID == 10) {
      return true;
    }
    else  {
      return false;
    }
  }*/

}