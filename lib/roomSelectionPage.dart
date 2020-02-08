import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'generated/i18n.dart';
import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';


import 'webSocket.dart';
import 'roomClass.dart';
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
    return Scaffold(
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
                          flex: 1,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            S.of(context).createRoom,
                            textAlign: TextAlign.center,
                            style: normalStyle,
                          )
                        ),
                        Expanded(
                          flex: 1,
                          child: FloatingActionButton.extended(
                            heroTag:'fab_createRoom',
                            label: Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              upStream.add(json.encode({'type':'createRoom','content':''}));
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => roomOverviewPage()));
                            },
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            highlightElevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  //fit: FlexFit.tight,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10.0, right: 20.0),
                          child: Divider(
                              color: Colors.black,
                              thickness: 2
                          ),
                        ),
                      ),
                      Text(
                        S.of(context).or,
                        style: normalStyle
                      ),
                      Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                                color: Colors.black,
                                thickness: 2
                            ),
                          )
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              S.of(context).joinRoom,
                              textAlign: TextAlign.center,
                              style: normalStyle
                            )
                          ),
                          Expanded(
                            flex: 1,
                            child: FloatingActionButton.extended(
                              heroTag:'fab_joinRoom',
                              label:  Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.green,
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
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              highlightElevation: 0
                            )
                          )
                        ]
                      ),
                      Center(
                        child: Row(
                          children: <Widget>[
                            Spacer(),
                            Expanded(
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: joinroomTextfieldController,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: false
                                ),
                                decoration: InputDecoration(
                                  hintText: S.of(context).joinRoom_hintText,
                                ),
                              ),
                            ),
                            Spacer()
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]
            )
          );
        }
      )
    );
  }

  void joinRoom() async{
    int i = 0;
    while (currentRoom==null&&i<50){
      await new Future.delayed(const Duration(milliseconds: 100));
      i++;
    }
    currentRoom!=null&&i<50?Navigator.push(context, CupertinoPageRoute(builder: (context) => roomOverviewPage())):null;
  }
}