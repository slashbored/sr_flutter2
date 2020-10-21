import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sr_flutter2/networkModeSelectionPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_flutter2/playerEditingPage.dart';
import 'localizationBloc.dart';
import 'menuDialogWidget.dart';
import 'backgroundDecorationWidget.dart';
import 'fadeTransitionRoute.dart';
import 'generated/l10n.dart';
import 'textStyles.dart';
import 'webSocket.dart';

class splashScreenPage extends StatefulWidget{
  @override
  splashScreenPageState createState() => new splashScreenPageState();
}

class splashScreenPageState extends State<splashScreenPage>{

  static LocalizationBloc localizationBloc;

  @override
  void initState()  {
    super.initState();
    setupPrefs();
    if (checkPrefs()) {
      pushDelayed5Sec(context, networkModeSelectionPage()); 
    }
    else {
      pushDelayed5Sec(context, playerEditingPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    localizationBloc= BlocProvider.of<LocalizationBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => _insertOverlay(context));
    return new BlocProvider(
      builder: (BuildContext) =>  localizationBloc,
      child: Container(
        decoration: backGroundDecoration,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Spacer(),
                  Text(
                    S.of(context).welcome,
                    style: headlineStyle,
                    textAlign: TextAlign.center
                  ),
                  Transform.scale(
                    scale: 0.4,
                    child: Image(
                      image: AssetImage(
                        'assets/coronapoop.png'
                      )
                    )
                  ),
                  Spacer()
                ]
              )
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
                  child: Icon(Icons.settings)
                )
              )
            )
          );
        }
      )
    );
  }

  pushDelayed5Sec(context, destinationPage) async{
    await Future.delayed(const Duration(seconds: 5), (){});
    Navigator.push(context, fadePageRoute(page: destinationPage));
  }

  bool checkPrefs() {
    if (prefs.getString('playerName')!=""&&prefs.getString('playerName')!=null
        &&prefs.getString('playerSex')!=""&&prefs.getString('playerSex')!=null) {
      return true;
    }
    else  {
      return false;
    }
  }
}