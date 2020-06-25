import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';

class AppColor {
  // solid
  static Color lightGrey = HexColor('F3F3F3');
  static Color lightOrange = HexColor('FFB400');
  static Color darkOrange = HexColor('EB7E44');
  static Color darkBlue = HexColor('04294F');

  // gradient
  static Gradient cardGradient = LinearGradient(colors: <Color>[
    HexColor('9531F6'),
    HexColor('2D72F1'),
  ]);

  // gradient
  static Gradient budgetGradient = LinearGradient(colors: <Color>[
    HexColor('5581F1'),
    HexColor('1153FC'),
  ], end: Alignment.topLeft, begin: Alignment.bottomRight);

  static Gradient budgetBarGradient = LinearGradient(
    colors: <Color>[
      HexColor('A1051D'),
      HexColor('F5515F'),
    ],
  );
}
