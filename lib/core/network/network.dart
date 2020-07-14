import 'dart:io';

import 'package:aset_ku/core/network/NetworkToken.dart';
import 'package:aset_ku/core/network/network_env.dart';
import 'package:aset_ku/core/network/network_failure.dart';
import 'package:aset_ku/core/network/network_respose.dart';
import 'package:aset_ku/core/repository/result.dart' as local;
import 'package:aset_ku/core/utils/serialize_utils.dart';
import 'package:dio/dio.dart';

export 'package:aset_ku/core/network/network_failure.dart';
export 'package:aset_ku/core/network/network_respose.dart';

typedef OptionUpdater = BaseOptions Function(BaseOptions);

class Api {
  static const DEFAULT_TIMEOUT = 30000;

  final Dio _dio;
  Api._internal(this._dio);

  static Api _instance;

  static Dio get v1 => dio();

  /// call this line after you change env
  /// or you can call [Api.dio(newEnv)] to reset it
  static void resetApi() => _instance = null;

  /// don't set baseUrl in [optionUpdater] it will be override by [env.url]
  /// optionUpdater will update [BaseOption] from [defaultOptions]
  static Dio dio([
    NetworkEnv env,
    NetworkToken token,
    OptionUpdater optionUpdater,
  ]) {
    // if instance is null or new env/option is inserted
    if (_apihasNewValue(env, token, optionUpdater)) {
      // update option
      final newOption = _updateOption(optionUpdater);
      _instance = Api._internal(Dio(newOption));
    }

    return _instance._dio;
  }

  static BaseOptions get defaultOptions => BaseOptions(
          baseUrl: NetworkEnv.get().url,
          connectTimeout: DEFAULT_TIMEOUT,
          receiveTimeout: DEFAULT_TIMEOUT,
          contentType: ContentType.json.toString(),
          headers: {
            HttpHeaders.authorizationHeader: NetworkToken.get().encode(),
            HttpHeaders.acceptHeader: ContentType.json.toString(),
          });

  static bool _apihasNewValue(
    NetworkEnv env,
    NetworkToken token,
    OptionUpdater optionUpdater,
  ) {
    // set new env or token to instance
    if (env != null && env != NetworkEnv.get()) NetworkEnv.set(env);
    if (token != null && token != NetworkToken.get()) NetworkToken.set(token);

    return _instance == null ||
        env != null ||
        token != null ||
        optionUpdater != null;
  }

  static BaseOptions _updateOption(OptionUpdater updater) {
    return updater != null ? updater(defaultOptions) : defaultOptions;
  }
}

typedef ExceptionOr = local.Result Function();

extension DioExt on Future<Response> {
  /// parser can only be null if [T] is string, otherwise will throw [TypeError]
  /// if you need result as string it good to specify T as string
  ///
  /// use [baseParser] if rawResult is formated json
  /// your [baseParser] have to return the inner json
  /// ex:
  /// {
  ///   'status': 200
  ///   'data' : {....}    // baseParser have to return 'data'
  /// }
  Future<local.Result<T>> withParser<T>(
    DataParser<T> parser, {
    DataParser baseParser,
    ExceptionOr errorOr,
  }) async {
    final request = this;
    try {
      final response = await request;
      final result = response.data;

      // if result or parser not valid throw [TypeError]
      if (_isNoParserButResultNotString(parser, result) ||
          _isHasParserButResultNotJson(parser, result)) {
        if (errorOr != null) return errorOr();
        throw TypeError();
      }

      // passed this point, result can only be string or json
      if (result is String && T == String) {
        return local.Result.success(result as T, StringResponse(result));
      }

      final data = _parseData(result, parser, baseParser);
      return local.Result.success(data, JsonResponse(result));
    } catch (error) {
      if (error is TypeError) {
        return local.Result.error(MessageFailure.parseFail);
      } else if (error is DioError) {
        return await _handleErrorNetwork(error, parser, baseParser, errorOr);
      } else {
        return await _pingGoogle();
      }
    }
  }

  Future<local.Result<T>> _handleErrorNetwork<T>(
    DioError error,
    DataParser<T> parser, [
    DataParser baseParser,
    ExceptionOr errorOr,
  ]) async {
    if (error.error is SocketException) {
      return local.Result.error(MessageFailure.connectionFail);
    } else if (error.type == DioErrorType.CANCEL) {
      return local.Result.error(MessageFailure.canceled);
    } else if (error.type == DioErrorType.RESPONSE) {
      final result = error.response.data;

      // if result or parser not valid throw [TypeError]
      if (_isNoParserButResultNotString(parser, result) ||
          _isHasParserButResultNotJson(parser, result)) {
        return local.Result.error(
          MessageFailure.parseFail.code(error.response.statusCode),
        );
      }

      // passed this point, result can only be string or json
      if (result is String && T == String) {
        return local.Result.error(
          MessageFailure(result, error.response.statusCode),
          StringResponse(result),
        );
      }

      final data = _parseData(result, parser, baseParser);
      return local.Result.error(local.Failure(data), JsonResponse(result));
    } else {
      // unknown error check ping google
      return await _pingGoogle(errorOr: errorOr);
    }
  }

  /// if get to google also failed means internet is not available
  /// 30s read and connect timeout to ping Google.com
  /// using custom dio
  Future<local.Result> _pingGoogle({
    int timeout = Api.DEFAULT_TIMEOUT,
    ExceptionOr errorOr,
  }) async {
    var baseOptions = BaseOptions(
      connectTimeout: timeout,
      receiveTimeout: timeout,
    );

    try {
      final google = await Dio(baseOptions).get('https://google.com');
      if (google.statusCode == 200) {
        return local.Result.error(MessageFailure.serverFail);
      }
    } catch (error) {
      if (errorOr != null) return errorOr();
    }

    // if any error happed consider connection failed
    return local.Result.error(MessageFailure.connectionFail);
  }

  T _parseData<T>(
    Map<dynamic, dynamic> result,
    DataParser<T> parser, [
    DataParser baseParser,
  ]) {
    if (baseParser != null) {
      final base = baseParser(result);
      return parser(base);
    } else {
      return parser(result);
    }
  }

  bool _isNoParserButResultNotString<T>(
    DataParser<T> parser,
    dynamic result,
  ) {
    return parser == null && (T != String || result is! String);
  }

  bool _isHasParserButResultNotJson<T>(
    DataParser<T> parser,
    dynamic result,
  ) {
    return parser != null && result is! Map;
  }
}
