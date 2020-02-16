import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'dart:convert';
import 'webSocket.dart';
import 'fadeTransitionRoute.dart';

Widget betweenViewButton(BuildContext context)  {
  if  (currentRoom.isWaiting)  {
    return OutlineButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
        borderSide: BorderSide(
            width: 3,
            color: Colors.grey,
            style: BorderStyle.solid
        ),
        child: Icon(
            Icons.hourglass_empty,
            color: Colors.black
        ),
        onPressed: () {
        }
    );
  }
  else  {
    return OutlineButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        borderSide: BorderSide(
            width: 3,
            color: Colors.green,
            style: BorderStyle.solid
        ),
        child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black
        ),
        onPressed: () {
          upStream.add(json.encode({'type':'clearComparison','content':''}));
          upStream.add(json.encode({'type':'randomTask','content':''}));
          upStream.add(json.encode({'type':'randomPlayers','content':''}));
          upStream.add(json.encode({'type':'nextTask','content':''}));
        }
    );
  }
}