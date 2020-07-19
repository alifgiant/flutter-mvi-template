import 'package:flutter/foundation.dart';

/// all field are nullable
/// [data], where the correct result is passed
/// [failure],  where any failure is descripted
/// [rawResponse], any raw data, could be json or string
class Result<T> {
  final RawResponse rawResponse;
  final Failure failure;
  final T data;

  @visibleForTesting
  Result.internal(this.data, this.rawResponse, this.failure);

  factory Result.success(T data, [RawResponse rawResponse]) {
    return Result.internal(data, rawResponse, null);
  }

  factory Result.error(Failure failure, [RawResponse rawResponse]) {
    return Result.internal(null, rawResponse, failure);
  }

  bool get isSuccess => data != null;
  bool get isError => failure != null;

  /// condition wheter result either success or error
  bool get isUnknown => !isSuccess && !isError && rawResponse != null;
}

/// only allow to retrieve 2 type
/// [JsonResponse] or [StringResponse]
abstract class RawResponse<T> {
  final T response;

  const RawResponse(this.response);
}

// consider using
// [MessageFailure] or [MessagesFailure]
class Failure<T> {
  final T data;

  const Failure(this.data);

  static const Failure parseError = Failure('Failed Parse');
}
