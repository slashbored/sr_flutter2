import 'dart:convert';
import 'package:sr_flutter2/networkModeSelectionPage.dart';

import 'generated/l10n.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'backgroundDecorationWidget.dart';
import 'fadeTransitionRoute.dart';
import 'playerClass.dart';
import 'roomSelectionPage.dart';
import 'textStyles.dart';
import 'webSocket.dart';
import 'rejoinDialogWidget.dart';
import 'waitingPage.dart';
import 'taskViewPage.dart';

class playerEditingPage extends StatefulWidget  {
  @override
  playerEditingPageState createState() => new playerEditingPageState();
}

class playerEditingPageState extends State<playerEditingPage>{
  //final TextEditingController nameTextfieldController = TextEditingController();
  final Widget svg_germanFlag = SvgPicture.asset('assets/germany.svg');
  final Widget svg_britishFlag = SvgPicture.asset('assets/united-kingdom.svg');
  final Widget svg_male = SvgPicture.asset('assets/man.svg');
  final Widget svg_female = SvgPicture.asset('assets/woman.svg');


  @override
  void dispose() {
    nameTextfieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    playerEditingContext  = context;
    return Container(
      decoration: backGroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                        S.of(context).enterName,
                        textAlign: TextAlign.center,
                        style: bigStyle
                    )
                  )
              ),
              Flexible(
                  child: Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Divider(
                          color: Colors.black,
                          thickness: 2
                      )
                  )
              ),
              Flexible(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: <Widget>[
                        Spacer(
                            flex: 1
                        ),
                        Expanded(
                          flex: 3,
                          child:  TextField(
                            style: normalStyle,
                            autofocus: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: nameTextfieldController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                )
                            ),
                            onChanged: (value)  {
                              setState(() {
                                //nameTextfieldController.text=value;
                                prefs.setString('playerName', nameTextfieldController.text);
                              });
                            }
                          )
                        ),
                        Spacer(
                          flex: 1,
                        )
                      ]
                    )
                  )
              ),
              Flexible(
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white
                      ),
                      onPressed: () {
                        if  (prefs.getString('playerSex')!=""&&prefs.getString('playerName')!=""){
                          Navigator.push(context, fadePageRoute(page: networkModeSelectionPage()));
                        }
                        else  {
                          BotToast.showText(
                              duration: Duration(seconds: 2),
                              text: S.of(context).pleaseCompleteEntries
                          );
                        }
                      },
                    color: nameTextfieldController.text!=""&&prefs.getString('playerName')!=""&&prefs.getString('playerSex')!=""?Colors.green:Colors.grey,
                  )
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Align(
                    alignment: Alignment.topCenter,
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          fit: FlexFit.tight,
                          child: Transform.scale(
                            scale: 0.4,
                            child: InputChip(
                              shape: CircleBorder(
                                side: prefs.getString('playerSex')=='m'?BorderSide(
                                    width: 0,
                                    color: Colors.transparent
                                ):
                                    BorderSide(
                                      width: 10,
                                      color: Colors.grey
                                    )
                              ),
                              label: Transform.scale(scale: 0.5, child: svg_male),
                              onPressed: (){
                                setState(() {
                                  prefs.setString('playerSex', 'm');
                                });
                              },
                              backgroundColor: prefs.getString('playerSex')=='m'?getSexcolor(prefs.getString('playerSex')):Colors.transparent,
                            )
                          )
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Transform.scale(
                            scale: 0.4,
                            child: InputChip(
                              shape: CircleBorder(
                                  side: prefs.getString('playerSex')=='f'
                                      ?BorderSide(
                                        width: 0,
                                        color: Colors.transparent
                                        )
                                      :BorderSide(
                                        width: 10,
                                        color: Colors.grey
                                  )
                              ),
                              label: Transform.scale(scale: 0.5, child: svg_female),
                              onPressed: (){
                                setState(() {
                                  prefs.setString('playerSex', 'f');
                                  //upStream.add(json.encode({'type':'setSex','content':Player.mePlayer.sex}));
                                });
                              },
                              backgroundColor: prefs.getString('playerSex')=='f'?getSexcolor(prefs.getString('playerSex')):Colors.transparent,
                            )
                          )
                        )
                      ]
                    )
                )
              ),
              Flexible(
                  child: Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Divider(
                          color: Colors.black,
                          thickness: 2
                      )
                  )
              ),
              Flexible(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
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
                      )
                    )
                  )
              )
            ]
          )
        )
      )
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

  void goToWaitingPage(theContext) async {
    await new Future.delayed(const Duration(milliseconds: 500));
    Navigator.of(theContext).push(fadePageRoute(page: waitingPage()));
  }

  void goToTaskViewPage(theContext) async {
    await new Future.delayed(const Duration(milliseconds: 500));
    Navigator.of(theContext).push(fadePageRoute(page: taskViewPage()));
  }

}