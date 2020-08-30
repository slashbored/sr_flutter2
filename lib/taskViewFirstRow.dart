import 'package:sr_flutter2/webSocket.dart';

import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'generated/l10n.dart';

import 'playerClass.dart';
import 'taskClass.dart';

Widget taskViewFirstRow(BuildContext context, Player firstPlayer, Player secondPlayer, Task task) {
  switch (task.typeID)  {
    case 1:
    case 2:
    case 3:
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          style: firstPlayer.id!=Player.mePlayer.id?
                          TextStyle(
                            color: firstPlayer.color,
                            fontSize: 36
                          ):
                          headlineStyle,
                          text: firstPlayer.id==Player.mePlayer.id?S.of(context).ownTurn:firstPlayer.name
                      )
                    ]
                )
            )
          )
        ]
      );
      break;
    case 4:
    case 5:
    case 6:
      if (firstPlayer.id==Player.mePlayer.id||secondPlayer.id==Player.mePlayer.id) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          style: TextStyle(
                              color: Player.mePlayer.color,
                              fontSize: 36
                          ),
                          text: Player.mePlayer.name
                      )
                    ]
                )
              )
            )
          ]
        );
      }
      else  {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        style: TextStyle(
                          color: firstPlayer.color,
                          fontSize: 36
                        ),
                        text: firstPlayer.name
                      ),
                      TextSpan(
                        style: headlineStyle,
                        text: " & "
                      ),
                      TextSpan(
                          style: TextStyle(
                              color: secondPlayer.color,
                              fontSize: 36
                          ),
                          text: secondPlayer.name
                      )
                    ]
                )
              )
            )
          ]
        );
      }
      break;
    case 7:
      return Center(
        child: Text(
          S.of(context).compare_title,
          textAlign: TextAlign.center,
          style: headlineStyle
        ),
      );
      break;
    case 8:
      return Center(
        child: firstPlayer.id==Player.mePlayer.id?
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: headlineStyle,
            children:[
              TextSpan(
                text: S.of(context).listThis,
                  style: headlineStyle
              ),
              TextSpan(
                text: S.of(context).listYouStart
              )
            ]
          )
        ):
        RichText(
          textAlign: TextAlign.center,
            text: TextSpan(
                style: headlineStyle,
                children:[
                  TextSpan(
                      text: S.of(context).listThis,
                      style: headlineStyle
                  ),
                  TextSpan(
                    text: currentRoom.playerDB.firstWhere((element) => element.id == currentRoom.activePlayerID).name,
                    style: TextStyle(
                      color: currentRoom.playerDB.firstWhere((element) => element.id == currentRoom.activePlayerID).color
                    )
                  ),
                  TextSpan(
                    text: S.of(context).listNotYouStart
                  )
                ]
            )
        )
      );
      break;
    case 9:
      if (firstPlayer.id==Player.mePlayer.id) {
        return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: headlineStyle,
                text: S.of(context).mimeThis
            )
          )
        );
      }
      else  {
        return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: headlineStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: S.of(context).tabooMimeGuessp1
                  ),
                  TextSpan(
                    text: firstPlayer.name,
                    style: TextStyle(
                      color: firstPlayer.color,
                      fontSize: 36
                    )
                  ),
                  TextSpan(
                      text: S.of(context).tabooMimeGuessp2
                  )
                ]
            )
          )
        );
      }
      break;
    case 10:
      if (firstPlayer.id==Player.mePlayer.id) {
        return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: headlineStyle,
              children: <TextSpan>[
                TextSpan(
                    text: S.of(context).taboop1
                ),
                TextSpan(
                    text: Localizations.localeOf(context).toString()=="en_"||Localizations.localeOf(context).toString()=="en"?task.nString_en_active:task.nString_de_active
                ),
                TextSpan(
                    text: S.of(context).taboop2
                )
              ]
            )
          )
        );
      }
      else  {
        return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: headlineStyle,
                children: <TextSpan>[
                  TextSpan(
                      text: S.of(context).tabooMimeGuessp1
                  ),
                  TextSpan(
                      text: firstPlayer.name,
                      style: TextStyle(
                          color: firstPlayer.color,
                          fontSize: 36
                      )
                  ),
                  TextSpan(
                      text: S.of(context).tabooMimeGuessp2
                  )
                ]
            )
          )
        );
      }
      break;
    case 11:
      return Center(
          child: Text(
              S.of(context).wyr_title,
              textAlign: TextAlign.center,
              style: headlineStyle
          )
      );
      break;
    case 12:
      return Center(
        child: Text(
            S.of(context).globalTitle,
            textAlign: TextAlign.center,
            style: headlineStyle
        )
      );
      break;
    default:
      return Spacer();
      break;
  }
}