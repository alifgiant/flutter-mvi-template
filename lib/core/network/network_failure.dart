import 'package:aset_ku/core/repository/result.dart';

class MessageFailure extends Failure<String> {
  final int errorCode;
  @override
  final String data;

  const MessageFailure(this.data, [this.errorCode]) : super(data);
  static const MessageFailure connectionFail = MessageFailure(
    'Koneksi terputus, hubungkan kembali ponsel ke internet',
  );

  static const MessageFailure serverFail = MessageFailure(
    'Server bermasalah silahkan coba beberapa saat lagi',
  );

  MessageFailure code(int code) => MessageFailure(this.data, code);

  static const MessageFailure parseFail = MessageFailure('Data Parsing Failed');
  static const MessageFailure canceled = MessageFailure('Request di cancel');
}

class MessagesFailure extends Failure<List<String>> {
  final int errorCode;
  @override
  final List<String> data;

  const MessagesFailure(this.data, [this.errorCode]) : super(data);
}
