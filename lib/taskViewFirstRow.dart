import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'roomClass.dart';
import 'playerClass.dart';

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

Widget taskViewFirstRow(BuildContext context, Player firstPlayer) {
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
              )
            ]
          )
        ),
      )
    ],
  );
}