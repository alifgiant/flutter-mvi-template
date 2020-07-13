/// all field are nullable
/// [data], where the correct result is passed
/// [failure],  where any failure is descripted
/// [rawResponse], any raw data, could be json or string
class Result<T> {
  final Response rawResponse;
  final Failure failure;
  final T data;

  Result._(this.data, this.rawResponse, this.failure);

  factory Result.success(T data, [Response rawResponse]) {
    return Result._(data, rawResponse, null);
  }

  factory Result.error(Failure failure, [Response rawResponse]) {
    return Result._(null, rawResponse, failure);
  }

  bool get isSuccess => data != null;
  bool get isError => failure != null;
}

/// only allow to retrieve 2 type
/// [JsonResponse] or [StringResponse]
abstract class Response<T> {
  final T response;

  Response(this.response);
}

// consider using
// [MessageFailure] or [MessagesFailure]
class Failure<T> {
  final T data;

  Failure(this.data);
}
