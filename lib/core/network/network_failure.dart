import 'package:aset_ku/core/repository/result.dart';

class MessagesFailure extends Failure<List<String>> {
  final int errorCode;
  @override
  final List<String> data;

  MessagesFailure(this.data, this.errorCode) : super(data);
}

class MessageFailure extends Failure<String> {
  final int errorCode;
  @override
  final String data;

  MessageFailure(this.data, this.errorCode) : super(data);
}
