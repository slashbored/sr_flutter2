import 'playerClass.dart';

class Room  {
  String id;
  //List activePlayerList;
  //Player activePlayer;
  List playerDB = new List();

  Room(Map<String, dynamic> data) {
    id = data['id'];
    //activePlayerList = new List.from(data['playerDB']);
    List.from(data['playerDB']).forEach((playerPlaceHolder) => (playerDB.insert(playerDB.length, Player(playerPlaceHolder))));
  }
  
}