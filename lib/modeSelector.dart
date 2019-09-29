import 'package:flutter/material.dart';
import 'package:sr_flutter2/main.dart';
import 'generated/i18n.dart';
import 'main.dart';

import 'splashScreen.dart';
import 'playerSelector.dart';


class modeSelector extends StatefulWidget{
  @override
  modeSelectorState createState() => new modeSelectorState();
}

class modeSelectorState extends State<modeSelector>{
  
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
                                    heroTag: 'FABOnline',
                                    label: Text("Online"),
                                    onPressed: () {
                                      _showToastComingSoon(context);
                                    }
                                ),
                                flex: 1
                            ),
                            new Flexible(
                                child: new FloatingActionButton.extended(
                                    heroTag: 'FABOffline',
                                    label: Text("Offline"),
                                    onPressed: () {
                                      setState(() {
                                        MyAppState.switchLocale("de");
                                      });
                                      print(Localizations.localeOf(context).toString());
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