import 'package:aset_ku/core/repository/result.dart';

class NetworkFailure<T> extends Failure<T> {
  final int errorCode;
  const NetworkFailure(T data, [this.errorCode = 0]) : super(data);
}

class MessageFailure extends NetworkFailure<String> {
  const MessageFailure(String data, [int errorCode = 0])
      : super(data, errorCode);

  static const MessageFailure connectionFail = MessageFailure(
    'Koneksi terputus, hubungkan kembali ponsel ke internet',
  );

  static const MessageFailure serverFail = MessageFailure(
    'Server bermasalah silahkan coba beberapa saat lagi',
  );

  MessageFailure code(int code) => MessageFailure(this.data, code);

  static const MessageFailure parseFail = MessageFailure(
    'Network Data Parsing Failed',
  );
  static const MessageFailure canceled = MessageFailure('Request di cancel');
}
