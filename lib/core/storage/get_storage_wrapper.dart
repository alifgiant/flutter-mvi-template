import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

typedef StorageGetter = GetStorage Function(String key);
typedef StorageCreator = Future<bool> Function(String key);

class GetStorageWrapper {
  final StorageGetter retrieve;
  final StorageCreator create;

  GetStorageWrapper({@required this.retrieve, @required this.create});
}
