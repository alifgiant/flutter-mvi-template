import 'package:aset_ku/core/framework/navigation_service.dart';
import 'package:get_it/get_it.dart';

extension ServiceLocator on GetIt {
  void setupLocator() {
    this.registerLazySingleton(() => NavigationService());
  }
}
