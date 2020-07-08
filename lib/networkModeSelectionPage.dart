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
import 'drawing.dart';

class networkModeSelectionPage extends StatefulWidget{
  @override
  networkModeSelectionPageState createState() => new networkModeSelectionPageState();
}

class networkModeSelectionPageState extends State<networkModeSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backGroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Text(
                    S.of(context).networkMode_headline,
                    textAlign: TextAlign.center,
                    style: headlineStyle
                ),
                /*new FloatingActionButton.extended(
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
                ),*/
                new OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    borderSide: BorderSide(
                        width: 3,
                        color: Colors.green,
                        style: BorderStyle.solid
                    ),
                    child: Text(
                        "⚡ Online",
                        style: bigStyle
                    ),
                    onPressed: () {
                      pushToPlayerEditing(context);
                    }
                ),
                new OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    borderSide: BorderSide(
                        width: 3,
                        color: Colors.red,
                        style: BorderStyle.solid
                    ),
                    child: Text(
                        "💤 Offline",
                        style: bigStyle
                    ),
                    onPressed: () {
                      BotToast.showText(
                          text: S.of(context).comingSoon,
                          duration: Duration(seconds: 5)
                      );
                    }
                ),
                /*new FloatingActionButton.extended(
                  heroTag: "fab_offline",
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                ),*/
                /*new FloatingActionButton.extended(
                  label: Text(
                    "Draw"
                  ),
                  onPressed: (){
                    Navigator.push(context, fadePageRoute(page: Draw()));
                  }
                ),*/
                new Flexible(
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10
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
                          ]
                      ),
                    )
                  /*child: Text(
                  "Icons used are made by Freepik from www.flaticon.com",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                  ),
                ),*/
                )
              ]
          )
      )
    );
  }

  pushToPlayerEditing(context) async{
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    BotToast.showLoading(
      duration: Duration(seconds: 1)
    );
    await Future.delayed(Duration(seconds: 1  ),  ()  {});
    Navigator.push(context, fadePageRoute(page: playerEditing()));
  }
}