import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "generated/i18n.dart";

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';

String locale;
List splitString;
List bannedWords;

final TextStyle _taskStyle = const TextStyle(
    fontSize: 18,
    color: Colors.black
);

final TextStyle _maleTaskStyle = const TextStyle(
    fontSize: 18,
    color: Colors.blue
);

final TextStyle _femaleTaskStyle = const TextStyle(
    fontSize: 18,
    color: Colors.red
);

Widget taskViewSecondRow(BuildContext context, Player firstPlayer, Player secondPlayer, Task task)  {
  locale  = Localizations.localeOf(context).toString();
  if  (task.typeID==1||task.typeID==2||task.typeID==3||task.typeID==7||task.typeID==8||task.typeID==11)  {
    return Center(
      child: Text(
        getStringByLocale(task, locale, "n"),
        style: _taskStyle,
      ),
    );
  }
  if  (task.typeID==4||task.typeID==5||task.typeID==6)  {
    splitString = getStringByLocale(task, locale, "a").split("\$placeholder");
    return Center(
      child:  RichText(
        text: TextSpan(
            style: _taskStyle,
            children:<TextSpan>[
              TextSpan(
                  text: splitString[0]
              ),
              TextSpan(
                  style: secondPlayer.sex== 'm'
                      ? _maleTaskStyle
                      : _femaleTaskStyle,
                  text: secondPlayer.name
              ),
              TextSpan(
                  text: splitString[1]
              )
            ]
        ),
      )
    );
  }
  if  (task.typeID==9) {
    if  (firstPlayer.id==Player.mePlayer.id)  {
      return Center(
        child: Text(
            getStringByLocale(task, locale, "n"),
            style: _taskStyle
        ),
      );
    }
    else  {
      return Center(
        child: Text(
          "🤔",
          style: TextStyle(
              fontSize: 36
          ),
        ),
      );
    }
  }
  if  (task.typeID==10) {
    if  (firstPlayer.id==Player.mePlayer.id)  {
      bannedWords  = getListByLocale(task, locale) ;
      return  Center(
        child: ListView(
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: bannedWords.length,
                  itemBuilder: (context, int index){
                    return Text(
                        bannedWords[index].toString(),
                        textAlign: TextAlign.center,
                        style: _taskStyle
                    );
                  }
              )
            ]
        ),
      );
    }
    else  {
      return Center(
        child: Text(
          "🤔",
          style: TextStyle(
              fontSize: 36
          ),
        ),
      );
    }
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
      case("a"):
        return task.aString_en;
        break;
    }
  }
  else  {
    switch  (stringType)  {
    case("n"):
      return task.nString_de;
      break;
    case("a"):
      return task.aString_de;
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