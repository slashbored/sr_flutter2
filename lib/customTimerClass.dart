import 'webSocket.dart';
import 'package:quiver/collection.dart';

class CustomTimer{
  String id;
  String roomID;
  String playerID;
  String secondPlayerID;
  int taskID;
  int BGTimeLeft;
  String FGTimeLeft;
  String viewState;
  bool isRunning;

  static CustomTimer activeTimer;
  static Map stateMap;

  CustomTimer(Map data) {
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
    if(packageIn.type!='rejoin')  {
      if  (stateMap==null)  {
        stateMap = Map.fromIterable(currentRoom.BGTimerDB,key:  (element)  => element.id, value:  (element)  =>  element.viewState);
      }
      else  {
        for (CustomTimer timerplaceholder in currentRoom.BGTimerDB) {
          stateMap.putIfAbsent(timerplaceholder.id, ()  =>  timerplaceholder.viewState);
        }
      }
    }
  }
}