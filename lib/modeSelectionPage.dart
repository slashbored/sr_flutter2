import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sr_flutter2/languageSelectionPage.dart';
import 'generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'generated/i18n.dart';
import 'dart:convert';
import 'webSocket.dart';

class modeSelectionPage extends StatefulWidget{
  @override
  modeSelectionPageState createState() => new modeSelectionPageState();
}

class modeSelectionPageState extends State<modeSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            S.of(context).modeTitle_headline,
            style: TextStyle(
              fontSize: 36
            ),
            textAlign: TextAlign.center,
          ),
          new FloatingActionButton.extended(
            heroTag: "endless",
            onPressed: () {
              upStream.add(json.encode({'type':'setMode','content':'endless'}));
              upStream.add(json.encode({'type':'startGame','content':''}));
            },
            label: Text(
              S.of(context).modeTitle_endless
            )
          ),
          new FloatingActionButton.extended(
            heroTag: "reachPoints",
            onPressed: () {
              //upStream.add(json.encode({'type':'setMode','content':'reachPoints'}));
              //upStream.add(json.encode({'type':'startGame','content':''}));
            },
            label: Text(
              S.of(context).modeTitle_reach
            )
          ),
          new FloatingActionButton.extended(
              heroTag: "losePoints",
            onPressed: () {
              //upStream.add(json.encode({'type':'setMode','content':'losePoints'}));
              //upStream.add(json.encode({'type':'startGame','content':''}));
            },
            label: Text(
              S.of(context).modeTitle_lose
            )
          )
        ],
      ),
    );
  }
}