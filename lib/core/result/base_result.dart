class BaseResult<T> {
  final Failure failure;
  final T data;

  BaseResult({this.failure, this.data});

  bool isSuccess() => data != null;
}

class Failure {
  final int errorCode;
  final List<String> messages;

  const Failure({this.errorCode, this.messages});
}
