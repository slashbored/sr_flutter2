import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'generated/i18n.dart';
import 'dart:convert';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'taskViewPage.dart';

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
                /*FloatingActionButton(
                  heroTag:'continueToCats',
                  child: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                  },
                )*/
                continueToCatsFAB(context)
              ]
          );
    }
    else  {
      return Text(S.of(context).noPlayersYet);
    }
  }

  Widget continueToCatsFAB(BuildContext context)  {
    return FloatingActionButton(
      heroTag:'continueToCats',
      child: Icon(Icons.arrow_forward_ios),
      backgroundColor: Room.activeRoom!=null&&Room.activeRoom.playerDB.length>1?Colors.green:Colors.grey,
      onPressed: () {
        Room.activeRoom!=null&&Room.activeRoom.playerDB.length>1?Navigator.push(context, CupertinoPageRoute(builder: (context) => taskViewPage())):null;
      },
    );
  }
}