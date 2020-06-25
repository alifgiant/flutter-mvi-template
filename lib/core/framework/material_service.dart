import 'package:flutter/material.dart';

class MaterialService {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar(SnackBar snackBar) {
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void showSheet(
    Widget sheet, {
    Color backgroundColor,
    double elevation,
    ShapeBorder shape,
    Clip clipBehavior,
  }) {
    scaffoldKey.currentState.showBottomSheet(
      (ctx) => sheet,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
    );
  }
}
