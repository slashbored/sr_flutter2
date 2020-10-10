import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'dart:convert';
import 'webSocket.dart';
import 'fadeTransitionRoute.dart';

Widget betweenViewButton(BuildContext context)  {
  if  (currentRoom.isWaiting)  {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
        child: Icon(
            Icons.hourglass_empty,
            color: Colors.white
        ),
        onPressed: () {
        },
      color: Colors.grey,
    );
  }
  else  {
    return FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white
        ),
        onPressed: () {
          upStream.add(json.encode({'type':'clearComparison','content':''}));
          upStream.add(json.encode({'type':'randomTask','content':''}));
          upStream.add(json.encode({'type':'randomPlayers','content':''}));
          upStream.add(json.encode({'type':'nextTask','content':''}));
        },
      color: Colors.green,
    );
  }
}