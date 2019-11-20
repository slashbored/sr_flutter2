import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'generated/i18n.dart';
import 'dart:convert';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';


class taskViewPage extends StatefulWidget{
  @override
  taskViewPageState createState() => new taskViewPageState();
}

class taskViewPageState extends State<taskViewPage>{

  Task currentTask;

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      body: StreamBuilder(
        stream: downStream,
        builder:  (context, snapShot) {
          return Center(
            child: taskStringColumn(context)
          );
        }
      ),
    );
  }

  Widget taskStringColumn(BuildContext context) {
    if  (Room.activeRoom != null && Room.activeRoom.activeTaskID != null &&
        Room.activeRoom.activePlayerID != null) { //does it work?
      currentTask = Task.getTaskByID(Room.activeRoom.activeTaskID);
      if(pantoOrTaboo(currentTask)) {
        if  (Room.activeRoom.activePlayerID==Player.mePlayer.id) { // is activeplayer me?
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
        if  (Room.activeRoom.activePlayerID==Player.mePlayer.id)  {
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
      return Text("Something went wrong!");
    }
  }

  bool pantoOrTaboo(Task taskplaceholder) {
    if  (taskplaceholder.typeID == 9 || //9 Panto, 10 Taboo
        taskplaceholder.typeID == 10) {
      return true;
    }
    else  {
      return false;
    }
  }

}