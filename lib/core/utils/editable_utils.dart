import 'package:flutter/material.dart';

class EditableUtils {
  static TextEditingController createEditableController(String text) {
    final ctrl = TextEditingController(text: text);
    ctrl.selection = TextSelection.fromPosition(
      TextPosition(offset: text.length),
    );
    return ctrl;
  }
}
