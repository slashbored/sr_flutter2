import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "generated/i18n.dart";
import 'dart:convert';

import'webSocket.dart';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'customTimerClass.dart';

import 'betweenViewPage.dart';
import 'customOutlineButton.dart';

import 'fadeTransitionRoute.dart';

Widget taskViewThirdRow(BuildContext context, Player firstPlayer, Player secondPlayer, Task task) {

  final TextEditingController comparisonTextController  = new TextEditingController();
  //String locale;

  if  (CustomTimer.activeTimer!=null) {
    CustomTimer.activeTimer.FGTimeLeft  = S.of(taskViewPageContext).FGTimerGo;
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
                heroTag:  "fab_normal_denied",
                label: Text(S.of(context).noStyle1),
                onPressed: (){
                  //firstPlayer.points++;
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),*/
            /*FloatingActionButton.extended(
              heroTag:  "fab_normal_drink",
              backgroundColor: Colors.red,
              shape: CircleBorder(),
              label: createDrinkText(task),
              onPressed: ()  {
                upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                upStream.add(json.encode({'type':'choseToDrink','content':Player.mePlayer.id.toString()}));
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayers','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
              ),*/
            customOutlineButton(context, task, false, 'normal'),
            customOutlineButton(context, task, true, 'normal')
            /*FloatingActionButton.extended(
                heroTag:  "fab_normal_accepted",
                backgroundColor: Colors.green,
                shape: CircleBorder(),
                label: Text(
                  S.of(context).yesStyle1,
                  style: normalStyleWhite
                  ),
                onPressed: (){
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                  //Navigator.of(context).push(CupertinoPageRoute(builder: (context) => taskViewPage()));
                }
            )*/
          ]
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
                heroTag:  "fab_normalFGTime_denied",
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
            customOutlineButton(context, task, false, 'FGtimed'),
            /*FloatingActionButton.extended(
                heroTag:  "fab_normalFGTime_drink",
                backgroundColor: Colors.red,
                shape: CircleBorder(),
                label: createDrinkText(task),
                onPressed: ()  {
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'choseToDrink','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),*/
            customOutlineButton(context, task, true, 'isActiveTimer'),
            /*FloatingActionButton.extended(
                heroTag:  "fab_normalFGTime_startTimer",
                shape: CircleBorder(),
                label: Text(
                  CustomTimer.activeTimer!=null?
                  CustomTimer.activeTimer.FGTimeLeft:
                  S.of(context).FGTimerGo,
                  style: normalStyleWhite
                ),
                onPressed:  ()  {
                  startBGTimer(context);
                  Room.renewActiveTimer(context);
                }
            ),*/
            customOutlineButton(context, task, true, 'FGtimed')
            /*FloatingActionButton.extended(
                heroTag:  "fab_normalFGTime_accepted",
                backgroundColor: Colors.green,
                shape: CircleBorder(),
                label: Text(
                  S.of(context).yesStyle1,
                  style: normalStyleWhite),
                onPressed: (){
                  if (CustomTimer.activeTimer!=null)  {
                    if (CustomTimer.activeTimer.isRunning==true)  {
                      upStream.add(json.encode({'type':'cancelTimer','content':CustomTimer.activeTimer.id}));
                      currentRoom.BGTimerDB.removeWhere((timerPlaceholder)  =>  timerPlaceholder.id ==  CustomTimer.activeTimer.id);
                    }
                    CustomTimer.activeTimer.isRunning=false;
                  }
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            )*/
          ]
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
                heroTag:  "fab_normalBGTime_denied",
                label: Text(S.of(context).noStyle1),
                onPressed: (){
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),*/
            customOutlineButton(context, task, false, 'BGtimed'),
            /*FloatingActionButton.extended(
                heroTag:  "fab_normalBGTime_drink",
                backgroundColor: Colors.red,
                shape: CircleBorder(),
                label: createDrinkText(task),
                onPressed: ()  {
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'choseToDrink','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),*/
            customOutlineButton(context, task, true, 'BGtimed')
            /*FloatingActionButton.extended(
                heroTag:  "fab_normalBGTime_accepted",
                backgroundColor: Colors.green,
                shape: CircleBorder(),
                label: Text(
                  S.of(context).BGTimerGo,
                  style: normalStyleWhite
                ),
                onPressed: (){
                  startBGTimer(context);
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            )*/
          ]
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
                heroTag:  "fab_choice_denied",
                label: Text(S.of(context).noStyle2),
                onPressed: (){
                  //firstPlayer.id==Player.mePlayer.id?firstPlayer.points++:secondPlayer.points++;
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),*/
            customOutlineButton(context, task, false, 'normal'),
            /*FloatingActionButton.extended(
                heroTag:  "fab_choice_drink",
                backgroundColor: Colors.red,
                shape: CircleBorder(),
                label: createDrinkText(task),
                onPressed: ()  {
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'choseToDrink','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),*/
            customOutlineButton(context, task, true, 'normal')
            /*FloatingActionButton.extended(
                heroTag:  "fab_choice_accepted",
                backgroundColor: Colors.green,
                shape: CircleBorder(),
                label: Text(
                  S.of(context).yesStyle1,
                  style: normalStyleWhite
                ),
                onPressed: (){
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            )*/
          ]
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
            customOutlineButton(context, task, false, 'FGtimed'),
            /*FloatingActionButton.extended(
                heroTag:  "fab_choiceFGTime_denied",
                label: Text(S.of(context).noStyle2),
                onPressed: (){
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),*/
            /*FloatingActionButton.extended(
                heroTag:  "fab_choiceFGTime_drink",
                backgroundColor: Colors.red,
                shape: CircleBorder(),
                label: createDrinkText(task),
                onPressed: ()  {
                  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'choseToDrink','content':Player.mePlayer.id.toString()}));
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            ),*/
            customOutlineButton(context, task, true, 'isActiveTimer'),
            /*FloatingActionButton.extended(
                heroTag:  "fab_choiceFGTime_startTimer",
                shape: CircleBorder(),
                label: Text(
                  CustomTimer.activeTimer!=null?
                  CustomTimer.activeTimer.FGTimeLeft:
                  S.of(context).FGTimerGo,
                  style: normalStyleWhite
                ),
                onPressed:  ()  {
                  startBGTimer(context);
                }
            ),*/
            customOutlineButton(context, task, true, 'FGtimed')
            /*FloatingActionButton.extended(
                heroTag:  "fab_choiceFGTime_accepted",
                backgroundColor: Colors.green,
                shape: CircleBorder(),
                label: Text(
                  S.of(context).yesStyle1,
                  style: normalStyleWhite
                ),
                onPressed: (){
                  upStream.add(json.encode({'type':'randomTask','content':''}));
                  upStream.add(json.encode({'type':'randomPlayers','content':''}));
                  upStream.add(json.encode({'type':'nextTask','content':''}));
                }
            )*/
          ]
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
              heroTag:  "fab_choiceBGTime_denied",
              label: Text(S.of(context).noStyle2),
              onPressed: (){
                upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayers','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          ),*/
          /*FloatingActionButton.extended(
              heroTag:  "fab_choiceBGTime_drink",
              backgroundColor: Colors.red,
              shape: CircleBorder(),
              label: createDrinkText(task),
              onPressed: ()  {
                upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                upStream.add(json.encode({'type':'choseToDrink','content':Player.mePlayer.id.toString()}));
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayers','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          ),*/
          customOutlineButton(context, task, false, 'BGtimed'),
          customOutlineButton(context, task, true, 'BGtimed')
          /*FloatingActionButton.extended(
              heroTag:  "fab_choiceBGTime_accepted",
              backgroundColor: Colors.green,
              //shape: CircleBorder(),
              label: Text(
                  S.of(context).yesStyle1,
                  textAlign: TextAlign.center,
                  style: normalStyleWhite
              ),
              onPressed: (){
                startBGTimer(context);
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayers','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          )*/
        ]
      );
    }
    else  {
      return Container();
    }
    break;
    case 7:
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Spacer(
                flex: 1
              ),
              Flexible(
                flex: 1,
                child: TextField(
                  controller: comparisonTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                    )
                  ),
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false
                  ),
                  onChanged: (value) {
                    Player.mePlayer.compareValue=double.parse(value);
                  }
                )
              ),
              Spacer(
                flex: 1
              )
            ]
          ),
          OutlineButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            borderSide: BorderSide(
                width: 3,
                color: Colors.green,
                style: BorderStyle.solid
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
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
                  Navigator.of(context).push(fadePageRoute(page: betweenViewPage()));
                }
              }
          )
          /*FloatingActionButton.extended(
            heroTag: "fab_comparison_submit",
            shape: CircleBorder(),
            label:  Icon(
              Icons.arrow_forward_ios,
              color: Colors.green,),
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
            backgroundColor: Colors.transparent,
            elevation: 0,
            highlightElevation: 0
          )*/
        ]
      );
      break;
    case 8:
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            customOutlineButton(context, task, false, 'list'),
            Text(
              S.of(context).list_expl,
              style: tinyStyle
            )
          ]
        )
          /*child: FloatingActionButton.extended(
            heroTag:  "fab_listFailed",
            backgroundColor: Colors.red,
            shape: CircleBorder(),
            label:  Text(
              "️🤷🏼‍♀️",
              style: normalStyleWhite,
            ),
            onPressed:  ()  {
              upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
              upStream.add(json.encode({'type':'randomTask','content':''}));
              upStream.add(json.encode({'type':'randomPlayers','content':''}));
              upStream.add(json.encode({'type':'nextTask','content':''}));
            },
          )*/
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
              heroTag:  "fab_tabooMime_denied",
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
          /*FloatingActionButton.extended(
              heroTag:  "fab_tabooMime_drink",
              backgroundColor: Colors.red,
              shape: CircleBorder(),
              label: createDrinkText(task),
              onPressed: ()  {
                upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                upStream.add(json.encode({'type':'choseToDrink','content':Player.mePlayer.id.toString()}));
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayers','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          ),*/
          customOutlineButton(context, task, false, 'FGtimed'),
          //customOutlineButton(context, task, true, 'isActiveTimer'),
          /*FloatingActionButton.extended(
              heroTag:  "fab_tabooMime_startTimer",
              shape: CircleBorder(),
              label: Text(
                CustomTimer.activeTimer!=null?
                CustomTimer.activeTimer.FGTimeLeft:
                S.of(context).FGTimerGo,
                style: normalStyleWhite
              ),
              onPressed:  ()  {
                startBGTimer(context);
                Room.renewActiveTimer(context);
              }
          ),*/
          customOutlineButton(context, task, true, 'FGtimed')
          /*FloatingActionButton.extended(
              heroTag:  "fab_tabooMime_accepted",
              backgroundColor: Colors.green,
              shape: CircleBorder(),
              label: Text(
                S.of(context).tabooMimeWinStyle1,
                style: normalStyleWhite
              ),
              onPressed: () {
                if (CustomTimer.activeTimer!=null)  {
                  if (CustomTimer.activeTimer.isRunning==true)  {
                    upStream.add(json.encode({'type':'cancelTimer','content':CustomTimer.activeTimer.id}));
                    currentRoom.BGTimerDB.removeWhere((timerPlaceholder)  =>  timerPlaceholder.id ==  CustomTimer.activeTimer.id);
                  }
                  CustomTimer.activeTimer.isRunning=false;
                }
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayers','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          )*/
        ]
      );
    }
    else  {
      return  Center(
        child: Text(
          S.of(context).tabooMime_expl,
          style: tinyStyle
        )
      );
    }
    break;
    case 11:
      //locale = Localizations.localeOf(context).toString();
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          customOutlineButton(context, task, false, 'wyr'),
          customOutlineButton(context, task, true, 'wyr')
          /*FloatingActionButton.extended(
            heroTag: "fab_wyr_a_submit",
            backgroundColor: Colors.green,
            shape: CircleBorder(),
            label: Text(
              Task.getStringByLocale(task, locale, "wyr_a"),
              style: normalStyleWhite
            ),
            onPressed: () {
              Player.mePlayer.compareValue = 1;
              upStream.add(json.encode({'type':'compareVote','content':Player.mePlayer.compareValue}));
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => betweenViewPage()));
            },
          ),
          FloatingActionButton.extended(
            heroTag: "fab_wyr_b_submit",
            backgroundColor: Colors.red,
            label: Text(
              Task.getStringByLocale(task, locale, "wyr_b"),
              style: normalStyleWhite
            ),
            onPressed: () {
              Player.mePlayer.compareValue = 2;
              upStream.add(json.encode({'type':'compareVote','content':Player.mePlayer.compareValue}));
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => betweenViewPage()));
            }
          )*/
        ]
      );
    break;
    default:
      return Container();
      break;

  }
}

Text createDrinkText(Task task) {
  String drinkAmountString = "";
  for (int i = 0; i < (task.weight + Player.mePlayer.weightModifier); i++) {
    if (i<=1) {
      drinkAmountString = drinkAmountString + "🍺";
    }
    else  {
      drinkAmountString = "🍺x" + (task.weight + Player.mePlayer.weightModifier).toString();
    }
  }
  drinkAmountString.trim();
  return Text(
    drinkAmountString,
    style: normalStyleWhite
  );
}

void startBGTimer(BuildContext context) async {
  upStream.add(jsonEncode({'type':'startBGTimer','content':''}));
  await new Future.delayed(const Duration(milliseconds: 500));
}