import 'dart:io';

import 'package:aset_ku/core/model/Example.dart';
import 'package:aset_ku/core/network/network.dart';
import 'package:aset_ku/core/repository/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mock_data/mock_data.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/test_framework_service_locator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  TestFrameworkServiceLocator().setupFrameworkLocator(Get);

  setUp(() async {
    Api.resetApi();
    final mockDio = Get.find<DioFactory>(tag: PING_DOMAIN).call(BaseOptions());
    reset(mockDio);
  });

  group('Api singleton is correct', () {
    test('create new dio when dio is null', () {
      // when
      assert(Api.dio == null);

      // execute
      final dio = Api.v1;

      // then
      assert(Api.dio == dio);
      assert(dio != null);
    });

    test('create new dio when env param is not null', () {
      // when
      final env = NetworkEnv.internal(UriData(
        mockString(),
        mockString(),
        mockString(),
        mockString(),
        mockString(),
      ));
      NetworkEnv.set(env);
      assert(NetworkEnv.get() == env);
      final dio = Api.v1; // create default dio

      // execute
      final newDio = Api.updateDio(env: NetworkEnv.PRODUCTION);

      // then
      assert(Api.dio == newDio);
      assert(dio != newDio);
      assert(NetworkEnv.get() == NetworkEnv.PRODUCTION);
    });

    test('create new dio when token param is not null', () {
      // when
      final oldToken = NetworkToken(mockString());
      NetworkToken.set(oldToken);
      assert(NetworkToken.get() == oldToken);

      final dio = Api.v1; // create default dio
      final newToken = NetworkToken(mockString());

      // execute
      final newDio = Api.updateDio(token: newToken);

      // then
      assert(Api.dio == newDio);
      assert(dio != newDio);
      assert(NetworkToken.get() == newToken);
    });

    test('create new dio when optionUpdater param is not null', () {
      // when
      final dio = Api.v1; // create default dio
      final updater = (BaseOptions option) => option;

      // execute
      final newDio = Api.updateDio(optionUpdater: updater);

      // then
      assert(Api.dio == newDio);
      assert(dio != newDio);
    });
  });

  testWidgets('with loading is correct', (WidgetTester tester) async {
    // when
    final mockGet = MockGet();

    final result = Result.success('Success');
    final resultFuture = Future.value(result);

    // execute
    final loadingResult = await resultFuture.withLoading(getX: mockGet);

    // then
    assert(loadingResult == result);
  });

  group('withParser is correct return expected:', () {
    test('no parser and response is string is correct', () async {
      // when
      final data = mockString();
      final path = mockString();
      when(Api.v1.get(path)).thenAnswer((_) async => Response(data: data));

      // execute
      final result = await Api.v1.get(path).withParser<String>(null);

      // then
      assert(result.data == data);
    });

    test('has parser, no baseparser, and response is expected', () async {
      // when
      final path = mockString();
      when(Api.v1.get(path)).thenAnswer(
        (_) async => Response(data: Example.mockCreate.toJson()),
      );

      // execute
      final result = await Api.v1.get(path).withParser<Example>(
            (json) => Example.fromJson(json),
          );

      // then
      assert(result.data == Example.mockCreate);
    });

    test('has parser, has baseparser, and response is expected', () async {
      // when
      final path = mockString();
      when(Api.v1.get(path)).thenAnswer(
        (_) async => Response(data: {'data': Example.mockCreate.toJson()}),
      );

      // execute
      final result = await Api.v1.get(path).withParser<Example>(
            (json) => Example.fromJson(json),
            baseParser: (json) => json['data'],
          );

      // then
      assert(result.data == Example.mockCreate);
    });
  });

  group('withParser is correct when exception occured:', () {
    // verify(Api.dio.get(argThat(contains(path))));
    test(
        'No parser given but response not string '
        'return MessageFailure.parseFail', () async {
      // when
      final path = mockString();
      when(Api.v1.get(path)).thenAnswer((_) async => Response());

      // execute
      final result = await Api.v1.get(path).withParser<Example>(null);

      // then
      assert(result.failure == MessageFailure.parseFail);
    });

    test(
        'parser given but response not json '
        'return MessageFailure.parseFail', () async {
      // when
      final path = mockString();
      when(Api.v1.get(path)).thenAnswer((_) async => Response());

      // execute
      final result = await Api.v1.get(path).withParser<Example>(
            (json) => Example.mockCreate,
          );

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

    test('Type.RESPONSE return parsed error data when expected', () async {
      // when
      final path = mockString();
      final error = DioError(
        type: DioErrorType.RESPONSE,
        response: Response(data: Example.mockCreate.toJson()),
      );
      when(Api.v1.get(path)).thenAnswer((_) async => throw error);

      // execute
      final result = await Api.v1.get(path).withParser<Example>(
            null,
            errorParser: (json) => Example.fromJson(json),
          );

      // then
      assert(result.failure.data == Example.mockCreate);
    });

    test('Type.RESPONSE return string when expected', () async {
      // when
      final path = mockString();
      final message = mockString();
      final error = DioError(
        type: DioErrorType.RESPONSE,
        response: Response(data: message),
      );
      when(Api.v1.get(path)).thenAnswer((_) async => throw error);

      // execute
      final result = await Api.v1.get(path).withParser<String>(null);

      // then
      assert(result.failure.data == message);
    });

    test('Type.RESPONSE return parsed error data when expected', () async {
      // when
      final path = mockString();
      final error = DioError(
        type: DioErrorType.RESPONSE,
        response: Response(data: Example.mockCreate.toJson()),
      );
      when(Api.v1.get(path)).thenAnswer((_) async => throw error);

      // execute
      final result = await Api.v1.get(path).withParser<Example>(
            null,
            errorParser: (json) => Example.fromJson(json),
          );

      // then
      assert(result.failure.data == Example.mockCreate);
    });

    test('Type.RESPONSE type unknown return connectionFail', () async {
      // when
      final path = mockString();
      final error = DioError(
        response: Response(data: Example.mockCreate.toJson()),
      );
      when(Api.v1.get(path)).thenAnswer((_) async => throw error);
      final mockDio = Get.find<DioFactory>(tag: PING_DOMAIN).call(
        BaseOptions(),
      );
      when(mockDio.get(PING_DOMAIN)).thenAnswer((_) async => throw Error());

      // execute
      final result = await Api.v1.get(path).withParser<Example>(null);

      // then
      assert(result.failure == MessageFailure.connectionFail);
    });

    test('Type.RESPONSE and ping success return fail connection', () async {
      // when
      final path = mockString();
      when(Api.v1.get(path)).thenAnswer((_) async => throw Error());
      final mockDio = Get.find<DioFactory>(tag: PING_DOMAIN).call(
        BaseOptions(),
      );
      when(mockDio.get(PING_DOMAIN)).thenAnswer(
        (_) async => Response(statusCode: 200),
      );

      // execute
      final result = await Api.v1.get(path).withParser((json) => null);

      // then
      assert(result.failure == MessageFailure.serverFail);
    });

    test('other exception return connectionFail when ping failed', () async {
      // when
      final path = mockString();
      when(Api.v1.get(path)).thenAnswer((_) async => throw Error());
      final mockDio = Get.find<DioFactory>(tag: PING_DOMAIN).call(
        BaseOptions(),
      );
      when(mockDio.get(PING_DOMAIN)).thenAnswer((_) async => throw Error());

      // execute
      final result = await Api.v1.get(path).withParser((json) => null);

      // then
      assert(result.failure == MessageFailure.connectionFail);
    });

    test('other exception catched by errorOr', () async {
      // when
      final path = mockString();
      final errorMsg = mockString();
      final errorResult = Result<Example>.error(Failure(errorMsg));
      when(Api.v1.get(path)).thenAnswer((_) async => throw Error());
      final mockDio = Get.find<DioFactory>(tag: PING_DOMAIN).call(
        BaseOptions(),
      );
      when(mockDio.get(PING_DOMAIN)).thenAnswer((_) async => throw Error());

      // execute
      final result = await Api.v1.get(path).withParser<Example>(
            (json) => null,
            errorOr: () => errorResult,
          );

      // then
      assert(errorResult == result);
      assert(errorMsg == result.failure.data);
    });
  });
}
