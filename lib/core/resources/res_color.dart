import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';

class ResColor extends HexColor {
  final String hexColor;
  ResColor(this.hexColor) : super(hexColor);

  // solid
  static ResColor lightRed = ResColor('FB7E77');
  static ResColor lightGreen = ResColor('74BE5A');
  static ResColor lightGrey = ResColor('F3F3F3');
  static Color lightGrey300 = Colors.grey[300];
  static ResColor lightYellow = ResColor('EBDA82');
  static ResColor darkYellow = ResColor('E4C419');
  static ResColor lightOrange = ResColor('FFB400');
  static ResColor darkOrange = ResColor('EB7E44');
  static ResColor lightBlue = ResColor('667DA9');
  static ResColor darkBlue = ResColor('04294F');

  static createGradient(List<ResColor> colors) {
    return LinearGradient(
      colors: colors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  // gradient
  static Gradient greyGradient = createGradient([
    ResColor('6D8385'),
    ResColor('B9C0BD'),
  ]);

  static Gradient brownGradient = createGradient([
    ResColor('A56757'),
    ResColor('DE9B89'),
  ]);

  static Gradient darkBlueGradient = createGradient([
    ResColor('04294F'),
    ResColor('215C98'),
  ]);

  static Gradient blueGradient = createGradient([
    ResColor('1153FC'),
    ResColor('5581F1'),
  ]);

  static Gradient redGradient = createGradient([
    ResColor('A1051D'),
    ResColor('F5515F'),
  ]);

  static Gradient yellowGradient = createGradient([
    ResColor('E5A933'),
    ResColor('FFCB74'),
  ]);

  static Gradient darkGreenGradient = createGradient([
    ResColor('005A26'),
    ResColor('00BA87'),
  ]);

  static Gradient greenGradient = createGradient([
    ResColor('00BA87'),
    ResColor('00A490'),
  ]);

  static Gradient pinkGradient = createGradient([
    ResColor('E56CE3'),
    ResColor('FF6CBA'),
  ]);
}
