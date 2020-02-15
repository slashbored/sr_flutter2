import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/taskViewFirstRow.dart';
//import 'package:sr_flutter2/taskViewFourthRow.dart';
import 'package:sr_flutter2/taskViewSecondRow.dart';
import 'package:sr_flutter2/taskViewThirdRow.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'roomSelectionPage.dart';
import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'timerViewDialogWidget.dart';


class taskViewPage extends StatefulWidget{
  @override
  taskViewPageState createState() => new taskViewPageState();
}

class taskViewPageState extends State<taskViewPage>{

  Task currentTask;
  Player currentPlayer;
  Player currentSecondPlayer;

  @override
  Widget build(BuildContext context)  {
    WidgetsBinding.instance.addPostFrameCallback((_) => _insertOverlay(context));
    return mainBody(context);
  }

  void _insertOverlay(BuildContext context) {
    return Overlay.of(context).insert(
        OverlayEntry(
            builder: (context) {
              final size = MediaQuery
                  .of(context)
                  .size;
              return Positioned(
                  width: 56,
                  height: 56,
                  bottom: 28,
                  right: size.width - 72,
                  child: Transform.scale(
                      scale: 1,
                      child: Material(
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              if (timerViewDialogOpen!=true) {
                                timerViewDialogOpen=true;
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) => timerViewDialog(context)
                                );
                              }
                            },
                            child: Icon(Icons.watch)
                          )
                      )
                  )
              );
            }
        )
    );
  }

  Widget mainBody(BuildContext context)  {
    taskViewPageContext = context;
    if  (isWorkingAtAll()) {
      currentTask   = currentRoom.taskDB.firstWhere((taskPlaceholder) =>  taskPlaceholder.id == currentRoom.activeTaskID);
      currentPlayer = Room.activeRoom.playerDB.firstWhere((player) =>  player.id == currentRoom.activePlayerID);
      if  (currentRoom.activeSecondPlayerID!=null)  {
        currentSecondPlayer = Room.activeRoom.playerDB.firstWhere((player) =>  player.id == currentRoom.activeSecondPlayerID);
      }
      return WillPopScope(
        onWillPop: () =>  null,
        child: Scaffold(
          body: StreamBuilder(
              stream: downStream,
              builder:  (context, snapShot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Expanded(
                        child: taskViewFirstRow(context, currentPlayer, currentSecondPlayer, currentTask),
                        flex: 315
                    ),
                    new Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Divider(
                              color: Colors.black,
                              thickness: 2
                          )
                        )
                    ),
                    new Expanded(
                        child: taskViewSecondRow(context, currentPlayer, currentSecondPlayer, currentTask),
                        flex: 315
                    ),
                    new Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Divider(
                              color: Colors.black,
                              thickness: 2
                          )
                        )
                    ),
                    new Expanded(
                        child: taskViewThirdRow(context, currentPlayer, currentSecondPlayer, currentTask),
                        flex: 315
                    )
                  ]
                );
              }
          )
        )
      );
    }
    else  {
      return Text("Something went HORRIBLY wrong!");
    }
  }

  bool isWorkingAtAll() {
    if(currentRoom != null && currentRoom.activeTaskID != null &&
        currentRoom.activePlayerID != null) {
      return true;
    }
    else  {
      return false;
    }
  }


  void nextTaskOnThisPage(theContext) async {
    await new Future.delayed(const Duration(milliseconds: 50));
    Navigator.of(theContext).push(CupertinoPageRoute(builder: (context) => taskViewPage()));
  }

  void goHome(theContext) {
    Navigator.of(theContext).push(CupertinoPageRoute(builder: (context) => roomSelection()));
  }
}