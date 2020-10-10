import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'generated/l10n.dart';
import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'backgroundDecorationWidget.dart';
import 'fadeTransitionRoute.dart';
import 'dart:io';

import 'webSocket.dart';
import 'roomOverviewPage.dart';

class roomSelection extends StatefulWidget{
  @override
  roomSelectionPage createState() => new roomSelectionPage();
}

class roomSelectionPage extends State<roomSelection>{

  final TextEditingController joinroomTextfieldController = TextEditingController();

  @override
  void initState()  {
    super.initState();
  }

  @override
  void dispose() {
    joinroomTextfieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    roomSelectionContext = context;
    return Container(
      decoration: backGroundDecoration,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: StreamBuilder(
              stream: downStream,
              builder: (context, snapShot){
                return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                              flex: 2,
                              child: Center(
                                  child: Row(
                                      children: <Widget>[
                                        Spacer(
                                            flex: 1
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                      S.of(context).createRoom,
                                                      textAlign: TextAlign.center,
                                                      style: normalStyle
                                                  ),
                                                  FlatButton(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white
                                                      ),
                                                      onPressed: () {
                                                        createRoom();
                                                      }
                                                      ,color: Colors.green,
                                                  )
                                                ]
                                            )
                                        ),
                                        Spacer(
                                            flex: 1
                                        )
                                      ]
                                  )
                              )
                          ),
                          Flexible(
                              flex: 1,
                              child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(left: 20.0, right: 20.0),
                                            child: Divider(
                                                color: Colors.black,
                                                thickness: 2
                                            )
                                        )
                                    ),
                                    Text(
                                        S.of(context).or,
                                        style: normalStyle
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(left: 20.0, right: 20.0),
                                            child: Divider(
                                                color: Colors.black,
                                                thickness: 4
                                            )
                                        )
                                    )
                                  ]
                              )
                          ),
                          Flexible(
                              flex: 2,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                        children: <Widget>[
                                          Spacer(
                                              flex: 1
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                  S.of(context).joinRoom,
                                                  textAlign: TextAlign.center,
                                                  style: normalStyle
                                              )
                                          ),
                                          Spacer(
                                              flex: 1
                                          )
                                        ]
                                    ),
                                    Center(
                                        child: Row(
                                            children: <Widget>[
                                              Spacer(),
                                              Expanded(
                                                  child: TextField(
                                                      onChanged: (text) {
                                                        setState(() {}); //dirty way
                                                      },
                                                      textAlign: TextAlign.center,
                                                      controller: joinroomTextfieldController,
                                                      keyboardType: TextInputType.numberWithOptions(
                                                          decimal: true,
                                                          signed: false
                                                      ),
                                                      decoration: InputDecoration(
                                                        hintText: S.of(context).joinRoom_hintText,
                                                        border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            width: 10,
                                                            color: joinroomTextfieldController.text==""||joinroomTextfieldController.text==null?
                                                                Colors.grey:
                                                                Colors.black
                                                          )
                                                        )
                                                      )
                                                  )
                                              ),
                                              Spacer()
                                            ]
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
                                              if (joinroomTextfieldController.text==""||joinroomTextfieldController.text==null)  {
                                                BotToast.showText(
                                                    text: S.of(context).joinRoom_enterNumber,
                                                    duration: Duration(seconds: 5)
                                                );
                                              }
                                              else  {
                                                upStream.add(json.encode({'type':'joinRoom','content':joinroomTextfieldController.text.toString()}));
                                                joinRoom();
                                              }
                                            },
                                          color: joinroomTextfieldController.text==""?Colors.grey:Colors.blue,
                                        )
                                    )
                                  ]
                              )
                          )
                        ]
                    )
                );
              }
          )
      )
    );
  }

void createRoom() async{
  upStream.add(json.encode({'type':'createRoom','content':''}));
  await new Future.delayed(const Duration(milliseconds: 500));
  if (Platform.isIOS) {
    print("it ios!");
    Navigator.push(context, CupertinoPageRoute(builder: (context)  => roomOverviewPage()));
  }
  else  {
    Navigator.push(context, fadePageRoute(page: roomOverviewPage()));
  }
}

  void joinRoom() async{
    int i = 0;
    while (currentRoom==null&&i<50){
      await new Future.delayed(const Duration(milliseconds: 100));
      i++;
    }
    if (Platform.isIOS) {
      print("its ios!");
      currentRoom!=null&&i<50?Navigator.push(context, CupertinoPageRoute(builder: (context)  => roomOverviewPage())):null;
    }
    else  {
      currentRoom!=null&&i<50?Navigator.push(context, fadePageRoute(page: roomOverviewPage())):null;
    }
  }
}