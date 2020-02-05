import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'dart:convert';

import 'webSocket.dart';

Widget betweenViewButton(BuildContext context)  {
  if  (currentRoom.isWaiting)  {
    return FloatingActionButton(
      heroTag:'comparison_waiting',
      child: Icon(
        Icons.hourglass_empty,
        color: Colors.grey,),
      backgroundColor: Colors.transparent,
      elevation: 0,
      highlightElevation: 0,
      onPressed: () {
      },
    );
  }
  else  {
    return FloatingActionButton(
      heroTag:'comparison_done',
      child: Icon(
        Icons.arrow_forward_ios,
        color: Colors.green,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      highlightElevation: 0,
      onPressed: () {
        upStream.add(json.encode({'type':'clearComparison','content':''}));
        upStream.add(json.encode({'type':'randomTask','content':''}));
        upStream.add(json.encode({'type':'randomPlayers','content':''}));
        upStream.add(json.encode({'type':'nextTask','content':''}));
      },
    );
  }
}