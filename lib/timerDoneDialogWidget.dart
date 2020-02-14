import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'generated/i18n.dart';
import 'webSocket.dart';
import 'timerWidget.dart';
import 'customTimerClass.dart';
import 'roomClass.dart';
import 'playerClass.dart';
import 'taskClass.dart';
import 'package:quiver/collection.dart';
import 'package:quiver/collection.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'localizationBloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

bool timerDoneDialogOpen;
BuildContext timerDoneDialogContext;
String locale = Localizations.localeOf(timerDoneDialogContext).toString();

Widget timerDoneDialog(BuildContext context, Task completedTask)  {
  timerDoneDialogContext  = context;
  return StreamBuilder(
    stream: downStream,
    builder: (context, snapShot)  {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        title: Text(
          S.of(context).timerDoneDialog_title,
          textAlign: TextAlign.center,
          style: normalStyle
        ),
        children: <Widget>[
        Text(
          Task.getStringByLocale(completedTask, locale, 'completeString'),
          textAlign: TextAlign.center,
          style: normalStyle
        ),
        SimpleDialogOption(
          child: Text(
            "OK",
            textAlign: TextAlign.center,
            style: normalStyle,
          ),
          onPressed: () {
            timerDoneDialogOpen = false;
            Navigator.pop(context);
          },
        )
        ]
      ) ;
    }
  );
}