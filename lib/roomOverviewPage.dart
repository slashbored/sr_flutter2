import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'generated/l10n.dart';
import 'dart:convert';
import 'webSocket.dart';
import 'roomClass.dart';
import 'playerClass.dart';
import 'taskViewPage.dart';
import 'backgroundDecorationWidget.dart';
import 'fadeTransitionRoute.dart';
import 'textStyles.dart';
import 'drawingPage.dart';

List<Widget> playerWidgetList = new List();

class roomOverviewPage extends StatefulWidget{
  @override
  roomOverviewPageState createState() => new roomOverviewPageState();
}

class roomOverviewPageState extends State<roomOverviewPage>{

  @override
  Widget build(BuildContext context)  {
    return Container(
      decoration: backGroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
          stream: downStream,
          builder: (context, snapShot)  {
            return playerListView(context);
          }
        )
      )
    );
  }

  Widget playerListView(BuildContext context) {
    if (currentRoom!=null) {
      currentRoom.playerDB.forEach((player) {player.color = Player.setPlayerColor(player.originalPositionInDB); });
      playerWidgetList.clear();
      currentRoom.playerDB.forEach((player) {playerWidgetList.add(
          InputChip(
            backgroundColor: player.color,
            isEnabled: true,
            onPressed: () {null;},
            label: Text(
              player.id==currentRoom.gmID?player.name + " 👑":player.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  color:  Colors.white
              ),
            )
          )
      );});
      Player.mePlayer = currentRoom.playerDB.firstWhere((player) => Player.mePlayer.id  ==  player.id);
      return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 315,
                child: Center(
                    child: Text(
                        Room.activeRoom.id,
                        textAlign: TextAlign.center,
                        style: bigStyle
                    )
                )
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
            Expanded(
                flex: 265,
                child:  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 10,
                    children:
                    playerWidgetList
                  /*ListView.builder(
                            shrinkWrap: true,
                            itemCount: currentRoom.playerDB.length,
                            itemBuilder: (context, int index){
                              return InputChip(
                                label: Text(
                                  currentRoom.playerDB[index].id==currentRoom.gmID?currentRoom.playerDB[index].name + " 👑":currentRoom.playerDB[index].name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color:  Colors.white
                                  ),
                                ),
                                backgroundColor: currentRoom.playerDB[index].color,
                                isEnabled: true,
                                onPressed: () {
                                  null;
                                },
                              );
                              /*return Text(
                                currentRoom.playerDB[index].id==currentRoom.gmID?currentRoom.playerDB[index].name + " 👑":currentRoom.playerDB[index].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color:  currentRoom.playerDB[index].color
                                );*/
                            }
                        )*/

                )
            ),
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Divider(
                        color: Colors.black,
                        thickness: 2
                    )
                )
            ),
            Expanded(
                flex: 365,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                          flex: 1,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                              "Touchy" + (currentRoom.isTouchy?"!":"?"),
                                              style: normalStyle
                                          ),
                                          Switch(
                                              activeColor: Player.mePlayer.id==currentRoom.gmID?Colors.green:Colors.green[200],
                                              inactiveThumbColor: Player.mePlayer.id==currentRoom.gmID?Colors.white:Colors.white,
                                              activeTrackColor: Player.mePlayer.id==currentRoom.gmID?Colors.lightGreen:Colors.lightGreen.withOpacity(0.38),
                                              inactiveTrackColor: Player.mePlayer.id==currentRoom.gmID?Colors.grey:Colors.grey.withOpacity(0.38),
                                              value: currentRoom.isTouchy,
                                              onChanged: (touchytouch) {
                                                Player.mePlayer.id==currentRoom.gmID?upStream.add(json.encode({'type':'touchy','content':touchytouch?true:false})):null;
                                              }
                                          )
                                        ]
                                    )
                                ),
                                Spacer(
                                    flex: 1
                                )
                              ]
                          )
                      ),
                      Flexible(
                          flex: 1,
                          child:
                          /**/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              startGameFAB(context),
                              //startDrawFAB(context)
                            ],
                          )
                      ),
                      Spacer(
                          flex: 1
                      )
                    ]
                )
            )
          ]
      );
    }
    else  {
      return Center(
          child: Text(
              S.of(context).noPlayersYet,
              textAlign: TextAlign.center
          )
      );
    }
  }

  Widget startDrawFAB(BuildContext context) {
    return new FloatingActionButton.extended(
        label: Text(
            "Draw"
        ),
        onPressed: (){
          Navigator.push(context, fadePageRoute(page: Draw()));
        }
    );
  }

  Widget startGameFAB(BuildContext context)  {
    roomOverviewContext = context;
    if  (currentRoom.gmID==Player.mePlayer.id)  {
      return FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white
        ),
          onPressed: () {
            if  (currentRoom!=null&&currentRoom.playerDB.length>1)  {
              upStream.add(json.encode({'type':'randomTask','content':''}));
              upStream.add(json.encode({'type':'randomPlayers','content':''}));
              upStream.add(json.encode({'type':'setMode','content':'endless'}));
              upStream.add(json.encode({'type':'startGame','content':''}));
            }
          },
          color: currentRoom!=null&&currentRoom.playerDB.length>2?Colors.green:Colors.grey
      );
    }
    else  {
      return FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
          child: Icon(
            Icons.hourglass_empty,
            color: Colors.white
          ),
        onPressed: () {},
        color: Colors.grey,
      );
    }
  }

  void goToTaskViewPage(theContext) async {
    await new Future.delayed(const Duration(milliseconds: 500));
    Navigator.of(theContext).push(fadePageRoute(page: taskViewPage()));
  }
}