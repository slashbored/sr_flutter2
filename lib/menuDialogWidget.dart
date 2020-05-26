import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'localizationBloc.dart';

final Widget svg_germanFlag = SvgPicture.asset('assets/germany.svg');
final Widget svg_britishFlag = SvgPicture.asset('assets/united-kingdom.svg');
final Widget svg_male = SvgPicture.asset('assets/man.svg');
final Widget svg_female = SvgPicture.asset('assets/woman.svg');

bool settingsMenuOpen=false;
BuildContext menuDialogContext;

Widget menuDialog(BuildContext context) {
  menuDialogContext = context;
  final LocalizationBloc localizationBloc= BlocProvider.of<LocalizationBloc>(context);
  return SimpleDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20))
    ),
    title: Text(
      S.of(context).settings_headline,
      textAlign: TextAlign.center,
      style: normalStyle,
      ),
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            child: Text(
            S.of(context).settings_language,
            textAlign: TextAlign.center,
            style: normalStyle,
            ),
          ),
          Flexible(
            child: SizedBox(
              height: 28,
              width: 28,
              child: Transform.scale(
                  scale: 0.5,
                  child: Material(
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: () => switchLanguage(context, localizationBloc),
                        child: otherFlag(context),
                      )
                  )
              )
            )
          )
        ]
  ),
      SimpleDialogOption(
        child: Text(
          "OK",
          textAlign: TextAlign.center,
          style: normalStyle,
        ),
        onPressed: () {
          settingsMenuOpen=false;
          Navigator.pop(context);
        }
      )
    ]
  );
}

Container otherFlag(BuildContext context) {
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

void switchLanguage(BuildContext context, LocalizationBloc localizationBloc) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getBool('locSet')==null||prefs.getBool('locSet')==false)  {
    await prefs.setString('loc', "en");
    await prefs.setBool('locSet', true);
  }
  await prefs.get('loc')=="en"?localizationBloc.dispatch(switchEvent.switchToEn):localizationBloc.dispatch(switchEvent.switchToDe);
  if (Localizations.localeOf(context).toString()=='en_'||Localizations.localeOf(context).toString()=='en')  {
    localizationBloc.dispatch(switchEvent.switchToDe);
    prefs.setString('loc', 'de');
  }
  else  {
    localizationBloc.dispatch(switchEvent.switchToEn);
    prefs.setString('loc', 'en');
  }
}