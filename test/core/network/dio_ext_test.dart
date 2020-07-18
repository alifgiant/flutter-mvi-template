import 'dart:io';

import 'package:aset_ku/core/model/Example.dart';
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
  Dio mockGglDio;

  setUp(() async {
    Api.resetApi();
    mockGglDio = Get.find<DioFactory>(tag: PING_DOMAIN).call(BaseOptions());
  });

  group('withParser is correct when exception occured:', () {
    // verify(Api.dio.get(argThat(contains(path))));
    test('No parser given return MessageFailure.parseFail', () async {
      // when
      final path = mockString();
      when(Api.v1.get(path)).thenAnswer((_) async => throw TypeError());

      // execute
      final result = await Api.v1.get(path).withParser<Example>((json) => null);

      // then
      assert(result.failure == MessageFailure.parseFail);
    });

    test('SocketException return MessageFailure.connectionFail', () async {
      // when
      final error = DioError(error: SocketException(mockString()));
      final path = mockString();
      when(Api.v1.get(path)).thenAnswer((_) async => throw error);

      // execute
      final result = await Api.v1.get(path).withParser((json) => null);

      // then
      assert(result.failure == MessageFailure.connectionFail);
    });

    test('DioErrorType.CANCEL return MessageFailure.canceled', () async {
      // when
      final error = DioError(type: DioErrorType.CANCEL);
      final path = mockString();
      when(Api.v1.get(path)).thenAnswer((_) async => throw error);

      // execute
      final result = await Api.v1.get(path).withParser((json) => null);

      // then
      assert(result.failure == MessageFailure.canceled);
    });

    test('Type.RESPONSE return parse fail when no error parser', () async {
      // when
      final errorCode = mockInteger();
      final path = mockString();
      final error = DioError(
        type: DioErrorType.RESPONSE,
        response: Response(statusCode: errorCode),
      );
      when(Api.v1.get(path)).thenAnswer((_) async => throw error);

      // execute
      final result = await Api.v1.get(path).withParser<Example>((json) => null);

      // then
      assert(result.failure is Failure);
      assert((result.failure as NetworkFailure).errorCode == errorCode);
    });

    test('other exception return connectionFail when ping failed', () async {
      // when
      final path = mockString();
      when(Api.v1.get(path)).thenAnswer((_) async => throw Error());
      when(mockGglDio.get(path)).thenAnswer((_) async => throw Error());

      // execute
      final result = await Api.v1.get(path).withParser((json) => null);

      // then
      assert(result.failure == MessageFailure.connectionFail);
    });

    test('other exception return errorOr when given', () async {
      // when
      final path = mockString();
      final errorMsg = mockString();
      final errorResult = Result<Example>.error(Failure(errorMsg));
      when(Api.v1.get(path)).thenAnswer((_) async => throw TypeError());

      // execute
      final result = await Api.v1
          .get(path)
          .withParser<Example>((json) => null, errorOr: () => errorResult);

      // then
      assert(errorResult == result);
      assert(errorMsg == result.failure.data);
    });
  });
}
