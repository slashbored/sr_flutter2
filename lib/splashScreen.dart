import 'package:flutter/material.dart';
import 'dart:async';

import 'modeSelector.dart';



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
    await Future.delayed(const Duration(seconds: 2  ), (){});
    Navigator.push(context, MaterialPageRoute(builder: (context) => modeSelector()));
  }
}