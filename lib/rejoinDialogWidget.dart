import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'generated/l10n.dart';
import 'webSocket.dart';
import 'dart:convert';
import 'playerClass.dart';

List splitStringList;

Widget rejoinDialog(BuildContext context, String jsonstring)  {
  splitStringList = jsonstring.split(";");
  return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      title: Text(
          S.of(context).rejoinQ,
          textAlign: TextAlign.center,
          style: normalStyle
      ),
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: normalStyle,
            children: <TextSpan>[
              TextSpan(
                text: S.of(context).rejoin1
              ),
              TextSpan(
                text: splitStringList[1]
              ),
              TextSpan(
                  text: S.of(context).rejoin2
              ),
              TextSpan(
                  text: splitStringList[0]
              ),
              TextSpan(
                  text: "\"?"
              )
            ]
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SimpleDialogOption(
                child: Text(
                  S.of(context).noStyle1,
                  textAlign: TextAlign.center,
                  style: normalStyleRed
                ),
                onPressed: () {
                  upStream.add(json.encode({'type':'denyRejoin','content':Player.mePlayer.id.toString()}));
                  Navigator.pop(context);
                }
              )
            ),
            Expanded(
              child: SimpleDialogOption(
                child: Text(
                  "OK",
                  textAlign: TextAlign.center,
                  style: normalStyle
                ),
                onPressed: () {
                  upStream.add(json.encode({'type':'acceptRejoin','content':Player.mePlayer.id.toString()}));
                  Navigator.pop(context);
                }
              )
            )
          ]
        )
      ]
  );
}

// TODO: freeze game when player wants to (re-)join, implement rejoin first, join afterwards, ask GM, unnecessary if autojoin, show dialog for new player wanting to join on gms app
// TODO: make it a notification