import 'package:flutter/material.dart';
import 'package:sr_flutter2/networkModeSelectionPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'localizationBloc.dart';
import 'menuDialogWidget.dart';

class splashScreen extends StatefulWidget{
  @override
  splashScreenState createState() => new splashScreenState();
}

class splashScreenState extends State<splashScreen>{

  static LocalizationBloc localizationBloc;

  @override
  void initState()  {
    super.initState();
    pushToNetworkOrLanguageSelection(context);
  }

  @override
  Widget build(BuildContext context) {
    localizationBloc= BlocProvider.of<LocalizationBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => _insertOverlay(context));
    return new BlocProvider(
      builder: (BuildContext) =>  localizationBloc,
      child: Scaffold(
        body: Center(
          child: new Text('💩',
            style: TextStyle(
              fontSize: 72
            ),
            textAlign: TextAlign.center,
          )
        )
      )
    );
  }

  void _insertOverlay(BuildContext context) {
    return Overlay.of(context).insert(
      OverlayEntry(
        builder: (context) {
          final size = MediaQuery
              .of(context)
              .size;
          return Positioned(
            width: 56,
            height: 56,
            bottom: 28,
            left: size.width - 72,
            child: Transform.scale(
              scale: 1,
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {
                    if (settingsMenuOpen!=true) {
                      settingsMenuOpen=true;
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => menuDialog(context)
                      );
                    }
                  },
                  child: Icon(Icons.settings),
                )
              )
            )
          );
        }
      )
    );
  }

  pushToNetworkOrLanguageSelection(context) async{
    await Future.delayed(const Duration(seconds: 1  ), (){});
    Navigator.push(context, CupertinoPageRoute(builder: (context) => networkModeSelectionPage()));
  }
}