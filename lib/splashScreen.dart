import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'languageSelection.dart';
import 'roomSelection.dart';


class splashScreen extends StatefulWidget{
  @override
  splashScreenState createState() => new splashScreenState();
}

class splashScreenState extends State<splashScreen>{

  @override
  void initState()  {
    super.initState();
    _pushTomodeSelector(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: new Text('💩',
          style: TextStyle(
            fontSize: 54
          ),
          textAlign: TextAlign.center,
        )
      )
    );
  }

  _pushTomodeSelector(context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 3  ), (){});
    if(prefs.getBool('locSet')==null||prefs.getBool('locSet')==false){
      Navigator.push(context, CupertinoPageRoute(builder: (context) => languageSelection()));
    }
    else  {
      Navigator.push(context, CupertinoPageRoute(builder: (context) => roomSelection()));
    }
  }
}