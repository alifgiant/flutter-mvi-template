import 'package:aset_ku/core/framework/base_action.dart';
import 'package:get/get.dart';

extension MessageUtils on BaseAction {
  void showComingSoonNotice() => this.showSnackBar(
        message: 'Coming Soon..',
        position: SnackPosition.TOP,
      );
}
