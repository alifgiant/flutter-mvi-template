import 'package:aset_ku/core/network/network.dart';
import 'package:aset_ku/core/storage/app_config.dart';
import 'package:aset_ku/core/storage/get_storage_wrapper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

class FrameworkServiceLocator {
  const FrameworkServiceLocator();

  Future setupFrameworkLocator(GetImpl getX) async {
    // UUID as a instance so it can be shared accross repo
    getX.put<Uuid>(Uuid());

    // AppConfig initilizer
    getX.put<GetStorageWrapper>(GetStorageWrapper(
      retrieve: (key) => GetStorage(key),
      create: (key) => GetStorage.init(key),
    ));
    await AppConfig.setup();

    // dio
    getX.put<DioFactory>((option) => Dio(option));
    getX.put<DioFactory>((option) => Dio(option), tag: PING_DOMAIN);
  }
}
