import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'generated/l10n.dart';
import 'webSocket.dart';
import 'taskClass.dart';
import 'playerClass.dart';
import 'customTimerClass.dart';

bool timerDoneDialogOpen;
bool first;
BuildContext timerDoneDialogContext;
String locale = Localizations.localeOf(timerDoneDialogContext).toString();
String taskString;
List splitStringList;
RichText doneText;
Player otherPlayer;

Widget timerDoneDialog(BuildContext context, Task completedTask, CustomTimer endedTimer)  {
  timerDoneDialogContext  = context;
  endedTimer.playerID ==  Player.mePlayer.id?first=true:first=false;
  taskString  = Task.getStringByLocale(completedTask, locale, first?'completeString_active':'completeString_passive');
  if (endedTimer.secondPlayerID!=null)  {
    otherPlayer = currentRoom.playerDB.firstWhere((element) => element.id ==  (first?endedTimer.secondPlayerID:endedTimer.playerID));
    splitStringList = taskString.split("\$placeholder");
    doneText  =  RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: normalStyle,
          children: [
            TextSpan(
                text: splitStringList[0]
            ),
            TextSpan(
                style: TextStyle(
                    color: otherPlayer.color,
                    fontSize: 18
                ),
                text: otherPlayer.name
            ),
            TextSpan(
                text: splitStringList[1]
            )

          ]
      ),
    );
  }
  else  {
    doneText  =  RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: normalStyle,
        text: taskString
      ),
    );
  }

  return StreamBuilder(
    stream: downStream,
    builder: (context, snapShot)  {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        title: Text(
          S.of(context).timerDoneDialog_title,
          textAlign: TextAlign.center,
          style: normalStyle
        ),
        children: <Widget>[
        doneText,
        SimpleDialogOption(
          child: Text(
            "OK",
            textAlign: TextAlign.center,
            style: normalStyle,
          ),
          onPressed: () {
            timerDoneDialogOpen = false;
            Navigator.pop(context);
          },
        )
        ]
      ) ;
    }
  );
}