import 'package:flutter/material.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'generated/i18n.dart';
import 'dart:convert';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';

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
    if (Room.activeRoom!=null) {
      return  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Text(
                    Room.activeRoom.id,
                    textAlign: TextAlign.center,
                  )
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
                ),
                FloatingActionButton(
                  heroTag:'continueToCats',
                  child: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                  },
                )
              ]
          );
    }
    else  {
      return Text(S.of(context).noPlayersYet);
    }
  }
}