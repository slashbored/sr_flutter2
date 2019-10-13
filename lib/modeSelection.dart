import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';
import 'generated/i18n.dart';
import 'onlineTestBloc.dart';
import 'dart:async';
import 'dart:convert';
import 'package.dart';

import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

import 'playerSelector.dart';


class modeSelection extends StatefulWidget{
  @override
  modeSelectionState createState() => new modeSelectionState();
}

class modeSelectionState extends State<modeSelection>{

  IOWebSocketChannel channel = IOWebSocketChannel.connect('wss://lucarybka.de/nodenode');

  TextEditingController myController = TextEditingController();
  OnlineTestBloc onlineTestBloc = OnlineTestBloc();
  StreamController mystreamController = new StreamController.broadcast();
  String uuid = '';
  var msg;

  @override
  void initState()  {
    super.initState();
    mystreamController.addStream(channel.stream);
    //uuid = _requestUUID(channel, mystreamController);
    channel.sink.add('requestUUID');
    mystreamController.stream.listen((message) {
      msg = json.decode(message);
      Package package = Package(msg);
      uuid = package.uuid;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnlineTestBloc>(
      builder: (BuildContext) => onlineTestBloc,
      child: BlocBuilder(
        bloc: onlineTestBloc,
        builder: (context, String color) {
          return new Scaffold(
            backgroundColor: Colors.white,
              body: Builder(
                  builder: (BuildContext context) {
                    return Center(
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                  child: new Center(
                                    child: new Text(
                                        S.of(context).modeSelector
                                    ),
                                  ),
                                  flex: 1
                              ),
                              new Expanded(
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      new Text(uuid),
                                      new Text(color),
                                      new TextField(
                                        controller: myController,
                                      ),
                                      new Flexible(
                                          child: new FloatingActionButton.extended(
                                              heroTag: 'FABOnline',
                                              label: Text("Get new UUID"),
                                              onPressed: () {
                                                channel.sink.add('requestUUID');
                                                mystreamController.stream.listen((message) {
                                                  msg = json.decode(message);
                                                  Package package = Package(msg);
                                                  uuid = package.uuid;
                                                });
                                              }
                                          ),
                                          flex: 1
                                      ),
                                      new Flexible(
                                          child: new FloatingActionButton.extended(
                                              heroTag: 'FABOffline',
                                              label: Text("Offline"),
                                              onPressed: () {
                                              }
                                          )
                                      ),
                                      new Row(
                                        children: <Widget>[
                                          new FloatingActionButton.extended(
                                              heroTag: 'Red',
                                              label: Text("Red"),
                                              onPressed: () {
                                                channel.sink.add('red');
                                                mystreamController.stream.listen((message)  {
                                                  msg = json.decode(message);
                                                  Package package = Package(msg);
                                                  switch (package.color)  {
                                                    case 'red':
                                                      onlineTestBloc.dispatch(switchEvent.switchToRed);
                                                      break;
                                                    case 'green':
                                                      onlineTestBloc.dispatch(switchEvent.switchToGreen);
                                                      break;
                                                    case 'blue':
                                                      onlineTestBloc.dispatch(switchEvent.switchToBlue);
                                                      break;
                                                  }
                                                });
                                              }
                                          ),
                                          new FloatingActionButton.extended(
                                              heroTag: 'Blue',
                                              label: Text("Blue"),
                                              onPressed: () {
                                                channel.sink.add('blue');
                                                mystreamController.stream.listen((message)  {
                                                  msg = json.decode(message);
                                                  Package package = Package(msg);
                                                  switch (package.color)  {
                                                    case 'red':
                                                      onlineTestBloc.dispatch(switchEvent.switchToRed);
                                                      break;
                                                    case 'green':
                                                      onlineTestBloc.dispatch(switchEvent.switchToGreen);
                                                      break;
                                                    case 'blue':
                                                      onlineTestBloc.dispatch(switchEvent.switchToBlue);
                                                      break;
                                                  }
                                                });
                                              }
                                          ),
                                          new FloatingActionButton.extended(
                                              heroTag: 'Green',
                                              label: Text("Green"),
                                              onPressed: () {
                                                channel.sink.add('green');
                                                mystreamController.stream.listen((message)  {
                                                  msg = json.decode(message);
                                                  Package package = Package(msg);
                                                  switch (package.color)  {
                                                    case 'red':
                                                      onlineTestBloc.dispatch(switchEvent.switchToRed);
                                                      break;
                                                    case 'green':
                                                      onlineTestBloc.dispatch(switchEvent.switchToGreen);
                                                      break;
                                                    case 'blue':
                                                      onlineTestBloc.dispatch(switchEvent.switchToBlue);
                                                      break;
                                                  }
                                                });
                                              }
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  flex: 1
                              )
                            ]
                        )
                    );
                  }
              )
          );
        }
      ),
    );
  }

  void _showToastComingSoon(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
        SnackBar(
          content: Text(
            S.of(context).comingSoon,
            textAlign: TextAlign.center,),
          duration: Duration(seconds: 3),
        )
    );
  }

  String _requestUUID(IOWebSocketChannel placeholderChannel, StreamController placeholderController) {
    String placeholderString;
    placeholderChannel.sink.add('requestUUID');
    placeholderController.stream.listen((message) {
      msg = json.decode(message);
      Package package = Package(msg);
      placeholderString = package.uuid;
    });
    return placeholderString;
  }
}