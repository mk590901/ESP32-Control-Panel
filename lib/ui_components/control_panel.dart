// Control panel (Start/Stop и Switch)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../gui_adapter/service_adapter.dart';
import '../ui_blocks/app_bloc.dart';
import '../ui_blocks/mqtt_bloc.dart';
import '../utils.dart';
//import '../ui_blocks/items_bloc.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
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
                        ServiceAdapter.instance()?.stopTimer();
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
                        }
                        else {
                          showToast(context, "MQTT problems");
                        }
                        // context.read<AppBloc>().add(StopService());
                        // ServiceAdapter.instance()?.stopTimer();
                        // ServiceAdapter.instance()?.mqttUnsubscribe(); //  via MqttBloc
                        // ServiceAdapter.instance()?.mqttDisconnect();
                      }
                      else {
                        showToast(context, "Service isn't run");
                      //  context.read<AppBloc>().add(StartService());
                      }
                    },
                    child: Text('Stop ESP32-S3', ),
                  ),


                  Text('# ${state.counter}'),

                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
