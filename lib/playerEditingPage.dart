import 'dart:convert';
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

class playerEditing extends StatefulWidget  {
  @override
  playerEditingState createState() => new playerEditingState();
}

class playerEditingState extends State<playerEditing>{
  final TextEditingController nameTextfieldController = TextEditingController();
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
    startStreaming();
  }

  @override
  Widget build(BuildContext context){
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
                  child: Text(
                      S.of(context).enterName,
                      textAlign: TextAlign.center,
                      style: bigStyle
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
                            controller: nameTextfieldController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                )
                            ),
                            onChanged: (value)  {
                              setState(() {
                              });
                            },
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
                  child: OutlineButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      borderSide: BorderSide(
                          width: 3,
                          color: nameTextfieldController.text!=""&&Player.mePlayer.sex!=""?Colors.green:Colors.grey,
                          style: BorderStyle.solid
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: nameTextfieldController.text!=""&&Player.mePlayer.sex!=""?Colors.black:Colors.grey,
                      ),
                      onPressed: () {
                        Player.mePlayer.name = nameTextfieldController.text.toString();
                        if  (Player.mePlayer.name!=""&&Player.mePlayer.sex!="") {
                          upStream.add(json.encode({'type':'setName','content':Player.mePlayer.name}));
                          Navigator.push(context, fadePageRoute(page: roomSelection()));
                        }
                        else  {
                          BotToast.showText(
                              duration: Duration(seconds: 2),
                              text: S.of(context).pleaseCompleteEntries
                          );
                        }
                      }
                  )
                /*FloatingActionButton(
                  onPressed: () {
                    Player.mePlayer.name = nameTextfieldController.text.toString();
                    if  (Player.mePlayer.name!=""&&Player.mePlayer.sex!="") {
                      upStream.add(json.encode({'type':'setName','content':Player.mePlayer.name}));
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => roomSelection()));
                    }
                    else  {
                      BotToast.showText(
                          duration: Duration(seconds: 2),
                          text: S.of(context).pleaseCompleteEntries
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: nameTextfieldController.text!=""&&Player.mePlayer.sex!=""?Colors.green:Colors.grey,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  highlightElevation: 0,
                ),*/
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
                              shape: CircleBorder(),
                              label: Transform.scale(scale: 0.5, child: svg_male),
                              onPressed: (){
                                setState(() {
                                  upStream.add(json.encode({'type':'setSex','content':'m'}));
                                  Player.mePlayer.sex = 'm';
                                });
                              },
                              backgroundColor: Player.mePlayer!=null&&Player.mePlayer.sex=='m'?getSexcolor(Player.mePlayer.sex):Colors.transparent,
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Transform.scale(
                            scale: 0.4,
                            child: InputChip(
                              shape: CircleBorder(),
                              label: Transform.scale(scale: 0.5, child: svg_female),
                              onPressed: (){
                                setState(() {
                                  upStream.add(json.encode({'type':'setSex','content':'f'}));
                                  Player.mePlayer.sex = 'f';
                                });
                              },
                              backgroundColor: Player.mePlayer!=null&&Player.mePlayer.sex=='f'?getSexcolor(Player.mePlayer.sex):Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
              Flexible(
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10
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
}