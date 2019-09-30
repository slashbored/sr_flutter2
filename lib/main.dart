import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splashScreen.dart';
import 'localizationBloc.dart';


void main() {
  runApp(MyApp());
  LocalizationBloc bloc = LocalizationBloc();
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp>  {
  LocalizationBloc localizationBloc = LocalizationBloc();

  Widget build(BuildContext context) {
   return BlocProvider<LocalizationBloc>(
     builder: (BuildContext) => localizationBloc,
     child: BlocBuilder(
       bloc: localizationBloc,
       builder: (context, String lelocale)  {
         return MaterialApp(
           locale: Locale(lelocale),
           title: 'Shitroulette',
           localizationsDelegates: [
             //_localeOverrideDelegate,
             S.delegate
           ],
           supportedLocales: [
             const Locale("de", ""),
             const Locale("en", "")
           ],
           theme: new ThemeData(
             primaryColor: Colors.black,
           ),
           home: new splashScreen(
           ),
         );
       }
     )
   );
  }
}


