class Player  {
  String id;
  String name;
  //String sex;
  //int points;

  Player(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
  }
}