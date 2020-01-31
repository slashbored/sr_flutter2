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
                  label: Text(S.of(context).createRoom),
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
                  label: Text(S.of(context).joinRoom),
                  onPressed: () {
                    upStream.add(json.encode({'type':'joinRoom','content':joinroomTextfieldController.text.toString()}));
                    joinRoom();
                    },
                ),
              ]
            )
          );
        }
      )
    );
  }

  void joinRoom() async{
    while (currentRoom==null){
      await new Future.delayed(const Duration(milliseconds: 100));
    }
    Room.activeRoom!=null?Navigator.push(context, CupertinoPageRoute(builder: (context) => roomOverviewPage())):null;
  }
}