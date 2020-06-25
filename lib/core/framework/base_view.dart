import 'package:aset_ku/core/framework/base_action.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

abstract class BaseView<
    V extends BaseView<V, A, S>,
    A extends BaseAction<V, A, S>,
    S extends Equatable> extends ViewModelBuilderWidget<A> {
  Widget render(BuildContext context, A action, S state, Widget staticChild);

  // specifify what to show when screen state is still not ready
  // this view will be rendered every time actions is busy
  Widget loadingViewBuilder(BuildContext context);

  @override
  Widget builder(BuildContext context, A action, Widget child) {
    return action.isBusy
        ? loadingViewBuilder(context)
        : render(context, action, action.state, child);
  }
}
