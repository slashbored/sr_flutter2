import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splashScreen.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MyAppState();
}


class MyAppState extends State<MyApp>  {

  static Locale theLocale;

  _initLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('loc')==null||prefs.getString('loc')=="")  {
      await prefs.setString('loc', "en");
    }
  }

  static switchLocale(String locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('loc', locale);
    theLocale = Locale(await prefs.get('loc'), "");
  }


  Widget build(BuildContext context) {

    /*@override
    void initState() {
      super.initState();
      theLocale = Localizations.localeOf(context);
      _initLocale();
    }*/

    return MaterialApp(
      locale: theLocale,
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

}


