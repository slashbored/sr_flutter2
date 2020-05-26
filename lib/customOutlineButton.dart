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

Widget  customOutlineButton(BuildContext context, Task task, bool yesOrNo, String type)  {
  switch  (type)  {
    case 'isActiveTimer':
      return OutlineButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          borderSide: BorderSide(
              width: 3,
              color: Colors.blue,
              style: BorderStyle.solid
          ),
          child: Text(
              CustomTimer.activeTimer!=null?
              CustomTimer.activeTimer.FGTimeLeft:
              S.of(context).FGTimerGo,
              style: normalStyle
          ),
          onPressed: () async{
            upStream.add(jsonEncode({'type':'startBGTimer','content':''}));
            await new Future.delayed(const Duration(milliseconds: 500));
            Room.renewActiveTimer(context);
          }
      );
      break;
    case 'wyr':
      String locale = Localizations.localeOf(context).toString();
      return OutlineButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          borderSide: BorderSide(
              width: 3,
              color: yesOrNo?Colors.green:Colors.red,
              style: BorderStyle.solid
          ),
          child: Text(
              yesOrNo?Task.getStringByLocale(task, locale, "wyr_a"):
              Task.getStringByLocale(task, locale, "wyr_b"),
              style: normalStyle
          ),
          onPressed: () {
            yesOrNo?Player.mePlayer.compareValue = 1:Player.mePlayer.compareValue = 2;
            upStream.add(json.encode({'type':'compareVote','content':Player.mePlayer.compareValue}));
            Navigator.of(context).push(fadePageRoute(page: betweenViewPage()));
          }
      );
      break;
    case 'list':
      return OutlineButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          borderSide: BorderSide(
              width: 3,
              color: Colors.red,
              style: BorderStyle.solid
          ),
          child: Text(
            "️🤷🏼‍♀️",
            style: bigStyle
          ),
          onPressed: () {
            no();
          }
      );
      break;
    default:
      return OutlineButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        borderSide: BorderSide(
            width: 3,
            color: yesOrNo?Colors.green:Colors.red,
            style: BorderStyle.solid
        ),
        child: Text(
            yesOrNo?S.of(context).yesStyle1:createDrinkText(task),
            textAlign: TextAlign.center,
            style: normalStyle
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
      );
      break;
  }
}

void forward()  {
  upStream.add(json.encode({'type':'randomTask','content':''}));
  upStream.add(json.encode({'type':'randomPlayers','content':''}));
  upStream.add(json.encode({'type':'nextTask','content':''}));
}

void no() {
  upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
  upStream.add(json.encode({'type':'choseToDrink','content':Player.mePlayer.id.toString()}));
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