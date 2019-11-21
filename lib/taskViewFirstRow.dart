import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "generated/i18n.dart";

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';


final TextStyle _titleStyle = const TextStyle(
  fontSize: 36,
  color: Colors.black
);

final TextStyle _maletitleStyle = const TextStyle(
    fontSize: 36,
    color: Colors.blue
);

final TextStyle _femaletitleStyle = const TextStyle(
    fontSize: 36,
    color: Colors.red
);

Widget taskViewFirstRow(BuildContext context, Player firstPlayer, Player secondPlayer, Task task) {
  if  (task.typeID==1||task.typeID==2||task.typeID==3)  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: RichText(
              text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        style: firstPlayer.sex== 'm'
                            ? _maletitleStyle
                            : _femaletitleStyle,
                        text: firstPlayer.name
                    ),
                    TextSpan(
                        text: S.of(context).turn,
                        style: _titleStyle
                    )
                  ]
              )
          ),
        )
      ],
    );
  }
  if  (task.typeID==4||task.typeID==5||task.typeID==6)  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: RichText(
              text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        style: firstPlayer.sex== 'm'
                            ? _maletitleStyle
                            : _femaletitleStyle,
                        text: firstPlayer.name
                    ),
                    TextSpan(
                        text: " & ",
                        style: _titleStyle
                    ),
                    TextSpan(
                        style: secondPlayer.sex== 'm'
                            ? _maletitleStyle
                            : _femaletitleStyle,
                        text: secondPlayer.name
                    )
                  ]
              ),
          ),
        )
      ],
    );
  }
  if  (task.typeID==7)  {
    return Center(
      child: Text(
          S.of(context).compareThis,
          style: _titleStyle
      ),
    );
  }
  if  (task.typeID==8)  {
    return Center(
      child: Text(
          S.of(context).listThis,
          style: _titleStyle
      ),
    );
  }
  if  (task.typeID==9)  {
    if  (Room.activeRoom.activePlayerID==firstPlayer.id)  {
      return Center(
        child: RichText(
          text: TextSpan(
            style: _titleStyle,
            text: S.of(context).mimeThis
          ),
        ),
      );
    }
    else  {
      return Spacer();
    }
  }
  if  (task.typeID==10) {
    if  (Room.activeRoom.activePlayerID==firstPlayer.id)  {
      return Center(
        child: RichText(
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
            ]
          ),
        ),
      );
    }
  }
  if  (task.typeID==11) {
    return Spacer();
  }
  else  {
    return Spacer();
  }
}