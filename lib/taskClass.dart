import 'roomClass.dart';

class Task{
  int id;
  int categoryID;
  int typeID;
  String descr;
  int duration;
  String nString_en;
  String nString_de;
  String aString_en;
  String aString_de;
  String oString_en;
  String oString_de;
  String gString_en;
  String gString_de;
  String completeString_en;
  String completeString_de;
  List bannedWords_en = new List(4);
  List bannedWords_de = new List(4);
  String aWonString_en;
  String aWonString_de;
  String aLostString_en;
  String aLostString_de;
  String bWonString_en;
  String bWonString_de;
  String bLostString_en;
  String bLostString_de;
  String winLooseMod;
  String winnerString_en;
  String winnerString_de;
  String looserString_en;
  String looserString_de;

  Task(Map data) {
    id          = data['id'];
    categoryID  = data['categoryID'];
    typeID      = data['typeID'];
    descr       = data['descr'];
    duration    = data['duration'];
    nString_en  = data['nString_en'];
    nString_de  = data['nString_de'];
    aString_en  = data['aString_en'];
    aString_de  = data['aString_de'];
    oString_en  = data['oString_en'];
    oString_de  = data['oString_de'];
    gString_en  = data['gString_en'];
    gString_de  = data['gString_de'];
    completeString_en = data['completeString_en'];
    completeString_de = data['completeString_de'];
    bannedWords_en = List.from(data['bannedWords_en']);
    bannedWords_de = List.from(data['bannedWords_de']);
    aWonString_en = data['aWonString_en'];
    aWonString_de = data['aWonString_de'];
    aLostString_en  = data['aLostString_en'];
    aLostString_en  = data['aLostString_de'];
    bWonString_en = data['bWonString_en'];
    bWonString_de = data['bWonString_de'];
    bLostString_en = data['bLostString_en'];
    bLostString_de = data['bLostString_de'];
    winLooseMod = data['winLooseMod'];
    winnerString_en = data['winnerString_en'];
    winnerString_de = data['winnerString_de'];
    looserString_en = data['looserString_en'];
    looserString_de = data['looserString_de'];
  }

  static Task getTaskByID(int taskID)  {
    int taskIDindex = Room.activeRoom.taskDB.indexWhere((test) =>
    test.id == Room.activeRoom.activeTaskID);
    return Room.activeRoom.taskDB[taskIDindex];
  }
}