import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'playerClass.dart';
import 'taskClass.dart';

String locale;
String splitString;
List splitStringList;
List bannedWords;

final TextStyle _taskStyle = const TextStyle(
    fontSize: 18,
    color: Colors.black
);

Widget taskViewSecondRow(BuildContext context, Player firstPlayer, Player secondPlayer, Task task) {
  locale = Localizations.localeOf(context).toString();
  if (task.typeID == 1 || task.typeID == 2 || task.typeID == 3) {
    if (firstPlayer.id==Player.mePlayer.id) {
      return Center(
        child: Text(
          Task.getStringByLocale(task, locale, "n_active"),
          style: _taskStyle,
          textAlign: TextAlign.center,
        ),
      );
    }
    else {
      return Center(
        child: Text(
          Task.getStringByLocale(task, locale, "n_spectate"),
          style: _taskStyle,
          textAlign: TextAlign.center,
        ),
      );
    }
  }
  if (task.typeID == 7 || task.typeID == 8 || task.typeID == 11)  {
    return Center(
      child: Text(
        Task.getStringByLocale(task, locale, "n_active"),
        style: _taskStyle,
      ),
    );
  }
  if (task.typeID == 7) {
    return Center(
      child: Text(
        Task.getStringByLocale(task, locale, "n_active"),
        style: _taskStyle,
      ),
    );
  }
  if (task.typeID == 4 || task.typeID == 5 || task.typeID == 6) {
    if (firstPlayer.id==Player.mePlayer.id) {
      splitStringList = Task.getStringByLocale(task, locale, "a_active").split("\$placeholder");
    }
    else if (secondPlayer.id==Player.mePlayer.id)  {
      splitStringList = Task.getStringByLocale(task, locale, "a_passive").split("\$placeholder");
    }
    else  {
      splitString = Task.getStringByLocale(task, locale, "a_spectate").replaceAll("\$placeholderone", "");
      splitStringList  = splitString.split("\$placeholdertwo");
    }
    if (firstPlayer.id==Player.mePlayer.id)  {
      return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: _taskStyle,
                children: <TextSpan>[
                  TextSpan(
                    style: _taskStyle,
                    text: splitStringList[0]
                  ),
                  TextSpan(
                      style: TextStyle(
                        color: secondPlayer.color,
                        fontSize: 18
                      ),
                      text: secondPlayer.name
                  ),
                  TextSpan(
                      text: splitStringList[1]
                  )
                ]
            ),
          )
      );
    }
    if (secondPlayer.id==Player.mePlayer.id)  {
      return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: _taskStyle,
                children: <TextSpan>[
                  TextSpan(
                      style: _taskStyle,
                      text: splitStringList[0]
                  ),
                  TextSpan(
                      style: TextStyle(
                          color: firstPlayer.color,
                          fontSize: 18
                      ),
                      text: firstPlayer.name
                  ),
                  TextSpan(
                      text: splitStringList[1]
                  )
                ]
            ),
          )
      );
    }
    else  {
      return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: _taskStyle,
                children: <TextSpan>[
                 TextSpan(
                   style: TextStyle(
                     color: firstPlayer.color,
                     fontSize: 18
                   ),
                   text: firstPlayer.name
                 ),
                  TextSpan(
                    style: _taskStyle,
                    text: splitStringList[0]
                  ),
                  TextSpan(
                    style: TextStyle(
                      color: secondPlayer.color,
                      fontSize: 18
                    ),
                    text: secondPlayer.name
                  ),
                  TextSpan(
                    style: _taskStyle,
                    text: splitStringList[1]
                  )
                ]
            ),
          )
      );
    }
  }
  if (task.typeID == 9) {
    if (firstPlayer.id == Player.mePlayer.id) {
      return Center(
        child: Text(
            Task.getStringByLocale(task, locale, "n_active"),
            style: _taskStyle
        ),
      );
    }
    else {
      return Center(
        child: Text(
          "🤔",
          style: TextStyle(
              fontSize: 36
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
  }
  if (task.typeID == 10) {
    if (firstPlayer.id == Player.mePlayer.id) {
      bannedWords = Task.getListByLocale(task, locale);
      return Center(
        child: ListView(
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: bannedWords.length,
                  itemBuilder: (context, int index) {
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
    else {
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
  else {
    return Text("Ok, what?!");
  }
}