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
  String mode;
  int activeTaskID;
  String activePlayerID;
  String activeSecondPlayerID;
  bool  isWaiting = true;
  List winnerIDArray = new List();
  int compareWinnerSide;
  static Room activeRoom;

  Room(Map<String, dynamic> data) {
    id = data['id'];
    List.from(data['playerDB']).forEach((playerPlaceHolder) => (playerDB.insert(playerDB.length, Player(playerPlaceHolder))));
    if (data['taskDB']!=null) {
      List.from(data['taskDB']).forEach((taskPlaceHolder) => (taskDB.insert(taskDB.length, Task(taskPlaceHolder))));
    }
    gmID  = data['gmID'];
    mode  = data['mode'];
    activeTaskID  = data['activeTaskID'];
    activePlayerID  = data['activePlayerID'];
    if (data['activeSecondPlayerID']!=null)  {
      activeSecondPlayerID  = data['activeSecondPlayerID'];
    }
    else  {
      activeSecondPlayerID=null;
    }
    if (data['BGTimerDB']!=null) {
      List.from(data['BGTimerDB']).forEach((timerPlaceHolder) => (BGTimerDB.insert(BGTimerDB.length, Timer(timerPlaceHolder))));
      if  (BGTimerDB.length>0)  {
        Timer.updateStateMap();
      }
    }
    else  {
      BGTimerDB=null;
    }
    isWaiting = data['isWaiting'];
    if (data['winnerIDArray']!=null)  {
      List.from(data['winnerIDArray']).forEach((playerplaceholder)  =>(winnerIDArray.insert(winnerIDArray.length, Player(playerplaceholder))));
    }
    else  {
      winnerIDArray = null;
    }
    compareWinnerSide = data['compareWinnerSide'];
  }

  static void renewActiveTimer(context) {
    if (currentRoom.BGTimerDB.length>0&&currentRoom.BGTimerDB.any((element)  =>  element.taskID==currentRoom.activeTaskID))  {
      int timerIndex  = currentRoom.BGTimerDB.indexWhere((element)  =>  element.taskID==currentRoom.activeTaskID);
      Timer.activeTimer = currentRoom.BGTimerDB[timerIndex];
      if  (currentRoom.BGTimerDB[timerIndex].BGTimeLeft!=0) {
        Timer.activeTimer.FGTimeLeft  = currentRoom.BGTimerDB[timerIndex].BGTimeLeft.toString();
      }
      else  {
        if  (currentRoom.BGTimerDB[timerIndex].BGTimeLeft==0) {
          Timer.activeTimer.FGTimeLeft  = S.of(context).FGTimerDone;
        }
        else  {
          Timer.activeTimer.FGTimeLeft = S.of(context).FGTimerGo;
        }
      }
    }
    else  {
      Timer.activeTimer=null;
    }
  }

}