import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'generated/i18n.dart';
import 'dart:convert';

import 'webSocket.dart';
import 'roomClass.dart';
import 'playerClass.dart';
import 'taskViewPage.dart';
import 'gameModeSelectionPage.dart';

class roomOverviewPage extends StatefulWidget{
  @override
  roomOverviewPageState createState() => new roomOverviewPageState();
}

class roomOverviewPageState extends State<roomOverviewPage>{

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      body: StreamBuilder(
        stream: downStream,
        builder: (context, snapShot)  {
          return playerListView(context);
        },
      ),
    );
  }

  Widget playerListView(BuildContext context) {
    if (currentRoom!=null) {
      for (int i=0;i<currentRoom.playerDB.length;i++) {
        currentRoom.playerDB[i].color = Player.setPlayerColor(i);
      }
      Player.mePlayer = currentRoom.playerDB.firstWhere((player) => Player.mePlayer.id  ==  player.id);
      return  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Text(
                    Room.activeRoom.id,
                    textAlign: TextAlign.center,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child:  ListView(
                      children: <Widget>[
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: currentRoom.playerDB.length,
                            itemBuilder: (context, int index){
                              return Text(
                                currentRoom.playerDB[index].id==currentRoom.gmID?currentRoom.playerDB[index].name + " 👑":currentRoom.playerDB[index].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: currentRoom.playerDB[index].color
                                ),
                              );
                            }
                        )
                      ]
                  )
                ),
                Flexible(
                  flex: 1,
                  child: startGameFAB(context),
                )
              ]
          );
    }
    else  {
      return Center(
        child: Text(
          S.of(context).noPlayersYet,
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  Widget startGameFAB(BuildContext context)  {
    roomOverviewContext = context;
    if  (currentRoom.gmID==Player.mePlayer.id)  {
      return FloatingActionButton(
        heroTag:'continueToCats',
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: currentRoom!=null&&currentRoom.playerDB.length>1?Colors.green:Colors.grey,
        onPressed: () {
          if  (currentRoom!=null&&currentRoom.playerDB.length>1)  {
            upStream.add(json.encode({'type':'randomTask','content':''}));
            upStream.add(json.encode({'type':'randomPlayers','content':''}));
            upStream.add(json.encode({'type':'setMode','content':'endless'}));
            upStream.add(json.encode({'type':'startGame','content':''}));
          }
          //Navigator.of(context).push(CupertinoPageRoute(builder:  (context) =>  modeSelectionPage()));
        },
      );
    }
    else  {
      return FloatingActionButton(
        heroTag:'continueToCats_waiting',
        child: Icon(Icons.hourglass_empty),
        backgroundColor: Colors.grey,
        onPressed: () {
        },
      );
    }
  }

  void goToTaskViewPage(theContext) async {
    await new Future.delayed(const Duration(milliseconds: 500));
    Navigator.of(theContext).push(CupertinoPageRoute(builder: (context) => taskViewPage()));
  }


}