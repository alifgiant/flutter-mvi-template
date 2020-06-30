// import 'package:aset_ku/core/framework/base_action.dart';
// import 'package:aset_ku/core/framework/base_view.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

// abstract class BaseChildView<
//     V extends BaseView<V, A, S>,
//     A extends BaseAction<V, A, S>,
//     S extends Equatable> extends StatelessWidget {
//   Widget render(BuildContext context, A action, S state);

//   // specifify what to show when screen state is still not ready
//   // this view will be rendered every time actions is busy
//   Widget loadingViewBuilder(BuildContext context);

//   @override
//   Widget build(BuildContext context, A action) {
//     return action.isBusy
//         ? loadingViewBuilder(context)
//         : render(context, action, action.state);
//   }
// }
