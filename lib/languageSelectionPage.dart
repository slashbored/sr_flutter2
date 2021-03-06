import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'localizationBloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bot_toast/bot_toast.dart';
import 'localizationCubit.dart';

import 'playerEditingPage.dart';


class languageSelectionPage extends StatefulWidget{
  @override
  languageSelectionPageState createState() => new languageSelectionPageState();
}

class languageSelectionPageState extends State<languageSelectionPage>{

  static LocalizationCubit localizationCubit;

  @override
  void initState()  {
    super.initState();
  }

  _setLoc(String loc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('locSet')==null||prefs.getBool('locSet')==false)  {
      await prefs.setBool('locSet', true);
    }
    await prefs.setString('loc', loc);
  }

  @override
  Widget build(BuildContext context) {
    localizationCubit= BlocProvider.of<LocalizationCubit>(context);
    return new BlocProvider<LocalizationCubit>(
      create: (BuildContext) => LocalizationCubit(),
      child: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: new Center(
                      child: new Text(S.of(context).languageSelector)
                    )
                  ),
                  new Expanded(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Flexible(
                          flex: 1,
                          child: new FloatingActionButton.extended(
                            heroTag: 'FABen',
                            label: Text("english"),
                            onPressed: () {
                              _setLoc('en');
                              localizationCubit.switchToEn();
                              S.delegate.load(Locale("en", ""),);
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => playerEditingPage()));
                            }
                          )
                        ),
                        new Flexible(
                          flex: 1,
                          child: new FloatingActionButton.extended(
                            heroTag: 'FABde',
                            label: Text("deutsch"),
                            onPressed: () {
                              _setLoc('de');
                              localizationCubit.switchToDe();
                              S.delegate.load(Locale("de", ""));
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => playerEditingPage()));
                            }
                          )
                        ),
                        new Flexible(
                            child: new FloatingActionButton.extended(
                              heroTag:  'clearPrefs',
                              label: Text("Clear Prefs"),
                              onPressed:  ()  {
                                _clearPrefs();
                                BotToast.showText(
                                  text: "Text 1",
                                  duration: (Duration(seconds: 5))
                                );
                                Future.delayed(Duration(seconds: 5), (){
                                  BotToast.showText(
                                      text: "Text 2"
                                  );
                                }
                                );
                              })),
                        new Spacer(
                          flex: 1
                        )
                      ]
                    ),
                    flex: 1
                  )
                ]
              )
            );
          }
        )
      )
    );
  }

  _clearPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

}