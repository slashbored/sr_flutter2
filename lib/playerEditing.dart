import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'webSocket.dart';
import 'playerClass.dart';
import 'roomSelection.dart';

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
                      upStream.add(json.encode({'type':'setName','content':Player.activePlayer.name}));
                      upStream.add(json.encode({'type':'setSex','content':'m'}));
                      Player.activePlayer.sex = 'm';
                    });
                  },
                  backgroundColor: Player.activePlayer!=null&&Player.activePlayer.sex=='m'?getSexcolor(Player.activePlayer.sex):Colors.grey,
                ),
                InputChip(
                  label: Text(S.of(context).sexFemale),
                  onPressed: (){
                    setState(() {
                      upStream.add(json.encode({'type':'setSex','content':'f'}));
                      Player.activePlayer.sex = 'f';
                    });
                  },
                  backgroundColor: Player.activePlayer!=null&&Player.activePlayer.sex=='f'?getSexcolor(Player.activePlayer.sex):Colors.grey,
                ),
                InputChip(
                  label: Text(S.of(context).sexX),
                  onPressed: (){
                    setState(() {
                      upStream.add(json.encode({'type':'setSex','content':'o'}));
                      Player.activePlayer.sex = 'o';
                    });
                  },
                  backgroundColor: Player.activePlayer!=null&&Player.activePlayer.sex=='o'?getSexcolor(Player.activePlayer.sex):Colors.grey,
    ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Player.activePlayer.name = nameTextfieldController.text.toString();
          if  (Player.activePlayer.name!=""&&Player.activePlayer.sex!="") {
            upStream.add(json.encode({'type':'setName','content':Player.activePlayer.name}));
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