import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';

class Debouncer {
  final Duration duration;
  static const int CANCELLED = -1;

  Timer _runJustOnceAtTheEnd;
  Completer _completer;

  Debouncer([this.duration = const Duration(seconds: 1)]);

  Future runLastFuture(Future Function() onTimePassed) {
    final opr = CancelableOperation.fromFuture(onTimePassed());
    opr.cancel();

    _runJustOnceAtTheEnd?.cancel();
    _completer?.complete(CANCELLED);

    _completer = Completer();
    _runJustOnceAtTheEnd = Timer(
      duration,
      () {
        _completer.complete(onTimePassed());
        _completer = null;
      },
    );

    return _completer.future;
  }

  void runLastCall(VoidCallback onTimePassed) {
    _runJustOnceAtTheEnd?.cancel();
    _runJustOnceAtTheEnd = Timer(duration, onTimePassed);
  }
}
