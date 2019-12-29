import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "generated/i18n.dart";

import 'playerClass.dart';
import 'taskClass.dart';


final TextStyle _titleStyle = const TextStyle(
  fontSize: 36,
  color: Colors.black
);

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
                          _titleStyle,
                          text: firstPlayer.id==Player.mePlayer.id?S.of(context).ownTurn:firstPlayer.name
                      ),
                      TextSpan(
                          text: firstPlayer.id==Player.mePlayer.id?"":S.of(context).turn,
                          style: _titleStyle
                      )
                    ]
                )
            ),
          )
        ],
      );
      break;
    case 4:
    case 5:
    case 6:
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
                  ]
              ),
            ),
          )
        ],
      );
      break;
    case 7:
    case 11:
      return Container();
      break;
    case 8:
      return Center(
        child: Text(
          S.of(context).listThis,
          style: _titleStyle,
          textAlign: TextAlign.center,
        ),
      );
      break;
    case 9:
      if (firstPlayer.id==Player.mePlayer.id) {
        return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: _titleStyle,
                text: S.of(context).mimeThis
            ),
          ),
        );
      }
      else  {
        return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: _titleStyle,
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
            ),
          ),
        );
      }
      break;
    case 10:
      if (firstPlayer.id==Player.mePlayer.id) {
        return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: _titleStyle,
              children: <TextSpan>[
                TextSpan(
                    text: S.of(context).taboop1
                ),
                TextSpan(
                    text: Localizations.localeOf(context).toString()=="en_"?task.nString_en:task.nString_de
                ),
                TextSpan(
                    text: S.of(context).taboop2
                )
              ],
            ),
          ),
        );
      }
      else  {
        return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: _titleStyle,
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
            ),
          ),
        );
      }
      break;
    default:
      return Spacer();
      break;
  }
}