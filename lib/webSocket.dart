import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/roomOverviewPage.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:async';
import 'dart:convert';
import 'package.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'roomClass.dart';
import 'playerClass.dart';
import 'roomOverviewPage.dart';
import 'taskViewPage.dart';

final IOWebSocketChannel WSChannel = IOWebSocketChannel.connect('wss://lucarybka.de/nodenode');
final StreamController downStreamController = new StreamController.broadcast();

Stream downStream;
Sink upStream;
Package packageIn;
BuildContext roomOverviewContext;
BuildContext taskOverviewContext;

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
  upStream.add(jsonEncode({'type':'get','content':'createPlayer'}));
  upStream.add(json.encode({'type':'ping','content':''}));

  downStream.listen((data)  {
    packageIn = Package(jsonDecode(data));
    switch(packageIn.type)  {
      case  'pong':
        upStream.add(json.encode({'type':'ping','content':''}));
        break;
      case 'uuid':
        prefs.setString('uuid', packageIn.content.toString());
        Player.mePlayer.id  = prefs.getString('uuid');
        print(prefs.getString('uuid'));
        break;
      case 'room':
        Room.activeRoom = Room(Map.from(packageIn.content));
        break;
      case  'player':
        Player.mePlayer = Player(packageIn.content);
        break;
      case  'startGame':
        roomOverviewPageState().goToTaskViewPage(roomOverviewContext);
        break;
      case  'nextTask':
       taskViewPageState().nextTaskOnThisPage(taskOverviewContext);
       break;
    }
  });

}

