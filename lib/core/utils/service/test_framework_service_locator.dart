import 'package:aset_ku/core/network/network.dart';
import 'package:aset_ku/core/utils/service/framework_service_locator.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

class MockDio extends Mock implements Dio {}

class TestFrameworkServiceLocator implements FrameworkServiceLocator {
  const TestFrameworkServiceLocator();

  @override
  Future setupFrameworkLocator(GetImpl getX) async {
    // so a instance cab be shared accross repo
    getX.put<Uuid>(Uuid());

    // mocks
    getX.put<DioFactory>((option) => MockDio());
    getX.put<DioFactory>((option) => MockDio(), tag: PING_DOMAIN);
  }
}
