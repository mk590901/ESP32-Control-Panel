import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'color_bloc.dart';

// Buttons Panel
class ButtonsPanel extends StatelessWidget {
  final List<Color> buttonColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.cyan,
    Colors.pink,
    // Colors.teal,
    // Colors.lime,
    // Colors.amber,
    // Colors.indigo,
  ];

  ButtonsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      children: List.generate(8, (index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColors[index],
            ),
            onPressed: () {
              context.read<ColorBloc>().add(ChangeColorEvent(buttonColors[index]));
            },
            child: Container(),
          ),
        );
      }),
    );
  }
}
