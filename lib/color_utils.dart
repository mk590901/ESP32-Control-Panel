import 'package:flutter/material.dart';

// Colors to RGB
List<int> colors2Rgb(Color color) {
  return [color.red, color.green, color.blue];
}

// RGB to Colors
Color rgb2Colors(int r, int g, int b) {
  return Color.fromRGBO(r, g, b, 1.0);
}
