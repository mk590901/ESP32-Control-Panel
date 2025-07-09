import 'dart:convert';

import 'package:flutter/material.dart';

import 'color_model.dart';

void showToast(BuildContext context, String text) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: Colors.indigoAccent,
      content: Text(text, style: const TextStyle(
        fontSize: 12, fontStyle: FontStyle.italic, color: Colors.white70,)),
      action: SnackBarAction(
          label: 'CLOSE', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

String composeColorJsonString(Color color) {
  List<int> list = colors2Rgb(color);
  final ColorModel colorModel = ColorModel(r: list[0], g: list[1], b: list[2]);
  String jsonString = jsonEncode(colorModel.toJson());
  print ('composeColorJsonString->$jsonString');
  return jsonString;
}

String detectMessageType(String jsonString) {
  String result = "";
  final map = jsonDecode(jsonString) as Map<String, dynamic>;
  if (map.containsKey('cmd')) {
    result = 'cmd';
  }
  else
  if (map.containsKey('color'))  {
    result = 'color';
  }
  return result;
}

List<int> colors2Rgb(Color color) {
  return [color.red, color.green, color.blue];
}

// RGB to Colors
Color rgb2Colors(int r, int g, int b) {
  return Color.fromRGBO(r, g, b, 1.0);
}
