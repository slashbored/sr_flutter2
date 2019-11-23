import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "generated/i18n.dart";

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';

String locale;
List bannedWords;

final TextStyle _taskStyle = const TextStyle(
    fontSize: 36,
    color: Colors.black
);

final TextStyle _maleTaskStyle = const TextStyle(
    fontSize: 36,
    color: Colors.blue
);

final TextStyle _femaleTaskStyle = const TextStyle(
    fontSize: 36,
    color: Colors.red
);

Widget taskViewSecondRow(BuildContext context, Player firstPlayer, Player secondPlayer, Task task)  {
  locale  = Localizations.localeOf(context).toString();
  if  (task.typeID==1||task.typeID==2||task.typeID==3||task.typeID==7||task.typeID==8||task.typeID==9||task.typeID==11)  {
    return Text(
        getStringByLocale(task, locale, "n")
    );
  }
  if  (task.typeID==4||task.typeID==5||task.typeID==6)  {
    return Text("Later...");
  }
  if  (task.typeID==10) {
    bannedWords  = getListByLocale(task, locale) ;
        return  ListView(
          children: <Widget>[
            ListView.builder(
                shrinkWrap: true,
                itemCount: bannedWords.length,
                itemBuilder: (context, int index){
                  return Text(
                    //Room.activeRoom.playerDB[index].id==Room.activeRoom.gmID?Room.activeRoom.playerDB[index].name + " 👑":Room.activeRoom.playerDB[index].name,
                    bannedWords[index].toString(),
                    textAlign: TextAlign.center,
                  );
                }
            )
          ]
      );
  }
  else  {
    return Text("Ok, what?!");
  }
}

String getStringByLocale(Task task, String locale, String stringType)  {
  if  (locale=="en_") {
    switch  (stringType)  {
      case("n"):
        return task.nString_en;
        break;
    }
  }
  else  {
    switch  (stringType)  {
    case("n"):
      return task.nString_de;
      break;
  }

  }
}

List getListByLocale(Task task, String locale)  {
  if  (locale=="en_")  {
     return task.bannedWords_en;
  }
  else  {
    return task.bannedWords_de;
  }
}