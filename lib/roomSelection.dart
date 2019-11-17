import 'package:flutter/material.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'generated/i18n.dart';
import 'dart:convert';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';

class roomSelection extends StatefulWidget{
  @override
  roomSelectionState createState() => new roomSelectionState();
}

class roomSelectionState extends State<roomSelection>{


  final TextEditingController nameTextfieldController = TextEditingController();
  final TextEditingController joinroomTextfieldController = TextEditingController();
  final TextEditingController addToChatTextfieldController = TextEditingController();

  @override
  void initState()  {
    super.initState();
  }

  @override
  void dispose() {
    nameTextfieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: downStream,
        builder: (context, snapShot){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton.extended(
                  heroTag:'createRoom',
                  label: Text('Create a room'),
                  onPressed: () {
                    upStream.add(json.encode({'type':'createRoom','content':''}));
                    //upStream.add(json.encode({'type':'get','content':'roomList'}));
                  },
                ),
                Flexible(
                  child: TextField(
                    controller: joinroomTextfieldController
                  )
                ),
                FloatingActionButton.extended(
                  heroTag:'joinRoom',
                  label: Text('Join room'),
                  onPressed: () {
                    upStream.add(json.encode({'type':'joinRoom','content':joinroomTextfieldController.text.toString()}));
                  },
                ),
                playerListView(context),
                Flexible(
                  child: TextField(
                    controller: addToChatTextfieldController
                  )
                ),
                FloatingActionButton.extended(
                  heroTag:'enterChat',
                  label: Text('Add to chat'),
                  onPressed: () {
                    upStream.add(json.encode({'type':'addToChat','content':addToChatTextfieldController.text.toString()}));
                  }
                ),
                chatListView(context),
                /*FloatingActionButton.extended(
                    heroTag:'randomTask',
                    label: Text('Random task'),
                    onPressed: () {
                      upStream.add(json.encode({'type':'randomTask','content':''}));
                    }
                ),
                FloatingActionButton.extended(
                    heroTag:'randomPlayer',
                    label: Text('random player'),
                    onPressed: () {
                      upStream.add(json.encode({'type':'randomPlayer','content':''}));
                    }
                ),*/
                FloatingActionButton.extended(
                    heroTag:'RANDOM',
                    label: Text('RANDOM!'),
                    onPressed: () {
                      upStream.add(json.encode({'type':'randomPlayer','content':''}));
                      upStream.add(json.encode({'type':'randomTask','content':''}));
                    }
                ),
                /*Flexible(
                  child: Text(
                    Room.activeRoom!=null&&Room.activeRoom.activeTaskID!=null?Room.activeRoom.activeTaskID.toString():""
                  ),
                )*/
                Flexible(
                  child: taskStringText(context),
                )
              ]
            )
          );
        }
      )
    );
  }


  Widget playerListView(BuildContext context) {
    if (Room.activeRoom!=null) {
      return  Flexible(
        child: Column(
          children: <Widget>[
            Text(
              Room.activeRoom.id,
              textAlign: TextAlign.center,
            ),
            Flexible(
              child:  ListView(
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: Room.activeRoom.playerDB.length,
                    itemBuilder: (context, int index){
                      return Text(
                        Room.activeRoom.playerDB[index].id==Room.activeRoom.gmID?Room.activeRoom.playerDB[index].name + " 👑":Room.activeRoom.playerDB[index].name,
                        textAlign: TextAlign.center,
                      );
                    }
                  )
                ]
              )
            )
          ]
        )
      );
    }
    else  {
      return Text(S.of(context).noPlayersYet);
    }
  }

  Widget chatListView(BuildContext context) {
    if (Room.activeRoom!=null) {
      return  Flexible(
        child: ListView(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              itemCount: Room.activeRoom.chatDB.length,
              itemBuilder: (context, int index){
                return Text(
                  Room.activeRoom.chatDB[index],
                  textAlign: TextAlign.start,
                );
              }
            )
          ]
        )
      );
    }
    else  {
      return Text("");
    }
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