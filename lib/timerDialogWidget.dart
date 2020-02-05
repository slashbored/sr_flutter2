import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'generated/i18n.dart';
import 'webSocket.dart';
import 'timerWidget.dart';
import 'customTimerClass.dart';
import 'playerClass.dart';
import 'package:quiver/collection.dart';
import 'package:quiver/collection.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'localizationBloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

bool timerMenuOpen  = false;

Widget timerDialog(BuildContext context)  {
  Set singlePlayerBGTimerDBSet = countSinglePlayerTimersInBGTimerDB();
  return StreamBuilder(
    stream: downStream,
    builder: (context, snapShot)  {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        title: Text(
          S.of(context).timerDialog_title,
          textAlign: TextAlign.center,
          style: normalStyle,
        ),
        children: <Widget>[
          Container(
            width: double.maxFinite,
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: /*ListView.builder(
                shrinkWrap: true,
                itemCount: singlePlayerBGTimerDBSet.length,
                itemBuilder: (context, int outterIndex) {
                  Player playerplaceholder  = currentRoom.playerDB.firstWhere((element) => element.id ==  singlePlayerBGTimerDBSet.elementAt(outterIndex));
                  Player secondPlayerplaceholder;
                  CustomTimer timerplaceholder  = currentRoom.BGTimerDB.firstWhere((element) => element.playerID  ==  playerplaceholder.id);
                  if (timerplaceholder.secondPlayerID!=null||timerplaceholder.secondPlayerID!="") {
                    secondPlayerplaceholder  = currentRoom.playerDB.firstWhere((element) => element.id ==  timerplaceholder.secondPlayerID);
                  }
                  else  {
                    secondPlayerplaceholder = null;
                  }
                  return Container(
                    child: Column(
                      children: <Widget>[
                        RichText(
                            text: TextSpan(
                              text: secondPlayerplaceholder==null?playerplaceholder.name:playerplaceholder.name + " & " + secondPlayerplaceholder.name
                            ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: differentTimersForSinglePlayer(playerplaceholder.id).length,
                          itemBuilder: (context, int innerIndex) {

                            return timerWidget(context, timerplaceholder);
                          },
                        )
                      ],
                    ),
                  );
                }
              )*/
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: currentRoom.BGTimerDB.length,
                  //itemCount: differentPlayersInTimerDBList.length,
                  itemBuilder: (context, int index) {
                    int typeIDplaceholder = currentRoom.taskDB.firstWhere(
                            (placeholder) =>  placeholder.id == currentRoom.BGTimerDB[index].taskID).typeID;
                    if(typeIDplaceholder==3||typeIDplaceholder==6)  {
                      return Column(
                        children: <Widget>[
                          timerWidget(context,currentRoom.BGTimerDB[index]),
                          Divider(
                              color: Colors.transparent,
                              thickness: 2
                          )
                        ],
                      );
                    }
                    else  {
                      return Container();
                    }
                  }
              ),
            ),
          ),
          SimpleDialogOption(
              child: Text(
                "OK",
                textAlign: TextAlign.center,
                style: normalStyle
              ),
              onPressed: () {
                timerMenuOpen=false;
                Navigator.pop(context);
              }
          )
        ]
      );
    }
  );
}

Set countSinglePlayerTimersInBGTimerDB()  {
  Set differentPlayerListInBGTimerDB = new Set();
  for (CustomTimer timerplaceholder in currentRoom.BGTimerDB) {
    if (timerplaceholder.secondPlayerID==null||timerplaceholder.secondPlayerID=="") {
      differentPlayerListInBGTimerDB.add(timerplaceholder.playerID);
    }
  }
  print(differentPlayerListInBGTimerDB);
  return differentPlayerListInBGTimerDB;
}

List differentTimersForSinglePlayer(String playerID)  {
  List differentTimersForPlayer = new List();
  for (CustomTimer timerplaceholder in currentRoom.BGTimerDB) {
    if (timerplaceholder.playerID==playerID)  {
      differentTimersForPlayer.add(timerplaceholder);
    }
  }
  return differentTimersForPlayer;
}

Multimap countDifferentTimersForPlayerCombos()  {
  Multimap differentTimersForPlayerCombos = new Multimap();
  for (CustomTimer timerplaceholder in currentRoom.BGTimerDB) {
    if (timerplaceholder.secondPlayerID!=""||timerplaceholder.secondPlayerID!=null) {

    }
  }
}