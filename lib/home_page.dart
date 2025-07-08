import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui_components/buttons_panel.dart';
import 'ui_components/icon_panel.dart';
import 'ui_blocks/app_bloc.dart';
import 'ui_components/control_panel.dart';
import 'ui_components/mqtt_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //return Scaffold(
    return PopScope(
      canPop: false, // Disable the default behavior of the "back" button
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return; // If pop has already been executed, do nothing
        // Show the dialog box
        final result = await showAppExitDialog(context);

        // Processing user selection
        await reaction(result, context);
        // For 'ignore' we do nothing, the dialog just closes
      },
      child: Scaffold(
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
      ),
    );
  }

  Future<String?> showAppExitDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Application exit',
          style: TextStyle(fontSize: 16, color: Colors.blueAccent),
        ),
        content: Text(
          'Choose one of app exit option:\n\t - Ignore: stay in application\n\t - Close: exit leaving service\n\t - Exit: stop service and exit',
          style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
        ),
        actions: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, 'ignore'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(40, 36),
                      textStyle: TextStyle(fontSize: 10),
                    ),
                    child: Text('Ignore'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, 'close'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(40, 36),
                      textStyle: TextStyle(fontSize: 10),
                    ),
                    child: Text('Close'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, 'exit'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(20, 36),
                      textStyle: TextStyle(fontSize: 10),
                    ),
                    child: Text('Exit'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> reaction(String? result, BuildContext context) async {
    if (!context.mounted) {
      return;
    }
    if (result == 'close') {
      await SystemNavigator.pop();
    } else if (result == 'exit') {
      if (context.mounted) {
        context.read<AppBloc>().add(StopService());
      }
      await SystemNavigator.pop();
    }
  }
}
