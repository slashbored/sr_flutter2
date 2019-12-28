import 'package:flutter/material.dart';
import 'roomClass.dart';

class Player  {
  String id;
  String name;
  String sex;
  int points;
  String roomID;
  static Player mePlayer;

  Player(Map data) {
    id    = data['id'];
    name  = data['name'];
    sex   = data['sex'];
    points  = data['points'];
    roomID  = data['roomID'];
  }

  static TextStyle getPlayerSexStyleByID(String playerID, double size)  {
    switch (Room.activeRoom.playerDB.firstWhere((player) =>  player.id == playerID).sex) {
      case ('m'):
        return TextStyle(
            fontSize: size,
            color: Colors.blue
        );
        break;
      case ('f'):
        return TextStyle(
            fontSize: size,
            color: Colors.red
        );
        break;
    }
  }
}