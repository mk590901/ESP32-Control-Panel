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
}
