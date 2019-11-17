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

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      body: StreamBuilder(
        stream: downStream,
        builder:  (context, snapShot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: taskStringText(context),
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
            ),
          );
        }
      ),
    );
  }

  Widget taskStringText(BuildContext context) {
    if  (Room.activeRoom != null && Room.activeRoom.activeTaskID != null &&
        Room.activeRoom.activePlayerID != null) {
      int taskIDindex = Room.activeRoom.taskDB.indexWhere((test) =>
      test.id == Room.activeRoom.activeTaskID);
      if  (Room.activeRoom.taskDB[taskIDindex].typeID == 9 ||
          Room.activeRoom.taskDB[taskIDindex].typeID == 10) {
        if  (Room.activeRoom.activePlayerID==Player.mePlayer.id) {
          return Text("Taboo or pantomime!");
        }
        else  {
          return Text("🤐");
        }
      }
      else  {
        return Text("Something else");
      }
    }
    else  {
      return Text("");
    }
  }
}