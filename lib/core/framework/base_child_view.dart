import 'package:aset_ku/core/framework/base_action.dart';
import 'package:aset_ku/core/framework/base_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseChildView<V extends BaseView<V, A, S>,
    A extends BaseAction<V, A, S>, S> extends StatelessWidget {
  Widget render(BuildContext context, A action, S state);

  final A action = Get.find<A>();

  // specifify what to show when screen state is still not ready
  // this view will be rendered every time actions is busy
  Widget loadingViewBuilder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return action.isBusy
        ? loadingViewBuilder(context)
        : render(context, action, action.state);
  }
}
