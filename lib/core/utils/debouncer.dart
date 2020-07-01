import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final Duration duration;

  Timer _runJustOnceAtTheEnd;

  Debouncer({this.duration = const Duration(seconds: 1)});

  void runAtEnd(VoidCallback onTimePassed) {
    _runJustOnceAtTheEnd?.cancel();
    _runJustOnceAtTheEnd = null;
    _runJustOnceAtTheEnd = Timer(duration, onTimePassed);
  }
}
