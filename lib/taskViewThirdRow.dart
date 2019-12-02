import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "generated/i18n.dart";
import 'dart:convert';

import'webSocket.dart';

import 'playerClass.dart';
import 'taskClass.dart';


Widget taskViewThirdRow(BuildContext context, Player firstPlayer, Player secondPlayer, Task task) {

  final TextEditingController comparisonTextController  = new TextEditingController();
  String locale;

  if  (task.typeID==1||task.typeID==2||task.typeID==3)  {
    if  (firstPlayer.id==Player.mePlayer.id)  {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag:  "denied_normal",
            label: Text(S.of(context).noStyle1),
            onPressed: (){
              //firstPlayer.points++;
              upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
              upStream.add(json.encode({'type':'randomTask','content':''}));
              upStream.add(json.encode({'type':'randomPlayer','content':''}));
              upStream.add(json.encode({'type':'nextTask','content':''}));
              //Navigator.of(context).push(CupertinoPageRoute(builder: (context) => taskViewPage()));
            }
          ),
          FloatingActionButton.extended(
            heroTag:  "accepted_normal",
            label: Text(S.of(context).yesStyle1),
            onPressed: (){
              upStream.add(json.encode({'type':'randomTask','content':''}));
              upStream.add(json.encode({'type':'randomPlayer','content':''}));
              upStream.add(json.encode({'type':'nextTask','content':''}));
              //Navigator.of(context).push(CupertinoPageRoute(builder: (context) => taskViewPage()));
            }
          )
        ],
      );
    }
  }
  if  (task.typeID==4||task.typeID==5||task.typeID==6)  {
    if  (firstPlayer.id==Player.mePlayer.id||secondPlayer.id==Player.mePlayer.id) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton.extended(
              heroTag:  "denied_choice",
              label: Text(S.of(context).noStyle2),
              onPressed: (){
                //firstPlayer.id==Player.mePlayer.id?firstPlayer.points++:secondPlayer.points++;
                upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayer','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          ),
          FloatingActionButton.extended(
              heroTag:  "accepted_choice",
              label: Text(S.of(context).yesStyle1),
              onPressed: (){
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayer','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          )
        ],
      );
    }
    else  {
      return Container();
    }
  }
  if  (task.typeID==7)  {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Spacer(
              flex: 2,
            ),
            Flexible(
              child: TextField(
                controller: comparisonTextController,
              ),
            ),
            Spacer(
              flex: 2,
            )
          ],
        ),
        FloatingActionButton.extended(
          heroTag: "comparison_submit",
          label:  Text("Ok"),
          onPressed: () {
            comparisonTextController.clear();
            upStream.add(json.encode({'type':'randomTask','content':''}));
            upStream.add(json.encode({'type':'randomPlayer','content':''}));
            upStream.add(json.encode({'type':'nextTask','content':''}));

          },
        )
      ],
    );
  }
  if  (task.typeID==8)  {
    return Center(
        child: FloatingActionButton.extended(
          heroTag:  "listFailed",
            label:  Text(
              "️🤷🏼‍♀️",
              style: TextStyle(
                fontSize: 27
              ),
            ),
            onPressed:  ()  {
              upStream.add(json.encode({'type':'pointsInc','content':Player.mePlayer.id.toString()}));
              upStream.add(json.encode({'type':'randomTask','content':''}));
              upStream.add(json.encode({'type':'randomPlayer','content':''}));
              upStream.add(json.encode({'type':'nextTask','content':''}));
            })
    );
  }
  if  (task.typeID==9||task.typeID==10) {
    if  (firstPlayer.id==Player.mePlayer.id)  {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton.extended(
              heroTag:  "tabooMime_denied",
              label: Text(S.of(context).tabooMimeFailStyle1),
              onPressed: () {
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayer','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          ),
          FloatingActionButton.extended(
              heroTag:  "starTimer",
              label: Text("Lego"),
              onPressed:  ()  {
                upStream.add(jsonEncode({'type':'startFGTimer','content':''}));
              },
          ),
          FloatingActionButton.extended(
              heroTag:  "tabooMime_accepted",
              label: Text(S.of(context).tabooMimeWinStyle1),
              onPressed: () {
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayer','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          )
        ],
      );
    }
    else  {
      return  Container();
    }
  }
  if  (task.typeID==11) {
    locale = Localizations.localeOf(context).toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FloatingActionButton.extended(
          heroTag: "wyr_a",
          label: Text(Task.getStringByLocale(task, locale, "wyr_a")),
          onPressed: () {
            upStream.add(json.encode({'type':'randomTask','content':''}));
            upStream.add(json.encode({'type':'randomPlayer','content':''}));
            upStream.add(json.encode({'type':'nextTask','content':''}));
          },
        ),
        FloatingActionButton.extended(
          heroTag: "wyr_b",
          label: Text(Task.getStringByLocale(task, locale, "wyr_b")),
          onPressed: () {
            upStream.add(json.encode({'type':'randomTask','content':''}));
            upStream.add(json.encode({'type':'randomPlayer','content':''}));
            upStream.add(json.encode({'type':'nextTask','content':''}));
          },
        )
      ],

    );
  }
  else  {
    return Container();
  }
}