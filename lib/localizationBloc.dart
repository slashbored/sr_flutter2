import 'package:bloc/bloc.dart';

enum switchEvent  {switchToDe, switchToEn}

class LocalizationBloc extends Bloc<switchEvent, String>  {
  @override
  String get initialState => "en";

  @override
  Stream<String> mapEventToState(switchEvent event) async* {
    switch (event) {
      case switchEvent.switchToDe:
        yield "de";
        break;
      case switchEvent.switchToEn:
        yield "en";
        break;
    }
  }
}