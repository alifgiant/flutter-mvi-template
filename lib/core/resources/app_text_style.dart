import 'package:aset_ku/core/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static final TextStyle fullPageImageCaption = GoogleFonts.roboto(
    letterSpacing: 1,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColor.darkBlue,
  );

  static final TextStyle appBarTitle = GoogleFonts.raleway(
    fontSize: 18,
    color: AppColor.darkBlue,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle whiteTextButton18 = GoogleFonts.raleway(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );
}
