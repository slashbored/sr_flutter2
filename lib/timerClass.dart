import 'roomClass.dart';

class customTimer{
  String id;
  String roomID;
  String playerID;
  String secondPlayerID;
  int taskID;
  int BGTimeLeft;
  String FGTimeLeft;
  String viewState;
  bool isRunning;

  static customTimer activeTimer;
  static Map stateMap;

  customTimer(Map data) {
    id          = data['id'];
    roomID      = data['roomID'];
    playerID    = data['playerID'];
    taskID      = data['taskID'];
    BGTimeLeft  = data['BGTimeLeft'];
    isRunning   = data['isRunning'];
    if (data['activeSecondPlayerID']!=null) {
      secondPlayerID  = data['activeSecondPlayerID'];
    }
    else  {
      secondPlayerID  = null;
    }
  }

  static void updateStateMap()  {
    if  (stateMap==null)  {
      stateMap = Map.fromIterable(Room.activeRoom.BGTimerDB,key:  (element)  => element.id, value:  (element)  =>  element.viewState);
    }
    else  {
      for (customTimer timerplaceholder in Room.activeRoom.BGTimerDB) {
        stateMap.putIfAbsent(timerplaceholder.id, ()  =>  timerplaceholder.viewState);
      }
    }
  }
}