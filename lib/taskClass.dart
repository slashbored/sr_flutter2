class Task{
  int id;
  int categoryID;
  int typeID;
  int weight;
  String descr;
  String timerDescr_en;
  String timerDescr_de;
  int duration;
  String nString_en_active;
  String nString_de_active;
  String nString_en_spectate;
  String nString_de_spectate;
  String aString_en_active;
  String aString_de_active;
  String aString_en_passive;
  String aString_de_passive;
  String aString_en_spectate;
  String aString_de_spectate;
  String oString_en;
  String oString_de;
  String gString_en;
  String gString_de;
  String completeString_en;
  String completeString_de;
  List bannedWords_en = new List(4);
  List bannedWords_de = new List(4);
  String aSelectString_en;
  String aSelectString_de;
  String bSelectString_en;
  String bSelectString_de;
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
    weight      = data['weight'];
    descr       = data['descr'];
    timerDescr_en = data['timerDescr_en'];
    timerDescr_de = data['timerDescr_de'];
    duration    = data['duration'];
    nString_en_active  = data['nString_en_active'];
    nString_de_active  = data['nString_de_active'];
    nString_en_spectate  = data['nString_en_spectate'];
    nString_de_spectate  = data['nString_de_spectate'];
    aString_en_active  = data['aString_en_active'];
    aString_de_active  = data['aString_de_active'];
    aString_en_passive  = data['aString_en_passive'];
    aString_de_passive  = data['aString_de_passive'];
    aString_en_spectate = data['aString_en_spectate'];
    aString_de_spectate = data['aString_de_spectate'];
    oString_en  = data['oString_en'];
    oString_de  = data['oString_de'];
    gString_en  = data['gString_en'];
    gString_de  = data['gString_de'];
    completeString_en = data['completeString_en'];
    completeString_de = data['completeString_de'];
    bannedWords_en = List.from(data['bannedWords_en']);
    bannedWords_de = List.from(data['bannedWords_de']);
    aSelectString_en  = data["aSelectString_en"];
    aSelectString_de  = data["aSelectString_de"];
    bSelectString_en  = data["bSelectString_en"];
    bSelectString_de  = data["bSelectString_de"];
    aWonString_en = data['aWonString_en'];
    aWonString_de = data['aWonString_de'];
    aLostString_en  = data['aLostString_en'];
    aLostString_de  = data['aLostString_de'];
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

  static String getStringByLocale(Task task, String locale, String stringType)  {
    if  (locale=="en_") {
      switch  (stringType)  {
        case("n_active"):
          return task.nString_en_active;
          break;
        case("n_spectate"):
          return task.nString_en_spectate;
          break;
        case("a_active"):
          return task.aString_en_active;
          break;
        case("a_passive"):
          return task.aString_en_passive;
          break;
        case("a_spectate"):
          return task.aString_en_spectate;
          break;
        case('timerDescr'):
          return task.timerDescr_en;
          break;
        case("wyr_a"):
          return task.aSelectString_en;
          break;
        case("wyr_b"):
          return task.bSelectString_en;
          break;
        case('compare_win'):
          return task.winnerString_en;
          break;
        case('compare_loose'):
          return task.looserString_en;
          break;
        case('wyr_a_won'):
          return task.aWonString_en;
          break;
        case('wyr_a_lost'):
          return task.aLostString_en;
          break;
        case('wyr_b_won'):
          return task.bWonString_en;
          break;
        case('wyr_b_lost'):
          return task.bLostString_en;
          break;
      }
    }
    else  {
      switch  (stringType)  {
        case("n_active"):
          return task.nString_de_active;
          break;
        case("n_spectate"):
          return task.nString_de_spectate;
          break;
        case("a_active"):
          return task.aString_de_active;
          break;
        case("a_passive"):
          return task.aString_de_passive;
          break;
        case("a_spectate"):
          return task.aString_de_spectate;
          break;
        case('timerDescr'):
          return task.timerDescr_de;
          break;
        case("wyr_a"):
          return task.aSelectString_de;
          break;
        case("wyr_b"):
          return task.bSelectString_de;
          break;
        case('compare_win'):
          return task.winnerString_de;
          break;
        case('compare_loose'):
          return task.looserString_de;
          break;
        case('wyr_a_won'):
          return task.aWonString_de;
          break;
        case('wyr_a_lost'):
          return task.aLostString_de;
          break;
        case('wyr_b_won'):
          return task.bWonString_de;
          break;
        case('wyr_b_lost'):
          return task.bLostString_de;
          break;
      }

    }
  }

  static List getListByLocale(Task task, String locale)  {
    if  (locale=="en_")  {
      return task.bannedWords_en;
    }
    else  {
      return task.bannedWords_de;
    }
  }
}