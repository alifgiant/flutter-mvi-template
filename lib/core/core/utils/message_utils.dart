import 'package:flutter/material.dart';

extension MessageUtils on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      SnackBar snackbar) {
    Scaffold.of(this).showSnackBar(snackbar);
  }

  void showComingSoonNotice() => showSnackBar(
        SnackBar(content: Text('Coming Soon..')),
      );
}
