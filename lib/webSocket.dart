import 'package:sr_flutter2/drawingPointsClass.dart';
import 'package:sr_flutter2/menuDialogWidget.dart';

import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/roomOverviewPage.dart';
import 'package:web_socket_channel/io.dart';
import 'package:async/async.dart';
import 'generated/l10n.dart';
import 'dart:async';
import 'dart:convert';
import 'package.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bot_toast/bot_toast.dart';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'customTimerClass.dart';

import 'playerEditingPage.dart';
import 'roomOverviewPage.dart';
import 'taskViewPage.dart';
import 'rejoinDialogWidget.dart';
import 'timerViewDialogWidget.dart';
import 'timerDoneDialogWidget.dart';
import 'drawing.dart';
import 'drawingPointsClass.dart';

final IOWebSocketChannel WSChannel = IOWebSocketChannel.connect('wss://lucarybka.de/nodenode');
final StreamController downStreamController = new StreamController.broadcast();

Sink upStream;
Stream downStream;
RestartableTimer heartBeatTimer;
Package packageIn;
BuildContext playerEditingContext;
BuildContext roomSelectionContext;
BuildContext roomOverviewContext;
BuildContext taskViewPageContext;
Room currentRoom;
List<Task> endedTaskList = new List();
List<DrawingPoints> pointList = new List();

void heartBeat()  {
  upStream.add(json.encode({'type':'hb','content':''}));
  heartBeatTimer.reset();
}

