import 'textStyles.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'playerEditingPage.dart';
import 'package:bot_toast/bot_toast.dart';

class networkModeSelectionPage extends StatefulWidget{
  @override
  networkModeSelectionPageState createState() => new networkModeSelectionPageState();
}

class networkModeSelectionPageState extends State<networkModeSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Text(
            S.of(context).networkMode_headline,
            textAlign: TextAlign.center,
            style: headlineStyle
          ),
          new FloatingActionButton.extended(
              heroTag: "fab_online",
              label: Text(
                "⚡ Online",
                style: bigStyle
                ),
              onPressed: () {
                pushToPlayerEditing(context);
              },
            backgroundColor: Colors.transparent,
            elevation: 0,
            highlightElevation: 0,
          ),
          new FloatingActionButton.extended(
              heroTag: "fab_offline",
              label: Text(
                "💤 Offline",
                style: bigStyle
              ),
              onPressed: () {
                BotToast.showText(
                  text: S.of(context).comingSoon,
                  duration: Duration(seconds: 5)
                );
              },
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          new Container(
          )
        ]
      )
    );
  }

  pushToPlayerEditing(context) async{
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    BotToast.showLoading(
      duration: Duration(seconds: 1)
    );
    await Future.delayed(Duration(seconds: 1  ),  ()  {});
    Navigator.push(context, CupertinoPageRoute(builder: (context) => playerEditing()));
  }
}