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

  static Player getPlayerByID(String playerID)  {
    int playerIDindex = Room.activeRoom.playerDB.indexWhere((test) =>
    test.id == playerID);
    return Room.activeRoom.playerDB[playerIDindex];
  }
}