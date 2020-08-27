import 'package:aset_ku/core/framework/base_view.dart';
import 'package:aset_ku/core/resources/res_data_source.dart';
import 'package:aset_ku/core/storage/app_config.dart';
import 'package:aset_ku/core/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackBarType { RED, GREEN, YELLOW, GREY }

abstract class BaseAction<V extends BaseView<V, A, S>,
    A extends BaseAction<V, A, S>, S> extends GetxController {
  S state;

  bool isBusy = true; // must be started as true

  final Debouncer reloadDbn = Debouncer(Duration(milliseconds: 300));
  final Debouncer renderDbn = Debouncer(Duration(milliseconds: 300));

  // load directly state data or load it from data source
  Future<S> initState();

  void closeScreen<T>([T result]) {
    Get.key.currentState.maybePop(result);
  }

  /// reloadScreen will only be called once after 300ms has passed
  Future reloadScreen() async {
    await reloadDbn.runLastFuture(() => onReady());
  }

  /// render will only be called once after 300ms has passed
  @protected
  void render() {
    if (state != null) renderDbn.runLastCall(() => update());
  }

  Future<bool> onWillPop() async => true;

  @override
  Future<void> onReady() async {
    if (!isBusy) {
      // make sure to change isBusy state if it alredy false before
      isBusy = true;
      render();
    }

    state = await initState();
    isBusy = false;

    render();
  }

  void dispose() {
    // there sould be nothing here, only helper for mixin
  }

  void didChangeDependencies(BuildContext context) {
    // there sould be nothing here, only helper for mixin
  }

  void showSnackBar({
    @required String message,
    String title,
    SnackBarType type = SnackBarType.GREY, // neutral
    EdgeInsets margin = const EdgeInsets.all(12),
    int msDuration = 2500,
    SnackPosition position = SnackPosition.BOTTOM,
  }) {
    Color bgColor;
    if (type == SnackBarType.RED) bgColor = Colors.red[400];
    if (type == SnackBarType.GREEN) bgColor = Colors.green[400];
    if (type == SnackBarType.YELLOW) bgColor = Colors.yellow[400];

    Color txtColor;
    if (type == SnackBarType.RED) txtColor = Colors.white;
    if (type == SnackBarType.GREEN) txtColor = Colors.white;
    if (type == SnackBarType.YELLOW) txtColor = Colors.black87;

    Get.snackbar(
      title,
      message,
      backgroundColor: bgColor,
      colorText: txtColor,
      duration: Duration(milliseconds: msDuration),
      margin: margin,
      snackPosition: position,
    );
  }

  Future<T> showSheet<T>(
    List<Widget> contents, {
    String title, // TODO: add title
    bool isScrollControlled = true,
    Color backgroundColor: Colors.white,
  }) async {
    return await Get.bottomSheet(
      Wrap(children: contents),
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is A && o.state == state;
  }

  @override
  int get hashCode => state.hashCode;
}

typedef RepoSelector<T> = T Function(dynamic param1);

extension GetRepository on GetImpl {
  T getRepository<T>(ResDataSource source) {
    var selectedSource = source;
    if (AppConfig.isDummyOn.val) selectedSource = ResDataSource.Dummy;
    return this.find<T>(tag: selectedSource.toString());
  }
}
