import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'webSocket.dart';
import 'playerClass.dart';
import 'roomSelectionPage.dart';

class playerEditing extends StatefulWidget  {
  @override
  playerEditingState createState() => new playerEditingState();
}

class playerEditingState extends State<playerEditing>{
  final TextEditingController nameTextfieldController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameTextfieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    /*WSChannel.stream.asBroadcastStream();
    downStreamController.addStream(WSChannel.stream);
    upStream = WSChannel.sink;
    downStream = downStreamController.stream;
    upStream.add(json.encode({'type':'get','content':'uuid'}));
    upStream.add(json.encode({'type':'ping','content':''}));*/
    startStreaming();

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(S.of(context).comingSoon),
            Row(
              children: <Widget>[
                Spacer(
                  flex: 1
                ),
                Flexible(
                  child:  TextField(
                    controller: nameTextfieldController,
                  ),
                ),
                Spacer(
                  flex: 1
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InputChip(
                  label: Text(S.of(context).sexMale),
                  onPressed: (){
                    setState(() {
                      //upStream.add(json.encode({'type':'setName','content':Player.activePlayer.name}));
                      upStream.add(json.encode({'type':'setSex','content':'m'}));
                      Player.mePlayer.sex = 'm';
                    });
                  },
                  backgroundColor: Player.mePlayer!=null&&Player.mePlayer.sex=='m'?getSexcolor(Player.mePlayer.sex):Colors.grey,
                ),
                InputChip(
                  label: Text(S.of(context).sexFemale),
                  onPressed: (){
                    setState(() {
                      upStream.add(json.encode({'type':'setSex','content':'f'}));
                      Player.mePlayer.sex = 'f';
                    });
                  },
                  backgroundColor: Player.mePlayer!=null&&Player.mePlayer.sex=='f'?getSexcolor(Player.mePlayer.sex):Colors.grey,
                ),
                /*InputChip(
                  label: Text(S.of(context).sexX),
                  onPressed: (){
                    setState(() {
                      upStream.add(json.encode({'type':'setSex','content':'o'}));
                      Player.mePlayer.sex = 'o';
                    });
                  },
                  backgroundColor: Player.mePlayer!=null&&Player.mePlayer.sex=='o'?getSexcolor(Player.mePlayer.sex):Colors.grey,
    ),*/
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Player.mePlayer.name = nameTextfieldController.text.toString();
          if  (Player.mePlayer.name!=""&&Player.mePlayer.sex!="") {
            upStream.add(json.encode({'type':'setName','content':Player.mePlayer.name}));
            Navigator.push(context, CupertinoPageRoute(builder: (context) => roomSelection()));
          }
          else  {
           showDialog(
             context: context,
             builder: (BuildContext context) => CupertinoAlertDialog(
               content: Text(S.of(context).pleaseCompleteEntries)
             )
           );
          }
        },
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: Colors.black,
      ),
    );
  }

  Color getSexcolor(String sex) {
    switch  (sex) {
      case 'm':
        return Colors.blue;
        break;
      case 'f':
        return Colors.red;
        break;
      case 'o':
        return Colors.green;
        break;
    }
  }
}