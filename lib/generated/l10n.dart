// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Shitroulette!\n(Quarrrrraantine Edition)`
  String get welcome {
    return Intl.message(
      'Shitroulette!\n(Quarrrrraantine Edition)',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Please select the language:`
  String get languageSelector {
    return Intl.message(
      'Please select the language:',
      name: 'languageSelector',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Please select the gamemode:`
  String get modeSelector {
    return Intl.message(
      'Please select the gamemode:',
      name: 'modeSelector',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name and gender:`
  String get enterName {
    return Intl.message(
      'Please enter your name and gender:',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `Please complete your entries.`
  String get pleaseCompleteEntries {
    return Intl.message(
      'Please complete your entries.',
      name: 'pleaseCompleteEntries',
      desc: '',
      args: [],
    );
  }

  /// `Create a game`
  String get createRoom {
    return Intl.message(
      'Create a game',
      name: 'createRoom',
      desc: '',
      args: [],
    );
  }

  /// `Join a game`
  String get joinRoom {
    return Intl.message(
      'Join a game',
      name: 'joinRoom',
      desc: '',
      args: [],
    );
  }

  /// `Gamecode`
  String get joinRoom_hintText {
    return Intl.message(
      'Gamecode',
      name: 'joinRoom_hintText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a gamecode.`
  String get joinRoom_enterNumber {
    return Intl.message(
      'Please enter a gamecode.',
      name: 'joinRoom_enterNumber',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, but there's already a game being played here.`
  String get joinRoom_roomAlreadyRunning {
    return Intl.message(
      'Sorry, but there\'s already a game being played here.',
      name: 'joinRoom_roomAlreadyRunning',
      desc: '',
      args: [],
    );
  }

  /// `No game found.`
  String get joinRoom_roomNotFound {
    return Intl.message(
      'No game found.',
      name: 'joinRoom_roomNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings_headline {
    return Intl.message(
      'Settings',
      name: 'settings_headline',
      desc: '',
      args: [],
    );
  }

  /// `Language:`
  String get settings_language {
    return Intl.message(
      'Language:',
      name: 'settings_language',
      desc: '',
      args: [],
    );
  }

  /// `Coming soon!™\n( ͡° ͜ʖ ͡°)`
  String get comingSoon {
    return Intl.message(
      'Coming soon!™\n( ͡° ͜ʖ ͡°)',
      name: 'comingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get sexMale {
    return Intl.message(
      'Male',
      name: 'sexMale',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get sexX {
    return Intl.message(
      'Other',
      name: 'sexX',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get sexFemale {
    return Intl.message(
      'Female',
      name: 'sexFemale',
      desc: '',
      args: [],
    );
  }

  /// `No players yet!`
  String get noPlayersYet {
    return Intl.message(
      'No players yet!',
      name: 'noPlayersYet',
      desc: '',
      args: [],
    );
  }

  /// `Your turn!`
  String get ownTurn {
    return Intl.message(
      'Your turn!',
      name: 'ownTurn',
      desc: '',
      args: [],
    );
  }

  /// `s turn`
  String get turn {
    return Intl.message(
      's turn',
      name: 'turn',
      desc: '',
      args: [],
    );
  }

  /// `Pantomime this:`
  String get mimeThis {
    return Intl.message(
      'Pantomime this:',
      name: 'mimeThis',
      desc: '',
      args: [],
    );
  }

  /// `What is `
  String get tabooMimeGuessp1 {
    return Intl.message(
      'What is ',
      name: 'tabooMimeGuessp1',
      desc: '',
      args: [],
    );
  }

  /// ` trying to tell us?`
  String get tabooMimeGuessp2 {
    return Intl.message(
      ' trying to tell us?',
      name: 'tabooMimeGuessp2',
      desc: '',
      args: [],
    );
  }

  /// `Explain "`
  String get taboop1 {
    return Intl.message(
      'Explain "',
      name: 'taboop1',
      desc: '',
      args: [],
    );
  }

  /// `" without using the following words:`
  String get taboop2 {
    return Intl.message(
      '" without using the following words:',
      name: 'taboop2',
      desc: '',
      args: [],
    );
  }

  /// `EZ`
  String get tabooMimeWinStyle1 {
    return Intl.message(
      'EZ',
      name: 'tabooMimeWinStyle1',
      desc: '',
      args: [],
    );
  }

  /// `Nobody knows`
  String get tabooMimeFailStyle1 {
    return Intl.message(
      'Nobody knows',
      name: 'tabooMimeFailStyle1',
      desc: '',
      args: [],
    );
  }

  /// `List the following, go clockwise, `
  String get listThis {
    return Intl.message(
      'List the following, go clockwise, ',
      name: 'listThis',
      desc: '',
      args: [],
    );
  }

  /// `Just between you and me (and the others),`
  String get compareThis {
    return Intl.message(
      'Just between you and me (and the others),',
      name: 'compareThis',
      desc: '',
      args: [],
    );
  }

  /// `Ye`
  String get yesStyle1 {
    return Intl.message(
      'Ye',
      name: 'yesStyle1',
      desc: '',
      args: [],
    );
  }

  /// `Nope.`
  String get noStyle1 {
    return Intl.message(
      'Nope.',
      name: 'noStyle1',
      desc: '',
      args: [],
    );
  }

  /// `I don't wanna`
  String get noStyle2 {
    return Intl.message(
      'I don\'t wanna',
      name: 'noStyle2',
      desc: '',
      args: [],
    );
  }

  /// `Dunno`
  String get listFailedStyle1 {
    return Intl.message(
      'Dunno',
      name: 'listFailedStyle1',
      desc: '',
      args: [],
    );
  }

  /// `Go!`
  String get FGTimerGo {
    return Intl.message(
      'Go!',
      name: 'FGTimerGo',
      desc: '',
      args: [],
    );
  }

  /// `K!`
  String get BGTimerGo {
    return Intl.message(
      'K!',
      name: 'BGTimerGo',
      desc: '',
      args: [],
    );
  }

  /// `👍🏻`
  String get FGTimerDone {
    return Intl.message(
      '👍🏻',
      name: 'FGTimerDone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number.`
  String get pleaseEnterValidNumber {
    return Intl.message(
      'Please enter a valid number.',
      name: 'pleaseEnterValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for the others to input..`
  String get waitingForOthersToInput {
    return Intl.message(
      'Waiting for the others to input..',
      name: 'waitingForOthersToInput',
      desc: '',
      args: [],
    );
  }

  /// `It's a draw!`
  String get comparisonDraw {
    return Intl.message(
      'It\'s a draw!',
      name: 'comparisonDraw',
      desc: '',
      args: [],
    );
  }

  /// `Please select your gamemode:`
  String get networkMode_headline {
    return Intl.message(
      'Please select your gamemode:',
      name: 'networkMode_headline',
      desc: '',
      args: [],
    );
  }

  /// `Please select your gamestyle:`
  String get modeTitle_headline {
    return Intl.message(
      'Please select your gamestyle:',
      name: 'modeTitle_headline',
      desc: '',
      args: [],
    );
  }

  /// `Endless`
  String get modeTitle_endless {
    return Intl.message(
      'Endless',
      name: 'modeTitle_endless',
      desc: '',
      args: [],
    );
  }

  /// `Gather points`
  String get modeTitle_reach {
    return Intl.message(
      'Gather points',
      name: 'modeTitle_reach',
      desc: '',
      args: [],
    );
  }

  /// `Lose points`
  String get modeTitle_lose {
    return Intl.message(
      'Lose points',
      name: 'modeTitle_lose',
      desc: '',
      args: [],
    );
  }

  /// ` has left the game.`
  String get hasLeftGame {
    return Intl.message(
      ' has left the game.',
      name: 'hasLeftGame',
      desc: '',
      args: [],
    );
  }

  /// ` is the new GM.`
  String get isNewGM {
    return Intl.message(
      ' is the new GM.',
      name: 'isNewGM',
      desc: '',
      args: [],
    );
  }

  /// ` chose to drink instead.`
  String get choseToDrink {
    return Intl.message(
      ' chose to drink instead.',
      name: 'choseToDrink',
      desc: '',
      args: [],
    );
  }

  /// `Active timers`
  String get timerViewDialog_title {
    return Intl.message(
      'Active timers',
      name: 'timerViewDialog_title',
      desc: '',
      args: [],
    );
  }

  /// `You is done!`
  String get timerDoneDialog_title {
    return Intl.message(
      'You is done!',
      name: 'timerDoneDialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `you start!`
  String get listYouStart {
    return Intl.message(
      'you start!',
      name: 'listYouStart',
      desc: '',
      args: [],
    );
  }

  /// ` starts!`
  String get listNotYouStart {
    return Intl.message(
      ' starts!',
      name: 'listNotYouStart',
      desc: '',
      args: [],
    );
  }

  /// `So ...`
  String get wyr_title {
    return Intl.message(
      'So ...',
      name: 'wyr_title',
      desc: '',
      args: [],
    );
  }

  /// `Pull out ... , let's compare!`
  String get compare_title {
    return Intl.message(
      'Pull out ... , let\'s compare!',
      name: 'compare_title',
      desc: '',
      args: [],
    );
  }

  /// `(tap this you're if out of ideas)`
  String get list_expl {
    return Intl.message(
      '(tap this you\'re if out of ideas)',
      name: 'list_expl',
      desc: '',
      args: [],
    );
  }

  /// `(first one to guess makes everybody, excluding the actor, drink)`
  String get tabooMime_expl {
    return Intl.message(
      '(first one to guess makes everybody, excluding the actor, drink)',
      name: 'tabooMime_expl',
      desc: '',
      args: [],
    );
  }

  /// `(if no one gusses or you just don't wanna, click the beers)`
  String get tabooMime_failexpl {
    return Intl.message(
      '(if no one gusses or you just don\'t wanna, click the beers)',
      name: 'tabooMime_failexpl',
      desc: '',
      args: [],
    );
  }

  /// `his`
  String get nounhis {
    return Intl.message(
      'his',
      name: 'nounhis',
      desc: '',
      args: [],
    );
  }

  /// `her`
  String get nounher {
    return Intl.message(
      'her',
      name: 'nounher',
      desc: '',
      args: [],
    );
  }

  /// `he`
  String get nounhe {
    return Intl.message(
      'he',
      name: 'nounhe',
      desc: '',
      args: [],
    );
  }

  /// `she`
  String get nounshe {
    return Intl.message(
      'she',
      name: 'nounshe',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}