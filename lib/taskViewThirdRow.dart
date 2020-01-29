import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "generated/i18n.dart";
import 'dart:convert';

import'webSocket.dart';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'timerClass.dart';

import 'betweenViewPage.dart';

Widget taskViewThirdRow(BuildContext context, Player firstPlayer, Player secondPlayer, Task task) {

  final TextEditingController comparisonTextController  = new TextEditingController();
  String locale;

  if  (customTimer.activeTimer!=null) {
    customTimer.activeTimer.FGTimeLeft  = S.of(taskViewPageContext).FGTimerGo;
  }

  if (Player.mePlayer.compareValue!=null)  {
    comparisonTextController.value=TextEditingValue(text: Player.mePlayer.compareValue.toString());
    comparisonTextController.selection  = TextSelection(baseOffset: comparisonTextController.text.length, extentOffset: comparisonTextController.text.length);
  }

  switch (task.typeID)  {
    case 1:
      if  (firstPlayer.id==Player.mePlayer.id)  {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            /*FloatingActionButton.extended(
                heroTag:  "normal_denied",
                label: Text(S.of(context).noStyle1),
                onPressed: (){
                  //firstPlayer.points++;
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),*/
            FloatingActionButton.extended(
              heroTag:  "normal_drink",
              label: Text(createDrinkString(task)),
              onPressed: ()  {
                upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayers','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
              ),
            FloatingActionButton.extended(
                heroTag:  "normal_accepted",
                label: Text(S.of(context).yesStyle1),
                onPressed: (){
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                  //Navigator.of(context).push(CupertinoPageRoute(builder: (context) => taskViewPage()));
                }
            )
          ],
        );
      }
      else  {
        return Container();
      }
      break;
    case 2:
      if  (firstPlayer.id==Player.mePlayer.id)  {
        Room.renewActiveTimer(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            /*FloatingActionButton.extended(
                heroTag:  "normalFGTime_denied",
                label: Text(S.of(context).noStyle1),
                onPressed: (){
                  if (customTimer.activeTimer!=null)  {
                    if (customTimer.activeTimer.isRunning==true)  {
                      upStream.add(json.encode({'type':'cancelTimer','content':customTimer.activeTimer.id}));
                      currentRoom.BGTimerDB.removeWhere((timerPlaceholder)  =>  timerPlaceholder.id ==  customTimer.activeTimer.id);
                    }
                    customTimer.activeTimer.isRunning=false;
                  }
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                  //Navigator.of(context).push(CupertinoPageRoute(builder: (context) => taskViewPage()));
                }
            ),*/
            FloatingActionButton.extended(
                heroTag:  "normalFGTime_drink",
                label: Text(createDrinkString(task)),
                onPressed: ()  {
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),
            FloatingActionButton.extended(
                heroTag:  "normalFGTime_startTimer",
                label: Text(customTimer.activeTimer!=null?
                customTimer.activeTimer.FGTimeLeft:
                S.of(context).FGTimerGo),
                onPressed:  ()  {
                  startBGTimer(context);
                  Room.renewActiveTimer(context);
                }
            ),
            FloatingActionButton.extended(
                heroTag:  "normalFGTime_accepted",
                label: Text(S.of(context).yesStyle1),
                onPressed: (){
                  if (customTimer.activeTimer!=null)  {
                    if (customTimer.activeTimer.isRunning==true)  {
                      upStream.add(json.encode({'type':'cancelTimer','content':customTimer.activeTimer.id}));
                      currentRoom.BGTimerDB.removeWhere((timerPlaceholder)  =>  timerPlaceholder.id ==  customTimer.activeTimer.id);
                    }
                    customTimer.activeTimer.isRunning=false;
                  }
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            )
          ],
        );
      }
      else  {
        return Container();
      }
      break;
    case 3:
      if  (firstPlayer.id==Player.mePlayer.id)  {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            /*FloatingActionButton.extended(
                heroTag:  "normalBGTime_denied",
                label: Text(S.of(context).noStyle1),
                onPressed: (){
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),*/
            FloatingActionButton.extended(
                heroTag:  "normalBGTime_drink",
                label: Text(createDrinkString(task)),
                onPressed: ()  {
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),
            FloatingActionButton.extended(
                heroTag:  "normalBGTime_accepted",
                label: Text(S.of(context).BGTimerGo),
                onPressed: (){
                  startBGTimer(context);
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            )
          ],
        );
      }
      else  {
        return Container();
      }
      break;
    case 4:
      if  (firstPlayer.id==Player.mePlayer.id||secondPlayer.id==Player.mePlayer.id) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            /*FloatingActionButton.extended(
                heroTag:  "choice_denied",
                label: Text(S.of(context).noStyle2),
                onPressed: (){
                  //firstPlayer.id==Player.mePlayer.id?firstPlayer.points++:secondPlayer.points++;
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),*/
            FloatingActionButton.extended(
                heroTag:  "choice_drink",
                label: Text(createDrinkString(task)),
                onPressed: ()  {
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),
            FloatingActionButton.extended(
                heroTag:  "choice_accepted",
                label: Text(S.of(context).yesStyle1),
                onPressed: (){
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            )
          ],
        );
      }
      else  {
        return Container();
      }
      break;
    case 5:
      if  (firstPlayer.id==Player.mePlayer.id||secondPlayer.id==Player.mePlayer.id) {
        Room.renewActiveTimer(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            /*FloatingActionButton.extended(
                heroTag:  "choiceFGTime_denied",
                label: Text(S.of(context).noStyle2),
                onPressed: (){
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),*/
            FloatingActionButton.extended(
                heroTag:  "choiceFGTime_drink",
                label: Text(createDrinkString(task)),
                onPressed: ()  {
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),
            FloatingActionButton.extended(
                heroTag:  "choiceFGTime_startTimer",
                label: Text(customTimer.activeTimer!=null?customTimer.activeTimer.FGTimeLeft:S.of(context).FGTimerGo),
                onPressed:  ()  {
                  startBGTimer(context);
                }
            ),
            FloatingActionButton.extended(
                heroTag:  "choiceFGTime_accepted",
                label: Text(S.of(context).yesStyle1),
                onPressed: (){
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),
          ],
        );
      }
      else  {
        return Container();
      }
      break;
    case 6:
    if  (firstPlayer.id==Player.mePlayer.id||secondPlayer.id==Player.mePlayer.id) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          /*FloatingActionButton.extended(
              heroTag:  "choiceBGTime_denied",
              label: Text(S.of(context).noStyle2),
              onPressed: (){
                upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayers','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          ),*/
          FloatingActionButton.extended(
              heroTag:  "choiceBGTime_drink",
              label: Text(createDrinkString(task)),
              onPressed: ()  {
                upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayers','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          ),
          FloatingActionButton.extended(
              heroTag:  "choiceBGTime_accepted",
              label: Text(S.of(context).yesStyle1),
              onPressed: (){
                startBGTimer(context);
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayers','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          )
        ],
      );
    }
    else  {
      return Container();
    }
    break;
    case 7:
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Spacer(
                flex: 2,
              ),
              Flexible(
                child: TextField(
                  controller: comparisonTextController,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false
                  ),
                  onChanged: (value) {
                    Player.mePlayer.compareValue=double.parse(value);
                  },
                ),
              ),
              Spacer(
                flex: 2,
              )
            ],
          ),
          FloatingActionButton.extended(
            heroTag: "comparison_submit",
            label:  Text("Ok"),
            onPressed: () {
              if (comparisonTextController.text==""||comparisonTextController.text==null)  {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                        content: Text(S.of(context).pleaseEnterValidNumber)
                    )
                );
              }
              else  {
                Player.mePlayer.compareValue=double.parse(comparisonTextController.text);
                upStream.add(json.encode({'type':'compareNumber','content':Player.mePlayer.compareValue}));
                comparisonTextController.clear();
                //Player.mePlayer.compareValue=null;
                Navigator.of(context).push(CupertinoPageRoute(builder: (context) => betweenViewPage()));
              }
            },
          )
        ],
      );
      break;
    case 8:
      return Center(
          child: FloatingActionButton.extended(
              heroTag:  "listFailed",
              label:  Text(
                "️🤷🏼‍♀️",
                style: TextStyle(
                    fontSize: 27
                ),
              ),
              onPressed:  ()  {
                upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayers','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              })
      );
      break;
    case 9:
    case 10:
    if  (firstPlayer.id==Player.mePlayer.id)  {
      Room.renewActiveTimer(context);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          /*FloatingActionButton.extended(
              heroTag:  "tabooMime_denied",
              label: Text(S.of(context).tabooMimeFailStyle1),
              onPressed: () {
                if (customTimer.activeTimer!=null)  {
                  if (customTimer.activeTimer.isRunning==true)  {
                    upStream.add(json.encode({'type':'cancelTimer','content':customTimer.activeTimer.id}));
                    currentRoom.BGTimerDB.removeWhere((timerPlaceholder)  =>  timerPlaceholder.id ==  customTimer.activeTimer.id);
                  }
                  customTimer.activeTimer.isRunning=false;
                }
                upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayers','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          ),*/
          FloatingActionButton.extended(
              heroTag:  "tabooMime_drink",
              label: Text(createDrinkString(task)),
              onPressed: ()  {
                upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayers','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          ),
          FloatingActionButton.extended(
              heroTag:  "tabooMime_startTimer",
              label: Text(customTimer.activeTimer!=null?
              customTimer.activeTimer.FGTimeLeft:
              S.of(context).FGTimerGo),
              onPressed:  ()  {
                startBGTimer(context);
                Room.renewActiveTimer(context);
              }
          ),
          FloatingActionButton.extended(
              heroTag:  "tabooMime_accepted",
              label: Text(S.of(context).tabooMimeWinStyle1),
              onPressed: () {
                if (customTimer.activeTimer!=null)  {
                  if (customTimer.activeTimer.isRunning==true)  {
                    upStream.add(json.encode({'type':'cancelTimer','content':customTimer.activeTimer.id}));
                    currentRoom.BGTimerDB.removeWhere((timerPlaceholder)  =>  timerPlaceholder.id ==  customTimer.activeTimer.id);
                  }
                  customTimer.activeTimer.isRunning=false;
                }
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayers','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          ),
        ],
      );
    }
    else  {
      return  Container();
    }
    break;
    case 11:
      locale = Localizations.localeOf(context).toString();
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: "wyr_a_submit",
            label: Text(Task.getStringByLocale(task, locale, "wyr_a")),
            onPressed: () {
              Player.mePlayer.compareValue = 1;
              upStream.add(json.encode({'type':'compareVote','content':Player.mePlayer.compareValue}));
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => betweenViewPage()));
            },
          ),
          FloatingActionButton.extended(
            heroTag: "wyr_b_submit",
            label: Text(Task.getStringByLocale(task, locale, "wyr_b")),
            onPressed: () {
              Player.mePlayer.compareValue = 2;
              upStream.add(json.encode({'type':'compareVote','content':Player.mePlayer.compareValue}));
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => betweenViewPage()));
            },
          )
        ],

      );
    break;
    default:
      return Container();
      break;

  }
}

String createDrinkString(Task task) {
  String drinkAmountString = "";
  for (int i = 0; i < (task.weight + Player.mePlayer.weightModifier); i++) {
    if (i<=3) {
      drinkAmountString = drinkAmountString + "🍺 ";
    }
    else  {
      drinkAmountString = "🍺 x " + (task.weight + Player.mePlayer.weightModifier).toString();
    }
  }
  drinkAmountString.trim();
  print(Player.mePlayer.weightModifier.toString());
  return drinkAmountString;
}

void startBGTimer(BuildContext context) async {
  upStream.add(jsonEncode({'type':'startBGTimer','content':''}));
  await new Future.delayed(const Duration(milliseconds: 500));
}