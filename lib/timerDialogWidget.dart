import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'generated/i18n.dart';
import 'webSocket.dart';
import 'timerWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'localizationBloc.dart';
import 'package:percent_indicator/percent_indicator.dart';


Widget timerDialog(BuildContext context)  {
  return StreamBuilder(
    stream: downStream,
    builder: (context, snapShot)  {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        title: Text(
          S.of(context).timerDialog_title,
          textAlign: TextAlign.center,
          style: normalStyle,
        ),
        children: <Widget>[
          Container(
            width: double.maxFinite,
            child: FractionallySizedBox(
              widthFactor: 0.75,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: currentRoom.BGTimerDB.length,
                  itemBuilder: (context, int index) {
                    int typeIDplaceholder = currentRoom.taskDB.firstWhere(
                            (placeholder) =>  placeholder.id == currentRoom.BGTimerDB[index].taskID).typeID;
                    if(typeIDplaceholder==3||typeIDplaceholder==6)  {
                      return timerWidget(context,currentRoom.BGTimerDB[index]);
                      /*return LinearPercentIndicator(
                      //width: ,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2000,
                      percent: 0.9,
                      center: Text("90.0%"),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.greenAccent,
                  );*/
                    }
                    else  {
                      return Container();
                    }
                  }
              ),
            ),
          ),
          SimpleDialogOption(
              child: Text(
                "OK",
                textAlign: TextAlign.center,
                style: normalStyle,
              ),
              onPressed: () {
                //timerMenuOpen=false;
                Navigator.pop(context);
              }
          )
        ]
      );
    }
  );
}