import 'package:bloc/bloc.dart';

enum switchEvent  {switchToRed, switchToBlue, switchToGreen}

class OnlineTestBloc extends Bloc<switchEvent, String>  {
  @override
  String get initialState => 'white';

  @override
  Stream<String> mapEventToState(switchEvent event) async* {
    switch (event) {
      case switchEvent.switchToRed:
        yield 'red';
        break;
      case switchEvent.switchToBlue:
        yield 'blue';
        break;
      case switchEvent.switchToGreen:
        yield 'green';
        break;
    }
  }
}