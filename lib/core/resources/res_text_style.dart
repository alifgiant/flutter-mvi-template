import 'package:aset_ku/core/resources/res_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResTextStyle {
  static final TextStyle fullPageImageCaption = GoogleFonts.roboto(
    letterSpacing: 1,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ResColor.darkBlue,
  );

  static final TextStyle appBarTitle = GoogleFonts.raleway(
    fontSize: 18,
    color: ResColor.darkBlue,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle whiteTextButton18 = GoogleFonts.raleway(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );
}
