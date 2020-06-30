import 'package:aset_ku/core/framework/base_action.dart';
import 'package:aset_ku/core/resources/res_color.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseView<
    V extends BaseView<V, A, S>,
    A extends BaseAction<V, A, S>,
    S extends Equatable> extends StatelessWidget {
  A initAction();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<A>(
      init: initAction(),
      builder: (A action) => WillPopScope(
        child: Container(
          color: ResColor.lightGrey,
          child: SafeArea(
            child: action.isBusy
                ? loadingViewBuilder(context)
                : render(context, action, action.state),
          ),
        ),
        onWillPop: () => action.onWillPop(),
      ),
    );
  }

  Widget render(BuildContext context, A action, S state);

  // specifify what to show when screen state is still not ready
  // this view will be rendered every time actions is busy
  Widget loadingViewBuilder(BuildContext context);
}
