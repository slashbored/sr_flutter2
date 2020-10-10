import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/taskViewFourthRow.dart';
import 'package:sr_flutter2/textStyles.dart';
import 'generated/l10n.dart';

import 'package:sr_flutter2/betweenViewBody.dart';
import 'package:sr_flutter2/betweenViewButton.dart';
import 'package:sr_flutter2/webSocket.dart';

import 'backgroundDecorationWidget.dart';
import 'fadeTransitionRoute.dart';

class betweenViewPage extends StatefulWidget{
  @override
  betweenViewPageState createState() => new betweenViewPageState();
}

class betweenViewPageState extends State<betweenViewPage>{
  @override
  Widget build(BuildContext context)  {
    return WillPopScope(
      onWillPop: () =>  null,
      child: Container(
        decoration: backGroundDecoration,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: StreamBuilder(
                stream: downStream,
                builder: (context, snapShot)  {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Flexible(
                          child: Center(
                            child: Text(
                              //TODO: "waiting" instead of "results"
                              currentRoom.isWaiting?S.of(context).waiting:S.of(context).results,
                              textAlign: TextAlign.center,
                              style: headlineStyle,
                            ),
                          ),
                            flex: 315
                        ),
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                                child: Divider(
                                    color: Colors.black,
                                    thickness: 4
                                )
                            )
                        ),
                        Expanded(
                          flex: 315,
                          child: betweenViewBody(context),
                        ),
                        new Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                                child: Divider(
                                    color: Colors.black,
                                    thickness: 4
                                )
                            )
                        ),
                        Expanded(
                            child: Center(
                              child: betweenViewButton(context),
                            ),
                            flex: 315
                        )
                      ]
                  );
                }
            )
        ),
      )
    );
  }
}