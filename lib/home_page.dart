import 'package:flutter/material.dart';

import 'buttons_panel.dart';
import 'icon_panel.dart';
import 'ui_components/control_panel.dart';
import 'ui_components/mqtt_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Colorful Icons App')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const ControlPanel(),
            const MQTTPanel(),
            SizedBox(height: 32),
            ButtonsPanel(),
            SizedBox(height: 16),
            IconPanel(),
          ],
        ),
      ),
    );
  }
}
