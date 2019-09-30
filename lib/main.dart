import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splashScreen.dart';
import 'localizationBloc.dart';
import 'languageSelection.dart';


void main() {
  runApp(MyApp());
  LocalizationBloc bloc = LocalizationBloc();
}


class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MyAppState();
}


class MyAppState extends State<MyApp>  {

  static Locale theLocale;
  LocalizationBloc localizationBloc = LocalizationBloc();

  /*_initLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('loc')==null||prefs.getString('loc')=="")  {
      await prefs.setString('loc', "en");
    }
  }*/

  static switchLocale(String locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('loc', locale);
    theLocale = Locale(await prefs.get('loc'), "");
  }


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
           home: new languageSelection(
           ),
         );
       }
     )
   );
  }

}


