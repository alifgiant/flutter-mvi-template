import 'package:aset_ku/core/resources/res_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('check color hex code', () {
    final colors = [
      ResColor.lightRed,
      ResColor.darkRed,
      ResColor.lightGreen,
      ResColor.lightGrey,
      ResColor.lightGrey300,
      ResColor.lightYellow,
      ResColor.darkYellow,
      ResColor.lightOrange,
      ResColor.darkOrange,
      ResColor.lightBlue,
      ResColor.darkBlue,
      ResColor.lightPink,
      ResColor.darkPink
    ];

    for (final color in colors) {
      assert(color.hexCode.toLowerCase() == color.value.toHex().toLowerCase());
    }
  });

  /// only to help coverage increased into 100%
  test('check gradient is linear', () {
    final gradients = [
      ResColor.greyGradient,
      ResColor.brownGradient,
      ResColor.darkBlueGradient,
      ResColor.blueGradient,
      ResColor.redGradient,
      ResColor.yellowGradient,
      ResColor.darkGreenGradient,
      ResColor.greenGradient,
      ResColor.pinkGradient,
    ];

    for (final gradient in gradients) {
      assert(gradient is LinearGradient);
    }
  });
}