void startStreaming() async{
  //start the stream/sink and create a sharedprefs instance
  WSChannel.stream.asBroadcastStream();
  downStreamController.addStream(WSChannel.stream);
  upStream = WSChannel.sink;
  downStream = downStreamController.stream;
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // if UUID is present, send it to the server, else get one
  if(prefs.getString('uuid')==null)  {
    upStream.add(json.encode({'type':'getUUID','content':''}));
  }
  else  {
    upStream.add(json.encode({'type':'setUUID','content':prefs.getString('uuid').toString()}));
  }

  //heartBeatTimer (really just a ping every 20 seconds)
  upStream.add(json.encode({'type':'createPlayer','content':''}));
  heartBeatTimer = RestartableTimer(Duration(seconds:20), () => heartBeat());

  //listen for incoming packages
  downStream.listen((data)  {
    packageIn = Package(jsonDecode(data));
    switch(packageIn.type)  {

      //Updates
      //send points to WS server
      case 'paintingOffsetsAdd':
        print(packageIn.content);
        if (packageIn.content==null)  {
          pointList.add(null);
        }
        else  {
          pointList.add(DrawingPoints(packageIn.content));
        }
        break;
      case 'isTouchy':
        currentRoom.isTouchy  = packageIn.content;
        break;
      case  'startGame':
        roomOverviewPageState().goToTaskViewPage(roomOverviewContext);
        break;
      case  'nextTask':
        heartBeatTimer.reset();
        if (currentRoom.winnerIDArray!=null)  {
          currentRoom.winnerIDArray.clear();
        }
        currentRoom.compareWinnerSide = null;
        Player.mePlayer.compareValue  = null;
        if (timerViewDialogOpen)  {
          Navigator.of(taskViewPageContext).pop();
          timerViewDialogOpen = false;
        }
        if (settingsMenuOpen) {
          Navigator.of(menuDialogContext).pop();
          settingsMenuOpen  = false;
        }
        if (timerDoneDialogOpen!=null)  {
          if (timerDoneDialogOpen)  {
            Navigator.of(timerDoneDialogContext).pop();
            timerDoneDialogOpen = false;
          }
        }
        taskViewPageState().nextTaskOnThisPage(taskViewPageContext);
        break;
      case 'timerDone':
        // TODO: create stack/db (?) of done timers for specific player to show dialogs accordingly
        CustomTimer endedTimer  = currentRoom.BGTimerDB.firstWhere((element) => element.id  ==  packageIn.content);
        Task endedTask  = currentRoom.taskDB.firstWhere((element) => element.id  ==  endedTimer.taskID);
        if ((endedTimer.playerID==Player.mePlayer.id||endedTimer.secondPlayerID==Player.mePlayer.id)&&(endedTask.typeID==3||endedTask.typeID==6)) {
          endedTimer.playerID ==  Player.mePlayer.id?first=true:first=false;
          taskString  = Task.getStringByLocale(endedTask, Localizations.localeOf(taskViewPageContext).toString(), first?'completeString_active':'completeString_passive');
          if (endedTimer.secondPlayerID!=null&&endedTimer.secondPlayerID!="")  {
            otherPlayer = currentRoom.playerDB.firstWhere((element) => element.id ==  (first?endedTimer.secondPlayerID:endedTimer.playerID));
            List splitStringList = taskString.split("\$placeholder");
            doneText  =  RichText(
              //textAlign: TextAlign.center,
              text: TextSpan(
                  style: normalStyle,
                  children: [
                    TextSpan(
                        text: splitStringList[0]
                    ),
                    TextSpan(
                        style: TextStyle(
                            color: otherPlayer.color,
                            fontSize: 24
                        ),
                        text: otherPlayer.name
                    ),
                    TextSpan(
                        text: splitStringList[1]
                    )

                  ]
              ),
            );
          }
          else  {
            doneText  =  RichText(
              //textAlign: TextAlign.center,
              text: TextSpan(
                  style: normalStyle,
                  text: taskString
              ),
            );
          }
          /*if (endedTaskList.contains(endedTask)==false)  {
          endedTaskList.add(endedTask); //check here if its being added and persists after deletion, work from there
          print(endedTask);
        }*/
          BotToast.showNotification(
              leading: (cancel) => SizedBox.fromSize(
                  size: const Size(40, 40),
                  child: Text("👍🏻",
                  style: TextStyle(
                    fontSize: 40
                  ),)
              ),
              title: (_) => Text(
                S.of(taskViewPageContext).justDone,
                style: normalStyle,
              ),
              subtitle: (_) => doneText,
              trailing: (cancel) => IconButton(
                icon: Icon(Icons.cancel),
                onPressed: cancel,
              ),
              enableSlideOff: true,
              crossPage: false,
              contentPadding: EdgeInsets.all(1),
              onlyOne: false,
              animationDuration: Duration(milliseconds: 200),
              animationReverseDuration: Duration(milliseconds: 200),
              duration: Duration(seconds: 20));
          /*timerDoneDialogOpen = true;
          showDialog(
              context: taskViewPageContext,
              barrierDismissible: false,
              //before: builder: (BuildContext) =>  timerDoneDialog(taskViewPageContext, endedTask, endedTimer)
              builder: (BuildContext) =>  timerDoneDialog(taskViewPageContext, endedTaskList[endedTaskList.length-1], endedTimer)
          );*/
        }
        break;
      case 'isWaiting':
        currentRoom.isWaiting = packageIn.content;
        break;
      case  'winnerIDArrayUpdate':
        currentRoom.winnerIDArray.clear();
        List.from(packageIn.content).forEach((playerplaceholder)  =>(currentRoom.winnerIDArray.insert(currentRoom.winnerIDArray.length, Player(playerplaceholder))));
        break;
      case  'compareWinnerSideUpdate':
        currentRoom.compareWinnerSide = packageIn.content;
        break;

      case 'choseToDrink':
        Player drinkingPlayer=currentRoom.playerDB.firstWhere((player) => player.id==packageIn.content);
        if (drinkingPlayer.id!=Player.mePlayer.id)  {
          BotToast.showCustomText(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.transparent,
              toastBuilder: (_) => LayoutBuilder(
                  builder: (BuildContext context,  BoxConstraints constraints)  {
                    return Container(
                        padding: EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 7),
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: normalStyle,
                                children:[
                                  TextSpan(
                                      text: drinkingPlayer.name,
                                      style: TextStyle(
                                          color: drinkingPlayer.color
                                      )
                                  ),
                                  TextSpan(
                                      text: S.of(context).choseToDrink
                                  )
                                ]
                            )
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.all(
                                Radius.circular(8)
                            )
                        ),
                        constraints: constraints.copyWith(
                            maxWidth: constraints.biggest.width * 0.6
                        )
                    );
                  }
              )
          );
        }
        break;
      case 'playerLeft':
        Player leftPlayer=currentRoom.playerDB.firstWhere((player) => player.id==packageIn.content);
        BotToast.showCustomText(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.transparent,
            toastBuilder: (_) => LayoutBuilder(
                builder: (BuildContext context,  BoxConstraints constraints)  {
                  return Container(
                      padding: EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 7),
                      child: RichText(
                          text: TextSpan(
                              style: normalStyle,
                              children:[
                                TextSpan(
                                    text: leftPlayer.name,
                                    style: TextStyle(
                                        color: leftPlayer.color
                                    )
                                ),
                                TextSpan(
                                    text: S.of(context).hasLeftGame
                                )
                              ]
                          )
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.all(
                              Radius.circular(8)
                          )
                      ),
                      constraints: constraints.copyWith(
                          maxWidth: constraints.biggest.width * 0.6
                      )
                  );
                }
            )
        );
        break;
      case 'newGM':
        currentRoom.gmID  = packageIn.content;
        Player newGM=currentRoom.playerDB.firstWhere((player) => player.id==packageIn.content);
        Future.delayed(Duration(seconds: 5), () {
          BotToast.showCustomText(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.transparent,
              toastBuilder: (_) => LayoutBuilder(
                  builder: (BuildContext context,  BoxConstraints constraints)  {
                    return Container(
                        padding: EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 7),
                        child: RichText(
                            text: TextSpan(
                                style: normalStyle,
                                children:[
                                  TextSpan(
                                      text: newGM.name,
                                      style: TextStyle(
                                          color: newGM.color
                                      )
                                  ),
                                  TextSpan(
                                      text: S.of(context).isNewGM
                                  )
                                ]
                            )
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.all(
                                Radius.circular(8)
                            )
                        ),
                        constraints: constraints.copyWith(
                            maxWidth: constraints.biggest.width * 0.6
                        )
                    );
                  }
              )
          );
        });
        break;


      //Data packages in general
      case 'uuid':
        prefs.setString('uuid', packageIn.content.toString());
        Player.mePlayer.id  = prefs.getString('uuid');
        break;
      case  'yourPlayer':
        Player.mePlayer = Player(packageIn.content);
        break;
      case 'room':
        Room.activeRoom = Room(Map.from(packageIn.content));
        currentRoom = Room.activeRoom;
        break;

      //ID packages
      case 'activeTaskID':
        currentRoom.activeTaskID  = packageIn.content;
        break;
      case 'activePlayerID':
        currentRoom.activePlayerID  = packageIn.content;
        break;
      case 'activeSecondPlayerID':
        currentRoom.activeSecondPlayerID  = packageIn.content;
        break;


      //DB packages
      case 'playerDB':
        currentRoom.playerDB.clear();
        List.from(packageIn.content).forEach((playerPlaceHolder) => (currentRoom.playerDB.insert(currentRoom.playerDB.length, Player(playerPlaceHolder))));
        break;
      case 'taskDB':
        currentRoom.taskDB.clear();
        List.from(packageIn.content).forEach((taskPlaceHolder) => (currentRoom.taskDB.insert(currentRoom.taskDB.length, Task(taskPlaceHolder))));
        break;
      case  'BGTimerDB':
        if (currentRoom!=null)  {
          if (currentRoom.BGTimerDB!=null)  {
            currentRoom.BGTimerDB.clear();
          }
          List.from(packageIn.content).forEach((timerPlaceHolder) => (currentRoom.BGTimerDB.insert(currentRoom.BGTimerDB.length, CustomTimer(timerPlaceHolder))));
          if  (currentRoom.BGTimerDB.length>0)  {
            CustomTimer.updateStateMap();
          }
        }
        break;


      //Misc
      case 'rejoinYesNo':
        Package cachedPackage = packageIn;
        showDialog(
            barrierDismissible: false,
            context: playerEditingContext,
            builder: (BuildContext) =>  rejoinDialog(playerEditingContext, cachedPackage.content.toString())
        );
        break;
      case 'rejoin':
        Room.activeRoom = Room(Map.from(packageIn.content));
        Player.mePlayer = Room.activeRoom.playerDB.firstWhere((player) => Player.mePlayer.id  ==  player.id);
        currentRoom=Room.activeRoom;
        playerEditingPageState().goToTaskViewPage(playerEditingContext);
        break;
      case 'youWon':
        showDialog(
            context: taskViewPageContext,
            builder: (BuildContext context) => CupertinoAlertDialog(
                content: Text("You won, yay."),
                actions: <Widget>[
                  FlatButton(
                      child: Text(
                          "K"
                      ),
                      onPressed: () {
                        taskViewPageState().goHome(taskViewPageContext);
                        currentRoom = null;
                      }
                  )
                ]
            )
        );
        break;
    }
  });
}