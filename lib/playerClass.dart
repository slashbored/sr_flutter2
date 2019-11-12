class Player  {
  String id;
  String name;
  String sex;
  int points;
  String roomID;
  static Player mePlayer;

  Player(Map data) {
    id    = data['id'];
    name  = data['name'];
    sex   = data['sex'];
    points  = data['points'];
    roomID  = data['roomID'];
  }
}