import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sr_flutter2/languageSelectionPage.dart';
import 'generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'dart:convert';
import 'webSocket.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'playerEditingPage.dart';
import 'package:bot_toast/bot_toast.dart';
import 'backgroundDecorationWidget.dart';
import 'fadeTransitionRoute.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'drawingPage.dart';
import 'roomSelectionPage.dart';
import 'package:flutter/services.dart';

import 'webSocket.dart';

class networkModeSelectionPage extends StatefulWidget{
  @override
  networkModeSelectionPageState createState() => new networkModeSelectionPageState();
}

class networkModeSelectionPageState extends State<networkModeSelectionPage> {
  @override
  Widget build(BuildContext context) {
    networkEditingContext = context;
    //SystemChrome.setEnabledSystemUIOverlays([]);
    return Container(
      decoration: backGroundDecoration,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
          body: !isConnecting
          ?new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Center(
                  child: Text(
                      S.of(context).networkMode_headline,
                      textAlign: TextAlign.center,
                      style: headlineStyle
                  ),
                ),
                new FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                        "⚡ Online  ",
                        style: bigStyleWhite
                    ),
                    onPressed: () {
                      startStreaming();
                      upStream.add(json.encode({'type':'createPlayer','content':''}));
                      upStream.add(json.encode({'type':'setName','content':prefs.getString('playerName')}));
                      upStream.add(json.encode({'type':'setSex','content':prefs.getString('playerSex')}));
                      setState(() {
                        pushDelayedWithLoadingToast(context, roomSelectionPage());
                      });
                    },
                    color: Colors.green
                ),
                new FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                      "💤 Offline  ",
                      style: bigStyleWhite
                  ),
                  onPressed: () {
                    BotToast.showText(
                        text: S.of(context).comingSoon,
                        duration: Duration(seconds: 5)
                    );
                  },
                  color: Colors.red,
                ),
                new Flexible(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                              text: "Background vectors created by "
                          ),
                          TextSpan(
                              text: "macrovector",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: new TapGestureRecognizer()..onTap=  () {
                                launch('https://www.freepik.com/macrovector');
                              }
                          ),
                          TextSpan(
                              text: " and "
                          ),
                          TextSpan(
                              text: "freepik",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: new TapGestureRecognizer()..onTap=  () {
                                launch('https://www.freepik.com/freepik');
                              }
                          ),
                          TextSpan(
                              text: " from "
                          ),
                          TextSpan(
                              text: "www.freepik.com",
                              style: TextStyle(
                                  decoration: TextDecoration.underline
                              ),
                              recognizer: new TapGestureRecognizer()..onTap=  () {
                                launch('https://www.freepik.com');
                              }
                          )
                        ],
                      ),
                      textAlign: TextAlign.center,
                    )
                )
              ]
          )
          :Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
          )
      )
    );
  }

  pushDelayedWithLoadingToast(context, destinationPage) async{
    isConnecting = true;
    int i=0;
    while ((!isConnected)&&i<50){
      //BotToast.showLoading();
      await new Future.delayed(const Duration(milliseconds: 100));
      i++;
    }
    setState(() {
      isConnecting=false;
    });
    if (i==50){
        isConnecting=false;
      BotToast.showText(
        text: "Offline!",
        duration: Duration(seconds: 5)
      );
    }
    else  {
        isConnecting=false;
      Navigator.push(context, fadePageRoute(page: destinationPage));
    }
  }
}