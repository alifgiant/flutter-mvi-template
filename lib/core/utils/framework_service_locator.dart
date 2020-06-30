import 'package:aset_ku/core/resources/res_data_source.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

typedef RepoSelector<T> = T Function(dynamic param1);

extension FrameworkServiceLocator on GetImpl {
  T getRepository<T>(ResDataSource source) {
    return this.find<T>(tag: source.toString());
  }

  void setupFrameworkLocator() {
    this.put<Uuid>(Uuid());
  }
}
