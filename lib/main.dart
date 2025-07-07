import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_palette_esp32/ui_components/mqtt_panel.dart';

import 'buttons_panel.dart';
import 'color_bloc.dart';
import 'gui_adapter/service_adapter.dart';
import 'home_page.dart';
import 'icon_panel.dart';
import 'ui_blocks/app_bloc.dart';
import 'ui_blocks/mqtt_bloc.dart';
import 'ui_components/control_panel.dart';

// The main app widget
void main() {
  ServiceAdapter.initInstance();
  // WidgetsFlutterBinding.ensureInitialized();
  // await initializeForegroundService();
  // await detectDeviceName();
  runApp(PaletteApp());
}

class PaletteApp extends StatelessWidget {
  const PaletteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppBloc()),
        BlocProvider(create: (context) => MqttBloc()),
        BlocProvider(create: (context) => ColorBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
/*
class PaletteApp extends StatelessWidget {
  const PaletteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColorBloc(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Colorful Icons App')),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //const ControlPanel(),
                //const MQTTPanel(),
                ButtonsPanel(),
                SizedBox(height: 16),
                IconPanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 */
