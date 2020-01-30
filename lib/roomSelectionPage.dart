import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'generated/i18n.dart';
import 'dart:convert';

import 'webSocket.dart';
import 'roomClass.dart';
import 'roomOverviewPage.dart';
import 'playerClass.dart';

class roomSelection extends StatefulWidget{
  @override
  roomSelectionPage createState() => new roomSelectionPage();
}

class roomSelectionPage extends State<roomSelection>{

  final TextEditingController joinroomTextfieldController = TextEditingController();

  @override
  void initState()  {
    super.initState();
  }

  @override
  void dispose() {
    joinroomTextfieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    roomSelectionContext = context;
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
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => roomOverviewPage()));
                  },
                ),
                Flexible(
                  child: TextField(
                    controller: joinroomTextfieldController,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                        signed: false
                    ),
                  )
                ),
                FloatingActionButton.extended(
                  heroTag:'joinRoom',
                  label: Text('Join room'),
                  onPressed: () {
                    upStream.add(json.encode({'type':'joinRoom','content':joinroomTextfieldController.text.toString()}));
                    joinRoom();
                    },
                ),
                /*Flexible(
                  child: taskStringText(context),
                )*/
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

  void joinRoom() async{
    while (currentRoom==null){
      await new Future.delayed(const Duration(milliseconds: 100));
    }
    Room.activeRoom!=null?Navigator.push(context, CupertinoPageRoute(builder: (context) => roomOverviewPage())):null;
  }
}