import 'dart:async';

import 'package:aset_ku/core/framework/base_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseAction<V extends BaseView<V, A, S>,
    A extends BaseAction<V, A, S>, S extends Equatable> extends GetxController {
  S state;

  bool isBusy = true; // must be started as true

  // load directly state data or load it from data source
  Future<S> initState();

  void reloadScreen() {
    onReady();
  }

  void closeScreen<T>([T result]) {
    Get.back(result: result);
  }

  @protected
  void render() {
    if (state != null) update();
  }

  Future<bool> onWillPop() async => true;

  @override
  void onReady() async {
    if (!isBusy) {
      // make sure to change isBusy state if it alredy false before
      isBusy = true;
      render();
    }

    state = await initState();
    isBusy = false;
    render();
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is A && o.state == state;
  }

  @override
  int get hashCode => state.hashCode;
}
