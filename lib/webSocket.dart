import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/roomOverviewPage.dart';
import 'package:web_socket_channel/io.dart';
import 'package:async/async.dart';
import 'dart:async';
import 'dart:convert';
import 'package.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'timerClass.dart';

import 'roomOverviewPage.dart';
import 'taskViewPage.dart';

final IOWebSocketChannel WSChannel = IOWebSocketChannel.connect('wss://lucarybka.de/nodenode');
final StreamController downStreamController = new StreamController.broadcast();

Sink upStream;
Stream downStream;
RestartableTimer heartBeatTimer;
Package packageIn;
BuildContext roomOverviewContext;
BuildContext taskOverviewContext;
Room currentRoom;

void startStreaming() async{
  WSChannel.stream.asBroadcastStream();
  downStreamController.addStream(WSChannel.stream);
  upStream = WSChannel.sink;
  downStream = downStreamController.stream;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getString('uuid')==null)  {
    upStream.add(json.encode({'type':'get','content':'uuid'}));
  }
  else  {
    upStream.add(json.encode({'type':'setUUID','content':prefs.getString('uuid').toString()}));
  }
  upStream.add(json.encode({'type':'createPlayer','content':''}));
  heartBeatTimer = Timer.periodic(Duration(seconds:30), (Timer t) => upStream.add(json.encode({'type':'hb','content':''})));

  downStream.listen((data)  {
    packageIn = Package(jsonDecode(data));
    switch(packageIn.type)  {
      case 'uuid':
        prefs.setString('uuid', packageIn.content.toString());
        Player.mePlayer.id  = prefs.getString('uuid');
        break;
      case 'room':
        Room.activeRoom = Room(Map.from(packageIn.content));
        currentRoom = Room.activeRoom;
        break;
      case  'timerUpdate':
        currentRoom.BGTimerDB.clear();
        List.from(packageIn.content).forEach((timerPlaceHolder) => (currentRoom.BGTimerDB.insert(currentRoom.BGTimerDB.length, customTimer(timerPlaceHolder))));
        if  (currentRoom.BGTimerDB.length>0)  {
          customTimer.updateStateMap();
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
      case 'playerDB':
        currentRoom.playerDB.clear();
        List.from(packageIn.content).forEach((playerPlaceHolder) => (currentRoom.playerDB.insert(currentRoom.playerDB.length, Player(playerPlaceHolder))));
        break;
      case 'taskDB':
        currentRoom.taskDB.clear();
        List.from(packageIn.content).forEach((taskPlaceHolder) => (currentRoom.taskDB.insert(currentRoom.taskDB.length, Task(taskPlaceHolder))));
        break;
      case 'activeTaskID':
        currentRoom.activeTaskID  = packageIn.content;
        break;
      case 'activePlayerID':
        currentRoom.activePlayerID  = packageIn.content;
        break;
      case 'activeSecondPlayerID':
        currentRoom.activeSecondPlayerID  = packageIn.content;
        break;
      case  'yourPlayer':
        Player.mePlayer = Player(packageIn.content);
        break;
      case  'startGame':
        roomOverviewPageState().goToTaskViewPage(roomOverviewContext);
        break;
      case  'nextTask':
        heartBeatTimer.reset();
        currentRoom.winnerIDArray.clear();
        currentRoom.compareWinnerSide=null;
        Player.mePlayer.compareValue=null;
        taskViewPageState().nextTaskOnThisPage(taskOverviewContext);
        break;
    }
  });
}