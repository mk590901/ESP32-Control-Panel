import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import '../gui_adapter/service_adapter.dart';
import '../utils.dart';

// Defining BLoC States
abstract class ColorEvent {}

class ChangeColorEvent extends ColorEvent {
  final Color color;
  ChangeColorEvent(this.color);
}

class ChangeEsp32ColorEvent extends ColorEvent {
  final Color color;
  ChangeEsp32ColorEvent(this.color);
}

// Defining BLoC States
class ColorState {
  final Color iconColor;
  ColorState(this.iconColor);
}

// BLoC for managing icon colors
class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorState(Colors.grey)) {

    ServiceAdapter.instance()?.setColorBloc(this);

    on<ChangeEsp32ColorEvent>((event, emit) {
      String jsonString = composeColorJsonString(event.color);
      FlutterForegroundTask.sendData({'command': 'color', 'data': jsonString});
      emit(ColorState(Colors.blueGrey));  //  <- Gray
    });

    on<ChangeColorEvent>((event, emit) {
      emit(ColorState(event.color));  //  <- Gray
    });


  }
}
