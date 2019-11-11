import 'package:flutter/material.dart';
import 'package:sr_flutter2/languageSelection.dart';
import 'generated/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'localizationBloc.dart';


void main() {
  runApp(MyApp());
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MyAppState();


}

class MyAppState extends State<MyApp>  {
  LocalizationBloc localizationBloc = LocalizationBloc();

  static initLocale(LocalizationBloc blocHolder) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('locSet')==null||prefs.getBool('locSet')==false)  {
      await prefs.setString('loc', "en");
    }
    await prefs.get('loc')=="en"?blocHolder.dispatch(switchEvent.switchToEn):blocHolder.dispatch(switchEvent.switchToDe);
  }

  @override
  void initState()  {
    super.initState();
    initLocale(localizationBloc);
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
           home: new languageSelection(),
         );
       }
     )
   );
  }
}