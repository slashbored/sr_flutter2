import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';
import 'generated/i18n.dart';
import 'onlineTestBloc.dart';
import 'dart:async';
import 'dart:convert';
import 'package.dart';
import 'roomClass.dart';
import 'playerClass.dart';
import 'playerEditing.dart';


class roomSelection extends StatefulWidget{
  @override
  roomSelectionState createState() => new roomSelectionState();
}

class roomSelectionState extends State<roomSelection>{

  final IOWebSocketChannel WSChannel = IOWebSocketChannel.connect('wss://lucarybka.de/nodenode');
  final TextEditingController nameTextfieldController = TextEditingController();
  final TextEditingController joinroomTextfieldController = TextEditingController();
  //OnlineTestBloc onlineTestBloc = OnlineTestBloc();
  final StreamController downStreamController = new StreamController.broadcast();
  Stream downStream;
  Sink upStream;
  List roomList;
  Room activeRoom;
  Player activePlayer;
  Package packageIn;
  String uuid = '';

  @override
  void initState()  {
    super.initState();
    WSChannel.stream.asBroadcastStream();
    downStreamController.addStream(WSChannel.stream);
    upStream = WSChannel.sink;
    downStream = downStreamController.stream;
    upStream.add(json.encode({'type':'get','content':'uuid'}));
    //upStream.add(json.encode({'type':'get','content':'roomList'}));
    upStream.add(json.encode({'type':'setName','content':playerEditingState.playerName}));
    upStream.add(json.encode({'type':'setSex','content':playerEditingState.playerSex}));
    upStream.add(json.encode({'type':'ping','content':''}));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameTextfieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: downStream,
        builder: (context, snapShot){
          packageIn = Package(jsonDecode(snapShot.data));
          switch(packageIn.type)  {
            case  'pong':
              upStream.add(json.encode({'type':'ping','content':''}));
              break;
            case 'uuid':
              uuid  = packageIn.content.toString();
              break;
            case 'room':
              activeRoom = Room(Map.from(packageIn.content));
              break;
            case  'roomList':
              roomList = packageIn.content;
              break;
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*Flexible(
                  child: TextField(
                    controller: nameTextfieldController,
                  ),
                ),
                FloatingActionButton.extended(
                  heroTag:'setName',
                  label: Text('Set name'),
                  onPressed: () {
                    upStream.add(json.encode({'type':'setName','content':nameTextfieldController.text.toString()}));
                  },
                ),*/
                FloatingActionButton.extended(
                  heroTag:'createRoom',
                  label: Text('Create a room'),
                  onPressed: () {
                    upStream.add(json.encode({'type':'createRoom','content':''}));
                    //upStream.add(json.encode({'type':'get','content':'roomList'}));
                  },
                ),
                Flexible(
                  child: TextField(
                    controller: joinroomTextfieldController,
                  ),
                ),
                FloatingActionButton.extended(
                  heroTag:'joinRoom',
                  label: Text('Join room'),
                  onPressed: () {
                    upStream.add(json.encode({'type':'joinRoom','content':joinroomTextfieldController.text.toString()}));
                  },
                ),
                //roomListView(context),
                playerListView(context)
                //Text(activeRoom!=null?activeRoom.playerDB[0].name:""),
              ],
            ),
          );
        },
      )
    );
    /*return BlocProvider<OnlineTestBloc>(
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
                                      new StreamBuilder(
                                        stream: mystreamController.stream,
                                        builder: (context, snapShot){
                                          package = Package(jsonDecode(snapShot.data));
                                          uuid = package.uuid;
                                          return Text(snapShot.hasData?package.uuid:"");
                                        },
                                      ),
                                      new StreamBuilder(
                                        stream: mystreamController.stream,
                                        builder: (context, snapShot){
                                          package = Package(jsonDecode(snapShot.data));
                                          thecolor = package.color;
                                          return Text(snapShot.hasData?package.color:"");
                                        },
                                      ),
                                      new TextField(
                                        controller: myController,
                                      ),
                                      new Flexible(
                                          child: new FloatingActionButton.extended(
                                              heroTag: 'FABOnline',
                                              label: Text("Get new UUID"),
                                              onPressed: () {
                                                channel.sink.add('requestUUID');
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
                                               /*mystreamController.stream.listen((message)  {
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
                                                });*/
                                              }
                                          ),
                                          new FloatingActionButton.extended(
                                              heroTag: 'Blue',
                                              label: Text("Blue"),
                                              onPressed: () {
                                                channel.sink.add('blue');
                                                /*mystreamController.stream.listen((message)  {
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
                                                });*/
                                              }
                                          ),
                                          new FloatingActionButton.extended(
                                              heroTag: 'Green',
                                              label: Text("Green"),
                                              onPressed: () {
                                                channel.sink.add('green');
                                                /*channel.stream.listen((message)  {
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
                                                });*/
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
    );*/
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

  Widget playerListView(BuildContext context) {
    if (activeRoom!=null) {
      return  Flexible(
        child: Column(
          children: <Widget>[
            Text(
              activeRoom.id,
              textAlign: TextAlign.center,
            ),
            Flexible(
              child:  ListView(
                children: <Widget>[
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: activeRoom.playerDB.length,
                      itemBuilder: (context, int index){
                        return Text(
                          activeRoom.playerDB[index].name,
                          textAlign: TextAlign.center,
                        );
                      })
                ],
              ),
            )
          ],
        ),
      );
    }
    else  {
      return Text("No players yet!");
    }
  }

  Widget roomListView(BuildContext context) {
    if (roomList.length!=0) {
      return  Column(
        children: <Widget>[
          Text(
            activeRoom.id,
            textAlign: TextAlign.center
          ),
          Flexible(
            child: ListView(
              children: <Widget>[
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: roomList.length,
                    itemBuilder: (context, int index){
                      return Text(roomList[index]);
                    })
              ],
            ),
          )
        ],
      );
    }
    else  {
      return Text("No rooms yet!");
    }
  }

}