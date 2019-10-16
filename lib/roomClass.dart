import 'playerClass.dart';

class Room  {
  String id;
  //List activePlayerList;
  //Player activePlayer;
  var playerDB;

  Room(Map<String, dynamic> data) {
    id = data['id'];
    //playerDB = data['playerDB'];
    //activePlayerList = new List.from(data['playerDB']);
    //activePlayer = Player(activePlayerList[0]);
    //print(activePlayer);
    playerDB = Player(List.from(data['playerDB'])[0]);
  }
}