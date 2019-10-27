import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'localizationBloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'roomSelection.dart';
import 'playerEditing.dart';


class languageSelection extends StatefulWidget{
  @override
  languageSelectionState createState() => new languageSelectionState();
}

class languageSelectionState extends State<languageSelection>{

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
    final LocalizationBloc localizationBloc= BlocProvider.of<LocalizationBloc>(context);
    return new BlocProvider<LocalizationBloc>(
      builder: (BuildContext) => localizationBloc,
      child: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: new Center(
                      child: new Text(
                        S.of(context).languageSelector
                      ),
                    ),
                    flex: 1
                  ),
                  new Expanded(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Flexible(
                          child: new FloatingActionButton.extended(
                            heroTag: 'FABen',
                            label: Text("english"),
                            onPressed: () {
                              _setLoc('en');
                              localizationBloc.dispatch(switchEvent.switchToEn);
                              print(Localizations.localeOf(context).toString());
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => playerEditing()));
                            }
                          ),
                          flex: 1
                        ),
                        new Flexible(
                          child: new FloatingActionButton.extended(
                            heroTag: 'FABde',
                            label: Text("deutsch"),
                            onPressed: () {
                              _setLoc('de');
                              localizationBloc.dispatch(switchEvent.switchToDe);
                              print(Localizations.localeOf(context).toString());
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => playerEditing()));
                            }
                          ),
                          flex: 1,
                        ),
                        new Spacer(
                          flex: 1
                        )
                      ],
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
}