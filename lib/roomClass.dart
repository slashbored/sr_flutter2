import 'webSocket.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'timerClass.dart';
import 'generated/i18n.dart';

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
    }
    else  {
      BGTimerDB=null;
    }
  }

  static void renewActiveTimer(context) {
    if(currentRoom.BGTimerDB.length>0)  {
      int timerIndex;
      timerIndex  = currentRoom.BGTimerDB.indexWhere((element)  =>  element.taskID==currentRoom.activeTaskID);
      Timer.activeTimer = currentRoom.BGTimerDB[timerIndex];
      if  (currentRoom.BGTimerDB[timerIndex].BGTimeLeft!=0) {
        Timer.activeTimer.FGTimeLeft  = currentRoom.BGTimerDB[timerIndex].BGTimeLeft.toString();
      }
      if  (currentRoom.BGTimerDB[timerIndex].BGTimeLeft==0) {
        Timer.activeTimer.FGTimeLeft  = S.of(context).FGTimerDone;
      }
    }
    else {
      Timer.activeTimer.FGTimeLeft = S.of(context).FGTimerGo;
    }
  }

}