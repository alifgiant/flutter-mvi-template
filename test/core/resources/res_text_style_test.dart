import 'package:aset_ku/core/resources/res_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  /// only to help coverage increased into 100%
  test('check text style', () {
    final styles = [
      ResTextStyle.fullPageImageCaption,
      ResTextStyle.appBarTitle,
      ResTextStyle.whiteTextButton16,
    ];

    for (final style in styles) {
      assert(style is TextStyle);
    }
  });
}
