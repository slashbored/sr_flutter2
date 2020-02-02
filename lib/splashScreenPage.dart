import 'package:flutter/material.dart';
import 'package:sr_flutter2/networkModeSelectionPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'localizationBloc.dart';
import 'languageSelectionPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashScreen extends StatefulWidget{
  @override
  splashScreenState createState() => new splashScreenState();
}

class splashScreenState extends State<splashScreen>{

  static LocalizationBloc localizationBloc;


  final Widget svg_germanFlag = SvgPicture.asset('assets/germany.svg');
  final Widget svg_britishFlag = SvgPicture.asset('assets/united-kingdom.svg');
  final Widget svg_male = SvgPicture.asset('assets/man.svg');
  final Widget svg_female = SvgPicture.asset('assets/woman.svg');

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

  void switchLanguage(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (Localizations.localeOf(context).toString()=='en_'||Localizations.localeOf(context).toString()=='en')  {
      localizationBloc.dispatch(switchEvent.switchToDe);
      prefs.setString('loc', 'de');
    }
    else  {
      localizationBloc.dispatch(switchEvent.switchToEn);
      prefs.setString('loc', 'en');
    }
  }

  void _insertOverlay(BuildContext context) {
    return Overlay.of(context).insert(
      OverlayEntry(builder: (context) {
        final size = MediaQuery
            .of(context)
            .size;
        return Positioned(
          width: 56,
          height: 56,
          top: 36,
          left: size.width - 72,
          child: Transform.scale(
            scale: 0.5,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () => switchLanguage(context),
                child: otherFlag(),
              ),
            ),
          ),
        );
      }),
    );
  }

  Container otherFlag() {
    if (Localizations.localeOf(context).toString()=='en_'||Localizations.localeOf(context).toString()=='en')  {
      return Container(
          child: svg_britishFlag
      );
    }
    else  {
      return Container(
          child: svg_germanFlag
      );
    }
  }

  pushToNetworkOrLanguageSelection(context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 1  ), (){});
    if (prefs.getBool('locSet')==null||prefs.getBool('locSet')==false)  {
      Navigator.push(context, CupertinoPageRoute(builder: (context) =>  languageSelectionPage()));
    }
    else  {
      Navigator.push(context, CupertinoPageRoute(builder: (context) => networkModeSelectionPage()));
    }
  }
}