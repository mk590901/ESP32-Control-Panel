import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import '../command_model.dart';
import '../ui_blocks/color_bloc.dart';
import '../color_model.dart';
import '../ui_blocks/app_bloc.dart';
import '../ui_blocks/mqtt_bloc.dart';

class ServiceAdapter {
  static ServiceAdapter? _instance;

  late AppBloc? _appBloc;
  late MqttBloc? _mqttBloc;
  late ColorBloc? _colorBloc;
  late String _deviceName = '';

  static void initInstance() {
    _instance ??= ServiceAdapter();
    print ('ServiceAdapter.initInstance -- Ok');
  }

  static ServiceAdapter? instance() {
    if (_instance == null) {
      throw Exception("--- ServiceAdapter was not initialized ---");
    }
    return _instance;
  }

  void setDeviceName(String deviceName) {
    _deviceName = deviceName;
    print ('PHONE->[$_deviceName]');
  }

  String getDeviceName() {
    return _deviceName;
  }

  void setAppBloc(AppBloc? appBloc) {
    _appBloc = appBloc;
  }

  void setMQTTBloc(MqttBloc? mqttBloc) {
    _mqttBloc = mqttBloc;
  }

  void setColorBloc(ColorBloc? colorBloc) {
    _colorBloc = colorBloc;
  }

  void mqttConnect() {
    _mqttBloc?.add(MqttEvent.connect);
  }

  void mqttSubscribe() {
    _mqttBloc?.add(MqttEvent.subscribe);
  }

  void mqttUnsubscribe() {
    _mqttBloc?.add(MqttEvent.unsubscribe);
  }

  void mqttDisconnect() {
    _mqttBloc?.add(MqttEvent.disconnect);
  }

  void start() {
    print ('------- ServiceAdapter.start -------');
  }

  void stop() {
    print ('------- ServiceAdapter.stop -------');
  }

  void setProgress(bool progress) {
    _mqttBloc?.add(InProgressEvent(progress));
    print ('******* setProgress $progress ******* ${DateTime.now()}');
  }

  void setColor(String jsonString) {
    ColorModel color = ColorModel.restoreFromJson(jsonString);
// Convert to Flutter Color
    Color flutterColor = color.toColor(); // Orange color
    //print ('******* setColor [${color.r},${color.g},${color.b}] *******');
    _colorBloc?.add(ChangeColorEvent(flutterColor));

  }

  void stopEsp32() {
    final Command command = Command(cmd: "stop");
    String jsonString = jsonEncode(command.toJson());
    FlutterForegroundTask.sendData({'command': 'stop', 'data': jsonString});
  }

  void breakEsp32() {
    final Command command = Command(cmd: "break");
    String jsonString = jsonEncode(command.toJson());
    FlutterForegroundTask.sendData({'command': 'break', 'data': jsonString});
  }

  void executeCommand(String jsonString) {
    Command command = Command.fromJsonString(jsonString);
    print ('executeCommand->[${command.cmd}]');
  }

}
