import 'playerClass.dart';
import 'taskClass.dart';

class Room  {
  String id;
  List playerDB = new List();
  List chatDB   = new List();
  List taskDB   = new List();
  static Room activeRoom;
  static int activeTaskID;

  Room(Map<String, dynamic> data) {
    id = data['id'];
    List.from(data['playerDB']).forEach((playerPlaceHolder) => (playerDB.insert(playerDB.length, Player(playerPlaceHolder))));
    if(data['chatDB']!=null) {
      List.from(data['chatDB']).forEach((messagePlaceHolder) => (chatDB.insert(chatDB.length, messagePlaceHolder.toString())));
    }
    if(data['taskDB']!=null) {
      List.from(data['taskDB']).forEach((taskPlaceHolder) => (taskDB.insert(taskDB.length, Task(taskPlaceHolder))));
    }
    activeTaskID  = data['activeTaskID'];
  }
}