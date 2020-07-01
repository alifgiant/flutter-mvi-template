import 'package:aset_ku/core/storage/app_config.dart';
import 'package:aset_ku/core/resources/res_data_source.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

typedef RepoSelector<T> = T Function(dynamic param1);

extension FrameworkServiceLocator on GetImpl {
  T getRepository<T>(ResDataSource source) {
    final selectedSource =
        AppConfig.isDummyOn.val ? ResDataSource.Dummy : source;
    return this.find<T>(tag: selectedSource.toString());
  }

  void setupFrameworkLocator() {
    this.put<Uuid>(Uuid());
  }
}
