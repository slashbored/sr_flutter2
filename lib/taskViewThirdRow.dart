import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'generated/l10n.dart';
import 'dart:convert';

import 'webSocket.dart';
import 'textStyles.dart';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'customTimerClass.dart';

import 'betweenViewPage.dart';
import 'customFlatButton.dart';

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
            customFlatButton(context, task, false, 'normal'),
            customFlatButton(context, task, true, 'normal')
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
            customFlatButton(context, task, false, 'FGtimed'),
            customFlatButton(context, task, true, 'FGtimed')
          ]
        );
      }
      else  {
        return Center(
          child: customFlatButton(context, task, true, 'isActiveTimer'),
        );
      }
      break;
    case 3:
      if  (firstPlayer.id==Player.mePlayer.id)  {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            customFlatButton(context, task, false, 'BGtimed'),
            customFlatButton(context, task, true, 'BGtimed')
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
            customFlatButton(context, task, false, 'normal'),
            customFlatButton(context, task, true, 'normal')
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
            customFlatButton(context, task, false, 'FGtimed'),
            customFlatButton(context, task, true, 'FGtimed')
          ]
        );
      }
      else  {
        return Center(
          child: customFlatButton(context, task, true, 'isActiveTimer'),
        );
      }
      break;
    case 6:
    if  (firstPlayer.id==Player.mePlayer.id||secondPlayer.id==Player.mePlayer.id) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          customFlatButton(context, task, false, 'BGtimed'),
          customFlatButton(context, task, true, 'BGtimed')
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
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
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
              },
            color: Colors.green,
          )
        ]
      );
      break;
    case 8:
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            customFlatButton(context, task, false, 'list'),
            Text(
              S.of(context).list_expl,
              style: tinyStyle,
              textAlign: TextAlign.center,
            )
          ]
        )
      );
      break;
    case 9:
    case 10:
    case 13:
    if  (firstPlayer.id==Player.mePlayer.id)  {
      Room.renewActiveTimer(context);
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          customFlatButton(context, task, false, 'normal'),
          Text(
            S.of(context).tabooMime_failexpl,
            style: tinyStyle,
            textAlign: TextAlign.center,
          )
          //customOutlineButton(context, task, true, 'isActiveTimer'), //for when these activities should be timed
          //customFlatButton(context, task, true, 'FGtimed')
        ]
      );
    }
    else  {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customFlatButton(context, task, true, 'inverted'),
          Text(
            S.of(context).tabooMime_expl,
            style: tinyStyle,
            textAlign: TextAlign.center,
          )
        ]
      );
    }
    break;
    case 11:
      //locale = Localizations.localeOf(context).toString();
    return Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: <Widget>[
        customFlatButton(context, task, false, 'wyr'),
        Container(),
        customFlatButton(context, task, true, 'wyr')]
    );
      /*return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          customOutlineButton(context, task, false, 'wyr'),
          customOutlineButton(context, task, true, 'wyr')
        ]
      );*/
    break;
    case 12:
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                customFlatButton(context, task, false, 'globalNormal'),
                Text(
                  S.of(context).globalFail,
                  style: tinyStyle,
                  textAlign: TextAlign.center,
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