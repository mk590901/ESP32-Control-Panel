import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import 'color_model.dart';
import 'utils.dart';

// Defining BLoC States
abstract class ColorEvent {}

class ChangeColorEvent extends ColorEvent {
  final Color color;
  ChangeColorEvent(this.color);
}

// Defining BLoC States
class ColorState {
  final Color iconColor;
  ColorState(this.iconColor);
}

// BLoC for managing icon colors
class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorState(Colors.grey)) {
    on<ChangeColorEvent>((event, emit) {
      String jsonString = composeColorJsonString(event.color);
      FlutterForegroundTask.sendData({'command': 'color', 'data': jsonString});
      emit(ColorState(event.color));  //  <- Gray
    });
  }
}
