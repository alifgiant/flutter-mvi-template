import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class ContainerUtils {
  /// As mentioned on @designjam.id Instagram Page
  /// about "UI Basics - Smooth Shadow"
  ///
  /// ref: https://www.instagram.com/p/CBt1W6FgYLv/
  static BoxShadow createShadow(
    double elevation, {
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

  static Widget createSectionTitle(
    String title, {
    VoidCallback onInfoClick,
    IconData icon,
    EdgeInsets padding,
  }) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (onInfoClick != null)
            InkWell(
              child: Icon(icon ?? LineAwesomeIcons.info, size: 18),
              onTap: onInfoClick,
            )
        ],
      ),
    );
  }

  static Widget createSection({
    @required List<Widget> children,
    double padding = 12,
  }) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  static Widget createVerticalSeparator({double height = 8, Color separator}) {
    return Container(height: height, color: separator ?? Colors.grey[300]);
  }

  static Widget createWhiteSpace({double size = 12}) {
    return SizedBox.fromSize(size: Size.square(size));
  }
}
