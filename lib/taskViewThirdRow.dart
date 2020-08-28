import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'generated/l10n.dart';
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
            customOutlineButton(context, task, false, 'normal'),
            customOutlineButton(context, task, true, 'normal')
          ]
        );
      }
      else  {
        return Container();
      }
      break;
    case 2:
      Room.renewActiveTimer(context);
      if  (firstPlayer.id==Player.mePlayer.id)  {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            customOutlineButton(context, task, false, 'FGtimed'),
            customOutlineButton(context, task, true, 'FGtimed')
          ]
        );
      }
      else  {
        return Center(
          child: customOutlineButton(context, task, true, 'isActiveTimer'),
        );
      }
      break;
    case 3:
      if  (firstPlayer.id==Player.mePlayer.id)  {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            customOutlineButton(context, task, false, 'BGtimed'),
            customOutlineButton(context, task, true, 'BGtimed')
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
            customOutlineButton(context, task, false, 'normal'),
            customOutlineButton(context, task, true, 'normal')
          ]
        );
      }
      else  {
        return Container();
      }
      break;
    case 5:
      Room.renewActiveTimer(context);
      if  (firstPlayer.id==Player.mePlayer.id||secondPlayer.id==Player.mePlayer.id) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            customOutlineButton(context, task, false, 'FGtimed'),
            customOutlineButton(context, task, true, 'FGtimed')
          ]
        );
      }
      else  {
        return Center(
          child: customOutlineButton(context, task, true, 'isActiveTimer'),
        );
      }
      break;
    case 6:
    if  (firstPlayer.id==Player.mePlayer.id||secondPlayer.id==Player.mePlayer.id) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          customOutlineButton(context, task, false, 'BGtimed'),
          customOutlineButton(context, task, true, 'BGtimed')
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
      );
      break;
    case 9:
    case 10:
    if  (firstPlayer.id==Player.mePlayer.id)  {
      Room.renewActiveTimer(context);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          customOutlineButton(context, task, false, 'FGtimed'),
          //customOutlineButton(context, task, true, 'isActiveTimer'),
          customOutlineButton(context, task, true, 'FGtimed')
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
        ]
      );
    break;
    case 12:
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                customOutlineButton(context, task, false, 'globalNormal'),
                Text(
                    S.of(context).globalFail,
                    style: tinyStyle
                )
              ]
          )
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