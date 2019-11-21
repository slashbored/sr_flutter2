import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "generated/i18n.dart";

import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';

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
  if (task.typeID==1||task.typeID==2||task.typeID==3||task.typeID==7||task.typeID==8||task.typeID==9||task.typeID==11)  {
    return Text(
        getStringByLocale(task, Localizations.localeOf(context).toString(), "n")
    );
  }
  else  {
    return Text("Later..");
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