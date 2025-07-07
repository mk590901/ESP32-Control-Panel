import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'color_bloc.dart';

class IconPanel extends StatelessWidget {
  const IconPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorBloc, ColorState>(
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.brightness_1_outlined,
              color: state.iconColor,
              size: 156,
            ),
          ),
        );
      },
    );
  }
}
