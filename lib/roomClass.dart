import 'playerClass.dart';
import 'taskClass.dart';
import 'timerClass.dart';

class Room  {
  String id;
  List playerDB = new List();
  //List chatDB   = new List();
  List taskDB   = new List();
  List BGTimerDB  = new List();
  String gmID;
  int activeTaskID;
  String activePlayerID;
  String activeSecondPlayerID;
  static Room activeRoom;

  Room(Map<String, dynamic> data) {
    id = data['id'];
    List.from(data['playerDB']).forEach((playerPlaceHolder) => (playerDB.insert(playerDB.length, Player(playerPlaceHolder))));
    /*if(data['chatDB']!=null) {
      List.from(data['chatDB']).forEach((messagePlaceHolder) => (chatDB.insert(chatDB.length, messagePlaceHolder.toString())));
    }*/
    if(data['taskDB']!=null) {
      List.from(data['taskDB']).forEach((taskPlaceHolder) => (taskDB.insert(taskDB.length, Task(taskPlaceHolder))));
    }
    gmID  = data['gmID'];
    activeTaskID  = data['activeTaskID'];
    activePlayerID  = data['activePlayerID'];
    if(data['activeSecondPlayerID']!=null)  {
      activeSecondPlayerID  = data['activeSecondPlayerID'];
    }
    else  {
      activeSecondPlayerID=null;
    }
    if(data['BGTimerDB']!=null) {
      List.from(data['BGTimerDB']).forEach((timerPlaceHolder) => (BGTimerDB.insert(BGTimerDB.length, Timer(timerPlaceHolder))));
      print(BGTimerDB.length);
      if(BGTimerDB.length>0)  {
        print(BGTimerDB[0].BGTimeLeft.toString());
      }
    }
    else  {
      BGTimerDB=null;
    }
  }
}