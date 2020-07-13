import 'package:aset_ku/core/repository/result.dart';

class JsonResponse extends Response<Map<String, dynamic>> {
  @override
  final Map<String, dynamic> response;

  JsonResponse(this.response) : super(response);
}

class StringResponse extends Response {
  @override
  final String response;

  StringResponse(this.response) : super(response);
}
