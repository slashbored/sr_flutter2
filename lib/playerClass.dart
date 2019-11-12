class Player  {
  String id;
  String name;
  String sex;
  int points;
  static Player mePlayer;

  Player(Map data) {
    id    = data['id'];
    name  = data['name'];
    sex   = data['sex'];
    points  = data['points'];
  }
}