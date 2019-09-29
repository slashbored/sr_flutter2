import 'package:flutter/material.dart';
import 'package:sr_flutter2/main.dart';
import 'generated/i18n.dart';
import 'main.dart';

import 'splashScreen.dart';
import 'playerSelector.dart';
import 'modeSelector.dart';


class languageSelection extends StatefulWidget{
  @override
  languageSelectionState createState() => new languageSelectionState();
}

class languageSelectionState extends State<languageSelection>{

  @override
  void initState()  {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Builder(
            builder: (BuildContext context) {
              return Center(
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Expanded(
                            child: new Center(
                              child: new Text(
                                  S.of(context).modeSelector
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
                                          setState(() {
                                            MyAppState.switchLocale("en");
                                            S.delegate.load(Locale("en", ""));
                                          });
                                          print(Localizations.localeOf(context).toString());
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => splashScreen()));
                                        }
                                    ),
                                    flex: 1
                                ),
                                new Flexible(
                                    child: new FloatingActionButton.extended(
                                        heroTag: 'FABde',
                                        label: Text("deutsch"),
                                        onPressed: () {
                                          setState(() {
                                            MyAppState.switchLocale("de");
                                            S.delegate.load(Locale("de", ""));
                                          });
                                          print(Localizations.localeOf(context).toString());
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => splashScreen()));
                                        }
                                    )
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
    );
  }

  void _showToastComingSoon(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
        SnackBar(
          content: Text(
            S.of(context).comingSoon,
            textAlign: TextAlign.center,),
          duration: Duration(seconds: 3),
        )
    );
  }


}