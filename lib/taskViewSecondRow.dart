import 'package:sr_flutter2/customFlatButton.dart';

import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'playerClass.dart';
import 'taskClass.dart';

import 'picassosWidget.dart';

import 'generated/l10n.dart';

String locale;
String splitString;
List splitStringList;
List bannedWords;
String nounstring;

Widget taskViewSecondRow(BuildContext context, Player firstPlayer, Player secondPlayer, Task task) {
  locale = Localizations.localeOf(context).toString();
  if (task.typeID==1||task.typeID==2||task.typeID==3) { //normal /-timed /-background
    if (firstPlayer.id==Player.mePlayer.id) {
      return Center(
        child: Text(
          Task.getStringByLocale(task, locale, "n_active"),
          textAlign: TextAlign.center,
          style: normalStyle
        )
      );
    }
    else {
      if (!(Task.getStringByLocale(task, locale, "n_spectate").contains("\$nounone")||Task.getStringByLocale(task, locale, "n_spectate").contains("\$nountwo"))) {
        nounstring=null;
      }
      else {
        nounstring = Task.getStringByLocale(task, locale, "n_spectate");
        nounstring = nounstring.replaceAll("\$nounone", firstPlayer.sex == 'm' ? S.of(context).nounhe : S.of(context).nounshe);
        nounstring = nounstring.replaceAll("\$nountwo", firstPlayer.sex == 'm' ? S.of(context).nounhis : S.of(context).nounher);
      }
      return Center(
        child: Text(
          nounstring!=null?nounstring:Task.getStringByLocale(task, locale, "n_spectate"),
          textAlign: TextAlign.center,
          style: normalStyle
        )
      );
    }
  }
  if (task.typeID==7||task.typeID==8||task.typeID==11||task.typeID==12)  {
    if (task.typeID==12) {
      //print("halthere");
    }
    return Center(
      child: Text(
        Task.getStringByLocale(task, locale, "n_active"),
        textAlign: TextAlign.center,
        style: normalStyle
      )
    );
  }
  if (task.typeID==4||task.typeID==5||task.typeID==6) { //choice /-timed /-background
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
                style: normalStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: splitStringList[0],
                    style: normalStyle
                  ),
                  TextSpan(
                      style: TextStyle(
                        color: secondPlayer.color,
                        fontSize: 22
                      ),
                      text: secondPlayer.name
                  ),
                  TextSpan(
                    text: splitStringList[1],
                    style: normalStyle
                  )
                ]
            )
          )
      );
    }
    if (secondPlayer.id==Player.mePlayer.id)  {
      return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: normalStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: splitStringList[0],
                    style: normalStyle
                  ),
                  TextSpan(
                      style: TextStyle(
                          color: firstPlayer.color,
                          fontSize: 22
                      ),
                      text: firstPlayer.name
                  ),
                  TextSpan(
                    text: splitStringList[1],
                    style: normalStyle
                  )
                ]
            )
          )
      );
    }
    else  {
      return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: normalStyle,
                children: <TextSpan>[
                 TextSpan(
                   style: TextStyle(
                     color: firstPlayer.color,
                     fontSize: 22
                   ),
                   text: firstPlayer.name
                 ),
                  TextSpan(
                    text: splitStringList[0],
                    style: normalStyle
                  ),
                  TextSpan(
                    style: TextStyle(
                      color: secondPlayer.color,
                      fontSize: 22
                    ),
                    text: secondPlayer.name
                  ),
                  TextSpan(
                    text: splitStringList[1],
                    style: normalStyle
                  )
                ]
            )
          )
      );
    }
  }
  if (task.typeID==9) { // pantomime
    if (firstPlayer.id == Player.mePlayer.id) {
      return Center(
        child: Text(
          Task.getStringByLocale(task, locale, "n_active"),
          textAlign: TextAlign.center,
          style: normalStyle
        )
      );
    }
    else {
      return Center(
          child: Text(
            "🤔",
            textAlign: TextAlign.center,
            style: headlineStyle
          )
        );
    }
  }
  if (task.typeID==10) { // taboo
    if (firstPlayer.id == Player.mePlayer.id) {
      bannedWords = Task.getListByLocale(task, locale);
      return Center(
        child: ListView(
          shrinkWrap: true,
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: bannedWords.length,
                  itemBuilder: (context, int index) {
                    return Text(
                        bannedWords[index].toString(),
                        textAlign: TextAlign.center,
                        style: normalStyle
                    );
                  }
              )
            ]
        )
      );
    }
    else {
      return Center(
        child: Text(
          "🤔",
          style: headlineStyle
        )
      );
    }
  }
  if (task.typeID==13)  {
    return Center(
      child: picassosWidget(200, 200, firstPlayer.id==Player.mePlayer.id?true:false),
    );
  }
  else {
    return Text("Ok, what?!");
  }
}