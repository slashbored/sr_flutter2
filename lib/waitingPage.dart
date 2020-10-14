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

class waitingPage extends StatefulWidget{
  @override
  waitingPageState createState() => new waitingPageState();
}

class waitingPageState extends State<waitingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: backGroundDecoration,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: new Text(
              S.of(context).pleaseWait
            )
        )
    );
  }
}