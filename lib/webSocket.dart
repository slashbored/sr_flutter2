import 'package:web_socket_channel/io.dart';
import 'dart:async';
import 'dart:convert';
import 'package.dart';

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';

final IOWebSocketChannel WSChannel = IOWebSocketChannel.connect('wss://lucarybka.de/nodenode');
final StreamController downStreamController = new StreamController.broadcast();

Stream downStream;
Sink upStream;
Package packageIn;
String uuid = '';

void startStreaming() {
  WSChannel.stream.asBroadcastStream();
  downStreamController.addStream(WSChannel.stream);
  upStream = WSChannel.sink;
  downStream = downStreamController.stream;
  upStream.add(json.encode({'type':'get','content':'uuid'}));
  upStream.add(json.encode({'type':'ping','content':''}));

  downStream.listen((data)  {
    packageIn = Package(jsonDecode(data));
    switch(packageIn.type)  {
      case  'pong':
        upStream.add(json.encode({'type':'ping','content':''}));
        break;
      case 'uuid':
        uuid  = packageIn.content.toString();
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