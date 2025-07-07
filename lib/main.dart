import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'buttons_panel.dart';
import 'color_bloc.dart';
import 'icon_panel.dart';

// The main app widget
void main() {
  runApp(PaletteApp());
}

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
