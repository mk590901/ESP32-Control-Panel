import 'package:flutter/material.dart';
import 'dart:convert';

class ColorModel {
  final int r;
  final int g;
  final int b;

  ColorModel({required this.r, required this.g, required this.b});

  // Convert ColorModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'color': {
        'r': r,
        'g': g,
        'b': b,
      }
    };
  }

  // Create ColorModel from JSON
  factory ColorModel.fromJson(Map<String, dynamic> json) {
    final color = json['color'] as Map<String, dynamic>;
    return ColorModel(
      r: color['r'] as int,
      g: color['g'] as int,
      b: color['b'] as int,
    );
  }

  // Convert ColorModel to Flutter Color
  Color toColor() {
    return Color.fromRGBO(r, g, b, 1.0);
  }

  // Create ColorModel from JSON string
  static ColorModel restoreFromJson(String jsonString) {
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return ColorModel.fromJson(json);
  }

}
