import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:sr_flutter2/splashScreenPage.dart';
import 'generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'webSocket.dart';
import 'localizationBloc.dart';
import 'localizationCubit.dart';


void main() {
  runApp(MyApp());
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp>  {
  LocalizationCubit localizationCubit = LocalizationCubit();

  static initLocale(LocalizationCubit cubitHolder) async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('locSet')==null||prefs.getBool('locSet')==false)  {
      await prefs.setString('loc', "en");
    }
    await prefs.get('loc')=="en"?cubitHolder.switchToEn():cubitHolder.switchToDe();
    if (!prefs.containsKey('playerName')) {
      if (prefs.getString('playerName')==null)  {
        await prefs.setString('playerName',"");
      }
    }if (!prefs.containsKey('playerSex')) {
      if (prefs.getString('playerSex')==null)  {
        await prefs.setString('playerSex',"");
      }
    }
    nameTextfieldController.text= prefs.getString('playerName');
  }

  @override
  void initState()  {
    super.initState();
    initLocale(localizationCubit);
    SystemChrome.setEnabledSystemUIOverlays([]);

  }

  Widget build(BuildContext context) {
   return BlocProvider(
     create: (BuildContext context) => LocalizationCubit(),
     child: BlocBuilder<LocalizationCubit, String>(
       builder: (context, localizationCubit)  {
         return MaterialApp(
           builder: BotToastInit(),
           debugShowCheckedModeBanner: false,
           navigatorObservers: [BotToastNavigatorObserver()],
           locale: Locale(localizationCubit, ""),
           title: 'Shitroulette',
           localizationsDelegates: [
             //_localeOverrideDelegate,
             S.delegate,
             GlobalMaterialLocalizations.delegate,
             GlobalCupertinoLocalizations.delegate
           ],
           supportedLocales:
           S.delegate.supportedLocales
           /*const Locale("de", ""),
           const Locale("en", "")*/
           ,
           theme: new ThemeData(
             primaryColor: Colors.black,
           ),
           home: new splashScreenPage()
         );
       }
     )
   );
  }
}

// TODO: make it work via bloc, not streambuilder, possibly preventing rebuilds