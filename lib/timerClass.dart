class Timer{
  String id;
  String roomID;
  String playerID;
  int taskID;
  int BGTimeLeft;
  String FGTimeLeft;
  int indexInDB;

  static Timer activeTimer;

  Timer(Map data) {
    id          = data['id'];
    roomID      = data['roomID'];
    playerID    = data['playerID'];
    taskID      = data['taskID'];
    BGTimeLeft  = data['BGTimeLeft'];
  }
}