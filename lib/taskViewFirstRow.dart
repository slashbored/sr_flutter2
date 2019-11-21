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
  if  (task.typeID==4||task.typeID==5||task.typeID==6)  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: RichText(
              text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: firstPlayer.name,
                        style: firstPlayer.sex== 'm'
                            ? _maletitleStyle
                            : _femaletitleStyle
                    ),
                    TextSpan(
                        text: " & ",
                        style: _titleStyle
                    ),
                    TextSpan(
                        text: secondPlayer.name,
                        style: secondPlayer.sex== 'm'
                            ? _maletitleStyle
                            : _femaletitleStyle
                    )
                  ]
              )
          ),
        )
      ],
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
                        text: firstPlayer.name,
                        style: firstPlayer.sex== 'm'
                            ? _maletitleStyle
                            : _femaletitleStyle
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
}

/*
* */