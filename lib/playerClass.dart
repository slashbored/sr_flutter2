import 'package:flutter/material.dart';

class Player  {
  String id;
  String name;
  String sex;
  MaterialColor color;
  int points;
  double compareValue;
  int weightModifier;
  String roomID;
  static Player mePlayer;

  Player(Map data) {
    id    = data['id'];
    name  = data['name'];
    sex   = data['sex'];
    points  = data['points'];
    weightModifier  = data['weightModifier'];
    roomID  = data['roomID'];
  }

  static MaterialColor setPlayerColor(int positionInDB)  {
    switch (positionInDB)  {
      case 0:
        return Colors.blue;
        break;
      case 1:
        return Colors.green;
        break;
      case 2:
        return Colors.red;
        break;
      case 3:
        return Colors.purple;
        break;
      case 4:
        return Colors.deepOrange;
        break;
      case 5:
        return Colors.brown;
        break;
      case 6:
        return Colors.indigo;
        break;
      case 7:
        return Colors.pink;
        break;
      case 8:
        return Colors.teal;
        break;
      case 9:
        return Colors.lightGreen;
        break;
      case 10:
        return Colors.lime;
        break;
      case 11:
        return Colors.orange;
        break;
      case 12:
        return Colors.yellow;
        break;
      case 13:
        return Colors.amber;
        break;
      case 14:
        return Colors.cyan;
        break;
      case 15:
        return Colors.grey;
        break;

    }
  }
}