import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';

class ResColor extends HexColor {
  final String _hex;
  ResColor(String hexCode)
      : this._hex = hexCode,
        super(hexCode);

  String get hexCode {
    String hexColor = _hex.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return hexColor;
  }

  // solid
  static final ResColor lightRed = ResColor('F5515F');
  static final ResColor darkRed = ResColor('A1051D');
  static final ResColor lightGreen = ResColor('00A490');
  static final ResColor lightGrey = ResColor('F3F3F3');
  static final ResColor lightGrey300 = Colors.grey[300].value.toRes();
  static final ResColor lightYellow = ResColor('FFCB74');
  static final ResColor darkYellow = ResColor('E5A933');
  static final ResColor lightOrange = ResColor('FFB400');
  static final ResColor darkOrange = ResColor('EB7E44');
  static final ResColor lightBlue = ResColor('1153FC');
  static final ResColor darkBlue = ResColor('04294F');
  static final ResColor lightPink = ResColor('FF6CBA');
  static final ResColor darkPink = ResColor('E56CE3');

  static createGradient(List<ResColor> colors) {
    return LinearGradient(
      colors: colors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  // gradient
  static final Gradient greyGradient = createGradient([
    ResColor('6D8385'),
    ResColor('B9C0BD'),
  ]);

  static final Gradient brownGradient = createGradient([
    ResColor('A56757'),
    ResColor('DE9B89'),
  ]);

  static final Gradient darkBlueGradient = createGradient([
    ResColor.darkBlue,
    ResColor('215C98'),
  ]);

  static final Gradient blueGradient = createGradient([
    ResColor.lightBlue,
    ResColor('5581F1'),
  ]);

  static final Gradient redGradient = createGradient([
    ResColor.darkRed,
    ResColor.lightRed,
  ]);

  static final Gradient yellowGradient = createGradient([
    ResColor('E5A933'),
    ResColor('FFCB74'),
  ]);

  static final Gradient darkGreenGradient = createGradient([
    ResColor('005A26'),
    ResColor('377C61'),
  ]);

  static final Gradient greenGradient = createGradient([
    ResColor('00BA87'),
    ResColor.lightGreen,
  ]);

  static final Gradient pinkGradient = createGradient([
    ResColor.darkPink,
    ResColor.lightPink,
  ]);
}

extension ColorConvert on int {
  String toHex() => this.toRadixString(16).padLeft(8, '0');
  ResColor toRes() => ResColor(toHex());
}
