import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'localizationBloc.dart';
import 'languageSelectionPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'webSocket.dart';
import 'playerClass.dart';
import 'roomSelectionPage.dart';

class playerEditing extends StatefulWidget  {
  @override
  playerEditingState createState() => new playerEditingState();
}

class playerEditingState extends State<playerEditing>{
  final TextEditingController nameTextfieldController = TextEditingController();
  final Widget svg_germanFlag = SvgPicture.asset(
    'assets/germany.svg',
    semanticsLabel: 'German flag',
  );
  final Widget svg_britishFlag = SvgPicture.asset(
    'assets/united-kingdom.svg',
    semanticsLabel: 'German flag',
  );

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameTextfieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startStreaming();

  }

  @override
  Widget build(BuildContext context){
    WidgetsBinding.instance.addPostFrameCallback((_) => _insertOverlay(context));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child:               Row(
                    children: <Widget>[
                      Spacer(
                          flex: 1
                      ),
                      Flexible(
                        child:  TextField(
                          controller: nameTextfieldController,
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      )
                    ],
                  ),
                )
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.topCenter,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InputChip(
                        label: Text(S.of(context).sexMale),
                        onPressed: (){
                          setState(() {
                            //upStream.add(json.encode({'type':'setName','content':Player.activePlayer.name}));
                            upStream.add(json.encode({'type':'setSex','content':'m'}));
                            Player.mePlayer.sex = 'm';
                          });
                        },
                        backgroundColor: Player.mePlayer!=null&&Player.mePlayer.sex=='m'?getSexcolor(Player.mePlayer.sex):Colors.grey,
                      ),
                      InputChip(
                        label: Text(S.of(context).sexFemale),
                        onPressed: (){
                          setState(() {
                            upStream.add(json.encode({'type':'setSex','content':'f'}));
                            Player.mePlayer.sex = 'f';
                          });
                        },
                        backgroundColor: Player.mePlayer!=null&&Player.mePlayer.sex=='f'?getSexcolor(Player.mePlayer.sex):Colors.grey,
                      ),
                    ],
                  )
                ),
              ),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12
                    ),
                    children: [
                      TextSpan(
                        text: "Icons used are made by "
                      ),
                      TextSpan(
                        text: "Freepik",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: new TapGestureRecognizer()..onTap=  () {
                          launch('https://www.flaticon.com/authors/freepik');
                        }
                      ),
                      TextSpan(
                        text: " from "
                      ),
                      TextSpan(
                        text: "www.flaticon.com",
                        style: TextStyle(
                          decoration: TextDecoration.underline
                        ),
                          recognizer: new TapGestureRecognizer()..onTap=  () {
                            launch('https://www.flaticon.com');
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
            ],
          ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Player.mePlayer.name = nameTextfieldController.text.toString();
          if  (Player.mePlayer.name!=""&&Player.mePlayer.sex!="") {
            upStream.add(json.encode({'type':'setName','content':Player.mePlayer.name}));
            Navigator.push(context, CupertinoPageRoute(builder: (context) => roomSelection()));
          }
          else  {
           showDialog(
             context: context,
             builder: (BuildContext context) => CupertinoAlertDialog(
               content: Text(S.of(context).pleaseCompleteEntries)
             )
           );
          }
        },
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: Colors.black,
      ),
    );
  }

  void switchLanguage(BuildContext context) {
    if (Localizations.localeOf(context).toString()=='en_'||Localizations.localeOf(context).toString()=='en')  {
      languageSelectionState.localizationBloc.dispatch(switchEvent.switchToDe);
    }
    else  {
      languageSelectionState.localizationBloc.dispatch(switchEvent.switchToEn);
    }
  }

  void _insertOverlay(BuildContext context) {
    print(Localizations.localeOf(context).toString());
    return Overlay.of(context).insert(
      OverlayEntry(builder: (context) {
        final size = MediaQuery
            .of(context)
            .size;
        return Positioned(
          width: 56,
          height: 56,
          top: 36,
          left: size.width - 72,
          child: Transform.scale(
            scale: 0.5,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () => switchLanguage(context),
                child: Container(
                  child: svg_germanFlag,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Color getSexcolor(String sex) {
    switch  (sex) {
      case 'm':
        return Colors.blue;
        break;
      case 'f':
        return Colors.red;
        break;
      case 'o':
        return Colors.green;
        break;
    }
  }
}