import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';

class ResColor extends HexColor {
  final String hexColor;
  ResColor(this.hexColor) : super(hexColor);

  // solid
  static ResColor lightRed = ResColor('F5515F');
  static ResColor darkRed = ResColor('A1051D');
  static ResColor lightGreen = ResColor('00A490');
  static ResColor lightGrey = ResColor('F3F3F3');
  static Color lightGrey300 = Colors.grey[300];
  static ResColor lightYellow = ResColor('FFCB74');
  static ResColor darkYellow = ResColor('E5A933');
  static ResColor lightOrange = ResColor('FFB400');
  static ResColor darkOrange = ResColor('EB7E44');
  static ResColor lightBlue = ResColor('1153FC');
  static ResColor darkBlue = ResColor('04294F');
  static ResColor lightPink = ResColor('FF6CBA');
  static ResColor darkPink = ResColor('E56CE3');

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
    ResColor.darkBlue,
    ResColor('215C98'),
  ]);

  static Gradient blueGradient = createGradient([
    ResColor.lightBlue,
    ResColor('5581F1'),
  ]);

  static Gradient redGradient = createGradient([
    ResColor.darkRed,
    ResColor.lightRed,
  ]);

  static Gradient yellowGradient = createGradient([
    ResColor('E5A933'),
    ResColor('FFCB74'),
  ]);

  static Gradient darkGreenGradient = createGradient([
    ResColor('005A26'),
    ResColor('377C61'),
  ]);

  static Gradient greenGradient = createGradient([
    ResColor('00BA87'),
    ResColor.lightGreen,
  ]);

  static Gradient pinkGradient = createGradient([
    ResColor.darkPink,
    ResColor.lightPink,
  ]);
}
