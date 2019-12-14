class Timer{
  String id;
  String roomID;
  String playerID;
  int taskID;
  int BGTimeLeft;

  Timer(Map data) {
    id          = data['id'];
    roomID      = data['roomID'];
    playerID    = data['playerID'];
    taskID      = data['taskID'];
    BGTimeLeft  = data['BGTimeLeft'];
  }
}