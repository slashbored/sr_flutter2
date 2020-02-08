import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'generated/i18n.dart';
import 'webSocket.dart';
import 'timerWidget.dart';
import 'customTimerClass.dart';
import 'roomClass.dart';
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
          DefaultTabController(
            length: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TabBar(
                  tabs: <Widget>[
                    Icon(
                      Icons.accessibility_new,
                      color: Colors.black,
                    ),
                    Icon(
                      Icons.wc,
                      color: Colors.black,)
                  ],
                ),
                Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height*0.5,
                  child: TabBarView(
                    children: <Widget>[
                      ListView.builder( //singleplayerView
                          shrinkWrap: true,
                          itemCount: sortedSinglePlayerMultimap().keys.length,
                          itemBuilder: (context, int outterIndex) {
                            return Column(
                              children: <Widget>[
                                Text(
                                  currentRoom.playerDB.firstWhere((element) => element.id ==  sortedSinglePlayerMultimap().keys.elementAt(outterIndex).toString()).name + ":",
                                  style: smallStyle
                                ),
                                FractionallySizedBox(
                                  widthFactor: 0.75,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: listForSinglePlayer(currentRoom.playerDB.firstWhere((element) => element.id ==  sortedSinglePlayerMultimap().keys.elementAt(outterIndex).toString()).id).length,
                                      itemBuilder: (context, int innerIndex)  {
                                        return timerWidget(context, listForSinglePlayer(currentRoom.playerDB.firstWhere((element) => element.id ==  sortedSinglePlayerMultimap().keys.elementAt(outterIndex).toString()).id)[innerIndex]);
                                      }),
                                ),
                                Container(
                                  height: 10
                                )
                              ]
                            );
                          }
                      ),
                      ListView.builder( //singleplayerView
                          shrinkWrap: true,
                          itemCount: sortedMultiPlayerMultimap().keys.length,
                          itemBuilder: (context, int outterIndex) {
                            print(sortedMultiPlayerMultimap()[sortedMultiPlayerMultimap().keys.elementAt(outterIndex)].length);
                            return Column(
                              children: <Widget>[
                                Text(
                                  currentRoom.playerDB.firstWhere((element) => element.id ==  sortedMultiPlayerMultimap().keys.elementAt(outterIndex).toString().substring(0, ((sortedMultiPlayerMultimap().keys.elementAt(outterIndex).length)/2).toInt())).name +
                                  " & " +
                                  currentRoom.playerDB.firstWhere((element) => element.id ==  sortedMultiPlayerMultimap().keys.elementAt(outterIndex).toString().substring(((sortedMultiPlayerMultimap().keys.elementAt(outterIndex).length)/2).toInt(), (sortedMultiPlayerMultimap().keys.elementAt(outterIndex).length))).name,
                                  style: smallStyle
                                ),
                                FractionallySizedBox(
                                  widthFactor: 0.75,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: sortedMultiPlayerMultimap()[sortedMultiPlayerMultimap().keys.elementAt(outterIndex)].length,
                                      physics: const NeverScrollableScrollPhysics(),
                                      //itemCount: listForMultiPlayer(sortedMultiPlayerMultimap().keys.elementAt(outterIndex)).length,
                                      itemBuilder: (context, int innerIndex)  {
                                        return timerWidget(context, sortedMultiPlayerMultimap()[sortedMultiPlayerMultimap().keys.elementAt(outterIndex)].elementAt(innerIndex));
                                      }),
                                ),
                                Container(
                                  height: 10,
                                )
                              ]
                            );
                          }
                      )
                    ]
                  )
                )
              ]
            )
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

Multimap sortedSinglePlayerMultimap() {
  Multimap singlePlayerMultiMapPlaceholder  = new Multimap();
  for (CustomTimer timerplaceholder in currentRoom.BGTimerDB) {
    if (timerplaceholder.secondPlayerID==null||timerplaceholder.secondPlayerID=="") {
      singlePlayerMultiMapPlaceholder.add(timerplaceholder.playerID, timerplaceholder);
    }
  }
  return singlePlayerMultiMapPlaceholder;
}

List listForSinglePlayer(String foreignKey) {
  List listPlaceholder  = new List();
  listPlaceholder.addAll(currentRoom.BGTimerDB.where((element) => element.playerID==foreignKey));
  return listPlaceholder;
}

Multimap sortedMultiPlayerMultimap()  { //key = combo, value = iterable of timers
  Multimap multiPlayerMultiMapPlaceholder  = new Multimap();
  for (CustomTimer timerplaceholder in currentRoom.BGTimerDB) {
    if ((timerplaceholder.secondPlayerID!=null||timerplaceholder.secondPlayerID!="") /*&& (!multiPlayerMultiMapPlaceholder.containsKey(timerplaceholder.playerID + timerplaceholder.secondPlayerID))*/)  {
      if (multiPlayerMultiMapPlaceholder.containsKey(timerplaceholder.secondPlayerID + timerplaceholder.playerID))  {
        multiPlayerMultiMapPlaceholder.add(timerplaceholder.secondPlayerID + timerplaceholder.playerID, timerplaceholder);
      }
     else {
        multiPlayerMultiMapPlaceholder.add(timerplaceholder.playerID + timerplaceholder.secondPlayerID, timerplaceholder);
      } //key -> iterable value(s)
    }
  }
  //print(multiPlayerMultiMapPlaceholder.toString());
  return multiPlayerMultiMapPlaceholder;
}

List listForMultiPlayer(String foreignKey) { //create list of timers corresponding to specific key defined in SMPM
  List listPlaceholder  = new List();
  listPlaceholder.addAll(sortedSinglePlayerMultimap()[foreignKey]);
  /*listPlaceholder.addAll(currentRoom.BGTimerDB.where((element) => (
      element.playerID==foreignKey.substring(0, ((foreignKey.length)/2).toInt())
      && (element.secondPlayerID==foreignKey.substring(((foreignKey.length)/2).toInt(), foreignKey.length)))));
  //print(listPlaceholder.length);*/
  return listPlaceholder;
}

/*Set countSinglePlayerTimersInBGTimerDB()  {
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
}*/

/*ListView.builder(
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