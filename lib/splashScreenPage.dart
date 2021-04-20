import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sr_flutter2/networkModeSelectionPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_flutter2/playerEditingPage.dart';
import 'localizationBloc.dart';
import 'localizationBloc.dart';
import 'menuDialogWidget.dart';
import 'backgroundDecorationWidget.dart';
import 'fadeTransitionRoute.dart';
import 'generated/l10n.dart';
import 'textStyles.dart';
import 'webSocket.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localizationCubit.dart';
import 'package:highlighter_coachmark/highlighter_coachmark.dart';

class splashScreenPage extends StatefulWidget{
  @override
  splashScreenPageState createState() => new splashScreenPageState();
}

class splashScreenPageState extends State<splashScreenPage>{

  static LocalizationCubit localizationCubit;

  @override
  void initState()  {
    super.initState();
    pushDelayed1Sec(context);

  }

  @override
  Widget build(BuildContext context) {
    localizationCubit= BlocProvider.of<LocalizationCubit>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => _insertOverlay(context));
    return new BlocProvider<LocalizationCubit>(
          create: (BuildContext) =>  LocalizationCubit(),
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
                            Text(
                              S.of(context).firstStart,
                              style: tinyStyle,
                              textAlign: TextAlign.center,
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

  pushDelayed1Sec(context) async{
    int i=0;
    while (prefs==null&&i<50){
      await new Future.delayed(const Duration(milliseconds: 100));
      i++;
    }
    await new Future.delayed(const Duration(milliseconds: 2000));
    if (checkPrefs()) {
      Navigator.push(context, fadePageRoute(page: networkModeSelectionPage()));
    }
    else {
      Navigator.push(context, fadePageRoute(page: playerEditingPage()));
    }

  }

}