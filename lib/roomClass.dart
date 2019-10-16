import 'playerClass.dart';

class Room  {
  String id;
  List activePlayerList;
  //Player activePlayer;
  List playerDB = new List();

  Room(Map<String, dynamic> data) {
    id = data['id'];
    //playerDB = data['playerDB'];
    //playerDB = Player(List.from(data['playerDB'])[0]);
    //List.from(data['playerDB']).forEach((playerPlaceHolder) => playerDB.add(Player(playerPlaceHolder)));
    //print(playerDB.toString());
    activePlayerList = new List.from(data['playerDB']);
    activePlayerList.forEach((playerPlaceHolder) => (playerDB.insert(playerDB.length, Player(playerPlaceHolder))));
    //activePlayer = Player(activePlayerList[0]);
  }
  
}