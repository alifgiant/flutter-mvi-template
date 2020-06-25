import 'package:aset_ku/core/framework/base_view.dart';
import 'package:aset_ku/core/framework/navigation_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

abstract class BaseAction<
    V extends BaseView<V, A, S>,
    A extends BaseAction<V, A, S>,
    S extends Equatable> extends FutureViewModel<S> {
  S state;

  NavigatorFactory navigator = () => GetIt.I.get<NavigationService>();

  // load directly state data or load it from data source
  Future<S> initState();

  void cancelAndClose<T>([T result]) {
    navigator().goBack(result);
  }

  @protected
  void render() => notifyListeners();


  @override
  Future<S> futureToRun() async {
    state = await initState();
    return state;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is A && o.state == state;
  }

  @override
  int get hashCode => state.hashCode;
}
