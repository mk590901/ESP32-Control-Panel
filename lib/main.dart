import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui_blocks/color_bloc.dart';
import 'gui_adapter/service_adapter.dart';
import 'home_page.dart';
import 'service_components/foreground_service.dart';
import 'ui_blocks/app_bloc.dart';
import 'ui_blocks/mqtt_bloc.dart';

// The main app widget
void main() async {
  ServiceAdapter.initInstance();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeForegroundService();
  await detectDeviceName();
  runApp(PaletteApp());
}

Future<void> detectDeviceName() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    ServiceAdapter.instance()?.setDeviceName('${androidInfo.brand} ${androidInfo.model}');
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    ServiceAdapter.instance()?.setDeviceName('${iosInfo.name} (${iosInfo.model})');
  }
}

class PaletteApp extends StatelessWidget {
  PaletteApp({super.key});

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
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
