import 'package:web_socket_channel/io.dart';
import 'dart:async';
import 'dart:convert';
import 'package.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';

final IOWebSocketChannel WSChannel = IOWebSocketChannel.connect('wss://lucarybka.de/nodenode');
final StreamController downStreamController = new StreamController.broadcast();

Stream downStream;
Sink upStream;
Package packageIn;
String uuid = '';

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
    print(prefs.getString('uuid'));
  }
  upStream.add(json.encode({'type':'ping','content':''}));

  downStream.listen((data)  {
    packageIn = Package(jsonDecode(data));
    switch(packageIn.type)  {
      case  'pong':
        upStream.add(json.encode({'type':'ping','content':''}));
        break;
      case 'uuid':
        prefs.setString('uuid', packageIn.content.toString());
        //uuid  = packageIn.content.toString();
        print(prefs.getString('uuid'));
        break;
      case 'room':
        Room.activeRoom = Room(Map.from(packageIn.content));
        break;
      case  'player':
        Player.mePlayer = Player(packageIn.content);
        break;
    }
  });

}