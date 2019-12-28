import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "generated/i18n.dart";
import 'dart:convert';

import'webSocket.dart';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'timerClass.dart'
;

Widget taskViewThirdRow(BuildContext context, Player firstPlayer, Player secondPlayer, Task task) {

  final TextEditingController comparisonTextController  = new TextEditingController();
  String locale;
  if  (Timer.activeTimer!=null) {
    Timer.activeTimer.FGTimeLeft  = S.of(taskOverviewContext).FGTimerGo;
  }

  if  (task.typeID==1)  {
    if  (firstPlayer.id==Player.mePlayer.id)  {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag:  "normal_denied",
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
            heroTag:  "normal_accepted",
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

  if  (task.typeID==2)  {
    Room.renewActiveTimer(context);
    if  (firstPlayer.id==Player.mePlayer.id)  {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton.extended(
              heroTag:  "normalFGTime_denied",
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
            heroTag:  "normalFGTime_startTimer",
            label: Text(Timer.activeTimer!=null?
            Timer.activeTimer.FGTimeLeft:
            S.of(context).FGTimerGo),
            onPressed:  ()  {
              startBGTimer(context);
              Room.renewActiveTimer(context);
              //Room.renewActiveTimer(context);
              /*
              upStream.add(jsonEncode({'type':'startBGTimer','content':''}));
              timerIndex  = Room.activeRoom.BGTimerDB.indexWhere((element)  =>  element.taskID==currentRoom.activeTaskID);
              if  (Room.activeRoom.BGTimerDB[timerIndex].BGTimeleft!=0) {
                FGTimeLeft  = Room.activeRoom.BGTimerDB[timerIndex].BGTimeLeft;
              }
             else {
               FGTimeLeft = S.of(context).FGTimerGo;
              }*/
            }
          ),
          FloatingActionButton.extended(
              heroTag:  "normalFGTime_accepted",
              label: Text(S.of(context).yesStyle1),
              onPressed: (){
                if (Timer.activeTimer!=null)  {
                  if (Timer.activeTimer.isRunning==true)  {
                    upStream.add(json.encode({'type':'cancelTimer','content':Timer.activeTimer.id}));
                    print("Lenght before \"deleting\": " + currentRoom.BGTimerDB.length.toString());
                    currentRoom.BGTimerDB.removeWhere((timerPlaceholder)  =>  timerPlaceholder.id ==  Timer.activeTimer.id);
                    print("Lenght after \"deleting\": " + currentRoom.BGTimerDB.length.toString());
                  }
                  Timer.activeTimer.isRunning=false;
                }
                /*Timer.activeTimer!=null?
                upStream.add(json.encode({'type':'cancelTimer','content':Timer.activeTimer.id})):
                null;*/
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayer','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
                //Navigator.of(context).push(CupertinoPageRoute(builder: (context) => taskViewPage()));
              }
          )
        ],
      );
    }
    else  {
      return Container();
    }
  }

  if  (task.typeID==3)  {
    if  (firstPlayer.id==Player.mePlayer.id)  {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton.extended(
              heroTag:  "normalBGTime_denied",
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
              heroTag:  "normalBGTime_accepted",
              label: Text(S.of(context).BGTimerGo),
              onPressed: (){
                //upStream.add(json.encode({'type':'startBGTimer','content':''}));
                startBGTimer(context);
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayer','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
                //Navigator.of(context).push(CupertinoPageRoute(builder: (context) => taskViewPage()));
              }
          )
        ],
      );
    }
    else  {
      return Container();
    }
  }

  if  (task.typeID==4||task.typeID==6)  {
    if  (firstPlayer.id==Player.mePlayer.id||secondPlayer.id==Player.mePlayer.id) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton.extended(
              heroTag:  "choice_denied",
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
              heroTag:  "choice_accepted",
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

  if  (task.typeID==5)  {
    //Room.renewActiveTimer(context);
    if  (firstPlayer.id==Player.mePlayer.id||secondPlayer.id==Player.mePlayer.id) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton.extended(
              heroTag:  "choiceFGTime_denied",
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
              heroTag:  "choiceFGTime_startTimer",
              label: Text(Timer.activeTimer!=null?Timer.activeTimer.FGTimeLeft:S.of(context).FGTimerGo),
              onPressed:  ()  {
                startBGTimer(context);
                /*
                upStream.add(jsonEncode({'type':'startBGTimer','content':''}));
                timerIndex  = Room.activeRoom.BGTimerDB.indexWhere((element)  =>  element.taskID==currentRoom.activeTaskID);
                if  (Room.activeRoom.BGTimerDB[timerIndex].BGTimeleft!=0) {
                  FGTimeLeft  = Room.activeRoom.BGTimerDB[timerIndex].BGTimeLeft;
                }
                else {
                  FGTimeLeft = S.of(context).FGTimerGo;
                }*/
              }
          ),
          FloatingActionButton.extended(
              heroTag:  "choiceFGTime_accepted",
              label: Text(S.of(context).yesStyle1),
              onPressed: (){
                /*Room.renewActiveTimer(context);
                if (Timer.activeTimer!=null)  {
                  if (Timer.activeTimer.isRunning==true)  {
                    upStream.add(json.encode({'type':'cancelTimer','content':Timer.activeTimer.id}));
                    print("Lenght before \"deleting\": " + currentRoom.BGTimerDB.length.toString());
                    currentRoom.BGTimerDB.removeWhere((timerPlaceholder)  =>  timerPlaceholder.id ==  Timer.activeTimer.id);
                    print("Lenght after \"deleting\": " + currentRoom.BGTimerDB.length.toString());
                    print(currentRoom.BGTimerDB.length.toString());
                    Timer.activeTimer.isRunning=false;
                  }
                }*/
                /*Timer.activeTimer!=null?
                upStream.add(json.encode({'type':'cancelTimer','content':Timer.activeTimer.id})):
                null;*/
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayer','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          ),
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
    Room.renewActiveTimer(context);
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
              heroTag:  "tabooMime_startTimer",
              label: Text(Timer.activeTimer!=null?
              Timer.activeTimer.FGTimeLeft:
              S.of(context).FGTimerGo),
              onPressed:  ()  {
                startBGTimer(context);
                Room.renewActiveTimer(context);
                /*
                upStream.add(jsonEncode({'type':'startBGTimer','content':''}));
                timerIndex  = Room.activeRoom.BGTimerDB.indexWhere((element)  =>  element.taskID==currentRoom.activeTaskID);
                if  (Room.activeRoom.BGTimerDB[timerIndex].BGTimeleft!=0) {
                  FGTimeLeft  = Room.activeRoom.BGTimerDB[timerIndex].BGTimeLeft;
                }
                else {
                  FGTimeLeft = S.of(context).FGTimerGo;
                }*/
              }
          ),
          FloatingActionButton.extended(
              heroTag:  "tabooMime_accepted",
              label: Text(S.of(context).tabooMimeWinStyle1),
              onPressed: () {
                if (Timer.activeTimer!=null)  {
                  if (Timer.activeTimer.isRunning==true)  {
                    upStream.add(json.encode({'type':'cancelTimer','content':Timer.activeTimer.id}));
                    currentRoom.BGTimerDB.removeWhere((timerPlaceholder)  =>  timerPlaceholder.id ==  Timer.activeTimer.id);
                  }
                  Timer.activeTimer.isRunning=false;
                }
                /*Timer.activeTimer!=null?
                upStream.add(json.encode({'type':'cancelTimer','content':Timer.activeTimer.id})):
                null;*/
                upStream.add(json.encode({'type':'randomTask','content':''}));
                upStream.add(json.encode({'type':'randomPlayer','content':''}));
                upStream.add(json.encode({'type':'nextTask','content':''}));
              }
          ),
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

void startBGTimer(BuildContext context) async {
  upStream.add(jsonEncode({'type':'startBGTimer','content':''}));
  await new Future.delayed(const Duration(milliseconds: 500));
}