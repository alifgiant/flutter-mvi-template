import 'dart:math';

import 'package:flutter/material.dart';

/// As mentioned on @designjam.id Instagram Page
/// about "UI Basics - Smooth Shadow"
///
/// ref: https://www.instagram.com/p/CBt1W6FgYLv/
class ContainerUtils {
  static BoxShadow createShadow(
    int elevation, {
    Color backgroundColor: Colors.black,
    double opacity: 0.4,
  }) {
    final yOffset = pow(2, elevation).toDouble();
    final xOffset = yOffset / 2;
    final blur = yOffset * 3;
    return BoxShadow(
      blurRadius: blur,
      color: backgroundColor.withOpacity(opacity),
      offset: Offset(xOffset, yOffset),
    );
  }
}
