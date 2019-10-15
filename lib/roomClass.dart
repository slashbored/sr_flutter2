import 'playerClass.dart';

class Room  {
  String id;
  List playerDB;

  Room(Map<String, dynamic> data) {
    id = data['id'];
    playerDB = data['playerDB'];
  }
}