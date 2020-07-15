import 'dart:io';

import 'package:aset_ku/core/network/network.dart';
import 'package:aset_ku/core/repository/result.dart' as local;
import 'package:aset_ku/core/resources/res_text_style.dart';
import 'package:aset_ku/core/utils/serialize_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef ExceptionOr = local.Result Function();

extension LoadingExt<T> on Future<local.Result<T>> {
  Future<local.Result<T>> withLoading({
    String caption = 'Loading..',
    bool barrierDismissible = false,
  }) async {
    final content = Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Text(caption, style: ResTextStyle.appBarTitle),
          Padding(
            padding: const EdgeInsets.all(21),
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );

    Get.dialog(Dialog(child: content), barrierDismissible: barrierDismissible);
    final result = await this;
    Get.back();

    return result;
  }
}

extension DioExt<T> on Future<Response> {
  /// define [parser] to parse json like following
  /// [{..},{..}] or {....}
  ///
  /// if you need result as string it good to specify T as string
  /// [parser] can be null if [T] is string,
  /// otherwise will throw [TypeError]
  ///
  /// use [baseParser] if data is not located as root
  /// your [baseParser] job is to get data object from json structure
  /// ex:
  /// {
  ///   'status': 200
  ///   'data' : {....}         // baseParser have to return 'data'
  /// }
  ///   ..or..
  /// {
  ///   'status': 200
  ///   'lists' : [{..},{..}]    // baseParser have to return 'lists'
  /// }
  Future<local.Result<T>> withParser(
    DataParser<T> parser, {
    DataParser baseParser,
    DataParser errorParser,
    ExceptionOr errorOr,
  }) async {
    final request = this;
    try {
      final response = await request;
      final result = response.data;

      // if result or parser not valid throw [TypeError]
      if (_isNoParserButResultNotString(parser, result) ||
          _isHasParserButResultNotJson(parser, result)) {
        throw TypeError();
      }

      // passed this point, result can only be string or json
      if (result is String && T == String) {
        return local.Result<T>.success(result as T, StringResponse(result));
      }

      final data = _parseData(result, parser, baseParser);
      return local.Result<T>.success(data, JsonResponse(result));
    } catch (error) {
      if (errorOr != null) return errorOr();

      if (error is TypeError) {
        return local.Result<T>.error(MessageFailure.parseFail);
      } else if (error is DioError) {
        return await _handleErrorNetwork(
          error,
          errorParser,
          baseParser,
          errorOr,
        );
      } else {
        // unknown error check ping google
        return await _pingGoogle(errorOr: errorOr);
      }
    }
  }

  Future<local.Result<T>> _handleErrorNetwork(
    DioError error,
    DataParser<T> erroParser, [
    DataParser baseParser,
    ExceptionOr errorOr,
  ]) async {
    if (error.error is SocketException) {
      return local.Result<T>.error(MessageFailure.connectionFail);
    } else if (error.type == DioErrorType.CANCEL) {
      return local.Result<T>.error(MessageFailure.canceled);
    } else if (error.type == DioErrorType.RESPONSE) {
      final result = error.response.data;

      // if result or parser not valid throw [TypeError]
      if (_isNoParserButResultNotString(erroParser, result) ||
          _isHasParserButResultNotJson(erroParser, result)) {
        return local.Result<T>.error(
          MessageFailure.parseFail.code(error.response.statusCode),
        );
      }

      // passed this point, result can only be string or json
      if (result is String && T == String) {
        final errorMessage = result;
        return local.Result<T>.error(
          MessageFailure(errorMessage, error.response.statusCode),
          StringResponse(errorMessage),
        );
      }

      final data = _parseData(result, erroParser, baseParser);
      return local.Result<T>.error(local.Failure(data), JsonResponse(result));
    } else {
      // unknown error check ping google
      return await _pingGoogle(errorOr: errorOr);
    }
  }

  /// if get to google also failed means internet is not available
  /// 30s read and connect timeout to ping Google.com
  /// using custom dio
  Future<local.Result<T>> _pingGoogle({
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
        return local.Result<T>.error(MessageFailure.serverFail);
      }
    } catch (error) {}

    if (errorOr != null) return errorOr();

    // if any error happed consider connection failed
    return local.Result<T>.error(MessageFailure.connectionFail);
  }

  T _parseData(
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

  bool _isNoParserButResultNotString(
    DataParser<T> parser,
    dynamic result,
  ) {
    return parser == null && (T != String || result is! String);
  }

  bool _isHasParserButResultNotJson(
    DataParser<T> parser,
    dynamic result,
  ) {
    return parser != null && result is! Map;
  }
}
