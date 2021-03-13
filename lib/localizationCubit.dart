import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationCubit extends Cubit<String> {
  LocalizationCubit():super("en");

  void switchToEn() =>  emit("en");
  void switchToDe() =>  emit("de");
}
