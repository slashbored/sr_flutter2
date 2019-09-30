import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'localizationBloc.dart';

import 'modeSelection.dart';


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
                              localizationBloc.dispatch(switchEvent.switchToEn);
                              print(Localizations.localeOf(context).toString());
                              Navigator.push(context, MaterialPageRoute(builder: (context) => modeSelection()));
                            }
                          ),
                          flex: 1
                        ),
                        new Flexible(
                          child: new FloatingActionButton.extended(
                            heroTag: 'FABde',
                            label: Text("deutsch"),
                            onPressed: () {
                              localizationBloc.dispatch(switchEvent.switchToDe);
                              print(Localizations.localeOf(context).toString());
                              Navigator.push(context, MaterialPageRoute(builder: (context) => modeSelection()));
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