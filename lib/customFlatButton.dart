import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'generated/l10n.dart';
import 'textStyles.dart';
import 'webSocket.dart';
import 'dart:convert';
import 'playerClass.dart';
import 'customTimerClass.dart';
import 'taskClass.dart';
import 'betweenViewPage.dart';
import 'roomClass.dart';
import 'fadeTransitionRoute.dart';

Widget  customFlatButton(BuildContext context, Task task, bool yesOrNo, String type)  {
  switch  (type)  {
    case 'isActiveTimer':
      return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Text(
              CustomTimer.activeTimer!=null?
              CustomTimer.activeTimer.FGTimeLeft:
              S.of(context).FGTimerGo,
              style: normalStyleWhite
          ),
          onPressed: () async{
            upStream.add(jsonEncode({'type':'startBGTimer','content':''}));
            await new Future.delayed(const Duration(milliseconds: 500));
            Room.renewActiveTimer(context);
          },
        color: Colors.blue
      );
      break;
    case 'wyr':
      String locale = Localizations.localeOf(context).toString();
      return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Text(
              yesOrNo?Task.getStringByLocale(task, locale, "wyr_a"):
              Task.getStringByLocale(task, locale, "wyr_b"),
              style: normalStyleWhite
          ),
          onPressed: () {
            yesOrNo?Player.mePlayer.compareValue = 1:Player.mePlayer.compareValue = 2;
            upStream.add(json.encode({'type':'compareVote','content':Player.mePlayer.compareValue}));
            Navigator.of(context).push(fadePageRoute(page: betweenViewPage()));
          },
        color: yesOrNo?Colors.green:Colors.red,
      );
      break;
    case 'list':
    case 'globalNormal':
      return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Text(
            "️🤷🏽🍺️",
            style: bigStyleWhite
          ),
          onPressed: () {
            no();
          },
        color: Colors.red,
      );
      break;
    case 'inverted':
      return FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Text(
            "️🙋🏽",
            style: bigStyleWhite
        ),
        onPressed: () {
          invert();
        },
        color: Colors.green,
      );
      break;
    default:
      return FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Text(
            yesOrNo?(type=='BGtimed'?S.of(context).BGTimerGo:S.of(context).FGTimerDone):createDrinkText(task),
            textAlign: TextAlign.center,
            style: normalStyleWhite
        ),
        onPressed: (){
          switch (type) {
            case 'normal':
              yesOrNo?forward():no();
              break;
            case 'BGtimed':
              yesOrNo?startBGTimer():no();
              break;
            case 'FGtimed':
              abortActiveFGTimer();
              yesOrNo?forward():no();
              break;
          }
        },
        color: yesOrNo?Colors.green:Colors.red,
      );
      break;
  }
}

void forward()  {
  /*upStream.add(json.encode({'type':'randomTask','content':''})); //keeping for future usage maybe?
  upStream.add(json.encode({'type':'randomPlayers','content':''}));*/
  upStream.add(json.encode({'type': 'paintingData', 'content': 'clear'}));
  upStream.add(json.encode({'type':'nextTask','content':''}));
}

void no() {
  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
  upStream.add(json.encode({'type':'choseToDrink','content':Player.mePlayer.id.toString()}));
  forward();
}

void invert() {
  for (Player playerplaceholder in currentRoom.playerDB)  {
    if (playerplaceholder.id!=Player.mePlayer.id&&playerplaceholder.id!=currentRoom.activePlayerID) {
      upStream.add(json.encode({'type':'pointsInc','content':playerplaceholder.id.toString()}));
    }
  }
  forward();
}

void startBGTimer() async{
    upStream.add(jsonEncode({'type':'startBGTimer','content':''}));
    await new Future.delayed(const Duration(milliseconds: 500));
    forward();
}

void abortActiveFGTimer() {
  if (CustomTimer.activeTimer!=null)  {
    if (CustomTimer.activeTimer.isRunning==true)  {
      upStream.add(json.encode({'type':'cancelTimer','content':CustomTimer.activeTimer.id}));
      currentRoom.BGTimerDB.removeWhere((timerPlaceholder)  =>  timerPlaceholder.id ==  CustomTimer.activeTimer.id);
    }
    CustomTimer.activeTimer.isRunning=false;
  }
}

String createDrinkText(Task task) {
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
  return drinkAmountString;
}