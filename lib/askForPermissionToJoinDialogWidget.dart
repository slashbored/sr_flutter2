import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'generated/l10n.dart';
import 'webSocket.dart';
import 'dart:convert';
import 'playerClass.dart';

Widget AFPTJDialog(BuildContext context, String jsonstring)  {
  return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      title: Text(
          S.of(context).pleaseWait,
          textAlign: TextAlign.center,
          style: normalStyle
      ),
      children: <Widget>[
        Text(
          S.of(context).joinExistingGameAsking,
          textAlign: TextAlign.center,
          style: normalStyle,
        ),
        SimpleDialogOption(
            child: Text(
                S.of(context).cancel,
                textAlign: TextAlign.center,
                style: normalStyle
            ),
            onPressed: () {
            }
        )
      ]
  );
}