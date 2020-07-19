import 'package:aset_ku/core/network/network.dart';
import 'package:aset_ku/core/storage/app_config.dart';
import 'package:aset_ku/core/storage/get_storage_wrapper.dart';
import 'package:aset_ku/core/utils/service/framework_service_locator.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import 'fake_get_storage.dart';
import 'mock_dio.dart';

class MockGet extends Mock implements GetImpl {}

class TestFrameworkServiceLocator implements FrameworkServiceLocator {
  const TestFrameworkServiceLocator();

  @override
  Future setupFrameworkLocator(GetImpl getX) async {
    // so a instance cab be shared accross repo
    getX.put<Uuid>(Uuid());

    // AppConfig
    getX.put<GetStorageWrapper>(GetStorageWrapper(
      retrieve: (key) => FakeGetStorage(key),
      create: (key) => FakeGetStorage.init(key),
    ));
    await AppConfig.setup();

    // mocks
    getX.put<DioFactory>((option) => MockDio());
    Dio mock = MockDio(); // don't create
    getX.put<DioFactory>((option) => mock, tag: PING_DOMAIN);
  }
}
