import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FrameworkServiceLocator {
  static void setupFrameworkLocator() {
    Get.put<Uuid>(Uuid());
  }
}
