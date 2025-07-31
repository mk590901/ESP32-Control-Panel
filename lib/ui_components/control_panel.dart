// Control panel (Start/Stop и Switch)
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../gui_adapter/service_adapter.dart';
import '../ui_blocks/app_bloc.dart';
import '../ui_blocks/mqtt_bloc.dart';
import '../ui_blocks/color_bloc.dart';
import '../utils.dart';

class ControlPanel extends StatelessWidget {

  final List<Color> buttonColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.cyan,
    Colors.pink,
  ];

  late Timer? timer;

  /*const*/ ControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    timer = null;
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.isRunning
                        ? 'Service is Running'
                        : 'Service is Stopped',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const Divider(height: 4),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (state.isRunning) {
                        context.read<AppBloc>().add(StopService());
                        ServiceAdapter.instance()?.mqttUnsubscribe(); //  via MqttBloc
                        ServiceAdapter.instance()?.mqttDisconnect();
                      }
                      else {
                        context.read<AppBloc>().add(StartService());
                      }
                    },
                    child: Text(state.isRunning ? 'Stop' : 'Start'),
                  ),


                  ElevatedButton(
                    onPressed: () {
                      if (state.isRunning) {
                        if (context.read<MqttBloc>().state.isConnected
                        &&  context.read<MqttBloc>().state.isSubscribed) {
                          ServiceAdapter.instance()?.stopEsp32();
                          showToast(context, "The application running on the ESP32-S3 has been terminated and cannot be used any further. Please restart it with jag to resume interaction.");
                        }
                        else {
                          showToast(context, "MQTT problems");
                        }
                      }
                      else {
                        showToast(context, "Service isn't run");
                      }
                    },
                    child: Text('Stop ESP32-S3', ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (state.isRunning) {
                        if (context.read<MqttBloc>().state.isConnected
                            &&  context.read<MqttBloc>().state.isSubscribed) {
                          //ServiceAdapter.instance()?.breakEsp32();
                          //showToast(context, "The MQTT Client running on the ESP32-S3 has been closed.");
                          if (timer == null) {
                            startTimer(context);
                          }
                          else {
                            stopTimer();
                          }
                        }
                        else {
                          showToast(context, "MQTT problems");
                        }
                      }
                      else {
                        showToast(context, "Service isn't run");
                      }
                    },
                    child: Text('X', ),
                  ),

                  //@Text('# ${state.counter}'),

                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void startTimer(BuildContext context) {
    int index = -1;
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      //print('Timer tick: ${DateTime.now()}');
      index++;
      if (index >= buttonColors.length) {
        index = 0;
      }
      context.read<ColorBloc>().add(ChangeEsp32ColorEvent(buttonColors[index]));
    });
    print('Timer started');
  }

  // Function to stop the timer
  void stopTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
      timer = null;
      print('Timer stopped');
    } else {
      print('Timer is not running');
    }
  }

}
