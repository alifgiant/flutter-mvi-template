import 'package:aset_ku/core/network/network.dart';
import 'package:aset_ku/core/repository/result.dart';
import 'package:aset_ku/core/utils/service/test_framework_service_locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mock_data/mock_data.dart';
import 'package:mockito/mockito.dart';

void main() {
  TestFrameworkServiceLocator().setupFrameworkLocator(Get);
  Dio mockDio = Get.find<DioFactory>().call(BaseOptions());
  Dio mockGglDio = Get.find<DioFactory>(tag: PING_DOMAIN).call(BaseOptions());

  tearDown(() async {
    Api.resetApi();
    reset(mockDio);
    reset(mockGglDio);
  });

  group('withParser is correct', () {
    test('MessageFailure.parseFail retrieve when parsing failed', () async {
      // when
      final path = mockString();
      when(mockDio.get(path)).thenAnswer((_) => throw Error());
      when(mockGglDio.get(path)).thenAnswer((_) => throw TypeError());

      // execute
      final result = await Api.v1.get(path).withParser((json) => null);

      // then
      assert(MessageFailure.connectionFail == result.failure);
    });

    test('errorOr is called when exception eccured', () async {
      // when
      final path = mockString();
      final errorMsg = mockString();
      final errorResult = Result.error(Failure(errorMsg));
      when(mockDio.get(path)).thenAnswer((_) => throw TypeError());

      // execute
      final result = await Api.v1
          .get(path)
          .withParser((json) => null, errorOr: () => errorResult);

      // then
      // verify(mockDio.get(argThat(contains(path))));
      assert(errorResult == result);
      assert(errorMsg == result.failure.data);
    });
  });
}
