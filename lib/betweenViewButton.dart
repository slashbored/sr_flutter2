import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sr_flutter2/webSocket.dart';
import 'generated/i18n.dart';
import 'dart:convert';

import 'webSocket.dart';
import 'roomClass.dart';
import 'playerClass.dart';
import 'taskViewPage.dart';

Widget betweenViewButton(BuildContext context)  {
  if  (currentRoom.isWaiting)  {
    return FloatingActionButton(
      heroTag:'comparison_waiting',
      child: Icon(Icons.hourglass_empty),
      backgroundColor: Colors.grey,
      onPressed: () {
      },
    );
  }
  else  {
    return FloatingActionButton(
      heroTag:'comparison_done',
      child: Icon(Icons.arrow_forward_ios),
      backgroundColor: Colors.green,
      onPressed: () {
        upStream.add(json.encode({'type':'clearComparison','content':''}));
        upStream.add(json.encode({'type':'randomTask','content':''}));
        upStream.add(json.encode({'type':'randomPlayer','content':''}));
        upStream.add(json.encode({'type':'nextTask','content':''}));
      },
    );
  }
}