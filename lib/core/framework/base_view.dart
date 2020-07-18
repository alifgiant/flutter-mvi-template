import 'package:aset_ku/core/framework/base_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseView<V extends BaseView<V, A, S>,
    A extends BaseAction<V, A, S>, S> extends StatelessWidget {
  A initAction();

  @override
  Widget build(BuildContext context) {
    A action = initAction();
    return GetBuilder<A>(
      init: action,
      dispose: (State state) => action.dispose(),
      didChangeDependencies: (State state) => action.didChangeDependencies(
        state.context,
      ),
      builder: (A action) => WillPopScope(
        child: action.isBusy
            ? loadingViewBuilder(context)
            : render(context, action, action.state),
        onWillPop: () => action.onWillPop(),
      ),
    );
  }

  Widget render(BuildContext context, A action, S state);

  // specifify what to show when screen state is still not ready
  // this view will be rendered every time actions is busy
  Widget loadingViewBuilder(BuildContext context);
}
