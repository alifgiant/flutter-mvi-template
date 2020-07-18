import 'package:aset_ku/core/framework/base_action.dart';
import 'package:aset_ku/core/framework/base_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Copied form [SingleTickerProviderStateMixin]
/// Provides a single [Ticker] that is configured to only tick while the current
/// tree is enabled, as defined by [TickerMode].
///
/// To create the [AnimationController] in a [State] that only uses a single
/// [AnimationController], mix in this class, then pass `vsync: this`
/// to the animation controller constructor.
///
/// This mixin only supports vending a single ticker. If you might have multiple
/// [AnimationController] objects over the lifetime of the [State], use a full
/// [TickerActionMixin] instead.
mixin SingleTickerActionMixin<
    V extends BaseView<V, A, S>,
    A extends BaseAction<V, A, S>,
    S> on BaseAction<V, A, S> implements TickerProvider {
  Ticker _ticker;

  @override
  Ticker createTicker(TickerCallback onTick) {
    assert(() {
      if (_ticker == null) return true;
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
            '$runtimeType is a SingleTickerProviderStateMixin but multiple tickers were created.'),
        ErrorDescription(
            'A SingleTickerProviderStateMixin can only be used as a TickerProvider once.'),
        ErrorHint(
            'If a State is used for multiple AnimationController objects, or if it is passed to other '
            'objects and those objects might use it more than one time in total, then instead of '
            'mixing in a SingleTickerProviderStateMixin, use a regular TickerProviderStateMixin.')
      ]);
    }());
    _ticker = Ticker(
      onTick,
      debugLabel: kDebugMode ? 'created by $this' : null,
    );
    // We assume that this is called from initState, build, or some sort of
    // event handler, and that thus TickerMode.of(context) would return true. We
    // can't actually check that here because if we're in initState then we're
    // not allowed to do inheritance checks yet.
    return _ticker;
  }

  @override
  void dispose() {
    assert(() {
      if (_ticker == null || !_ticker.isActive) return true;
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('$this was disposed with an active Ticker.'),
        ErrorDescription(
            '$runtimeType created a Ticker via its SingleTickerProviderStateMixin, but at the time '
            'dispose() was called on the mixin, that Ticker was still active. The Ticker must '
            'be disposed before calling super.dispose().'),
        ErrorHint('Tickers used by AnimationControllers '
            'should be disposed by calling dispose() on the AnimationController itself. '
            'Otherwise, the ticker will leak.'),
        _ticker.describeForError('The offending ticker was')
      ]);
    }());
    super.dispose();
  }

  @override
  void didChangeDependencies(BuildContext context) {
    if (_ticker != null) _ticker.muted = !TickerMode.of(context);
    super.didChangeDependencies(context);
  }
}

/// Copied form [TickerProviderStateMixin]
/// Provides [Ticker] objects that are configured to only tick while the current
/// tree is enabled, as defined by [TickerMode].
///
/// To create an [AnimationController] in a class that uses this mixin, pass
/// `vsync: this` to the animation controller constructor whenever you
/// create a new animation controller.
///
/// If you only have a single [Ticker] (for example only a single
/// [AnimationController]) for the lifetime of your [State], then using a
/// [SingleTickerActionMixin] is more efficient. This is the common case.
@optionalTypeArgs
mixin TickerActionMixin<
    V extends BaseView<V, A, S>,
    A extends BaseAction<V, A, S>,
    S> on BaseAction<V, A, S> implements TickerProvider {
  Set<Ticker> _tickers;

  @override
  Ticker createTicker(TickerCallback onTick) {
    _tickers ??= <_WidgetTicker>{};
    final _WidgetTicker result =
        _WidgetTicker(onTick, this, debugLabel: 'created by $this');
    _tickers.add(result);
    return result;
  }

  void _removeTicker(_WidgetTicker ticker) {
    assert(_tickers != null);
    assert(_tickers.contains(ticker));
    _tickers.remove(ticker);
  }

  @override
  void dispose() {
    assert(() {
      if (_tickers != null) {
        for (final Ticker ticker in _tickers) {
          if (ticker.isActive) {
            throw FlutterError.fromParts(<DiagnosticsNode>[
              ErrorSummary('$this was disposed with an active Ticker.'),
              ErrorDescription(
                  '$runtimeType created a Ticker via its TickerProviderStateMixin, but at the time '
                  'dispose() was called on the mixin, that Ticker was still active. All Tickers must '
                  'be disposed before calling super.dispose().'),
              ErrorHint('Tickers used by AnimationControllers '
                  'should be disposed by calling dispose() on the AnimationController itself. '
                  'Otherwise, the ticker will leak.'),
              ticker.describeForError('The offending ticker was'),
            ]);
          }
        }
      }
      return true;
    }());
    super.dispose();
  }

  @override
  void didChangeDependencies(BuildContext context) {
    final bool muted = !TickerMode.of(context);
    if (_tickers != null) {
      for (final Ticker ticker in _tickers) {
        ticker.muted = muted;
      }
    }
    super.didChangeDependencies(context);
  }
}

// This class should really be called _DisposingTicker or some such, but this
// class name leaks into stack traces and error messages and that name would be
// confusing. Instead we use the less precise but more anodyne "_WidgetTicker",
// which attracts less attention.
class _WidgetTicker extends Ticker {
  // constructor
  _WidgetTicker(
    TickerCallback onTick,
    this._creator, {
    String debugLabel,
  }) : super(onTick, debugLabel: debugLabel);

  final TickerActionMixin _creator;

  @override
  void dispose() {
    _creator._removeTicker(this);
    super.dispose();
  }
}
