import 'package:get_storage/get_storage.dart';
import 'package:mockito/mockito.dart';

class FakeGetStorage extends Fake implements GetStorage {
  final Map<String, dynamic> inMemoryData = {};

  FakeGetStorage._();

  factory FakeGetStorage(String key) {
    FakeGetStorage.init(key);
    return storage[key];
  }

  /// Reads a value in your container with the given key.
  @override
  T read<T>(String key) => inMemoryData[key];

  /// Write data on your container
  @override
  Future<void> write(
    String key,
    dynamic value, [
    EncodeObject objectToEncode,
  ]) async =>
      inMemoryData[key] = value;

  @override
  Future<void> erase() async => inMemoryData.clear();

  static final Map<String, FakeGetStorage> storage = {};
  static Future<bool> init(String key) async {
    if (!storage.containsKey(key)) storage[key] = FakeGetStorage._();
    return true;
  }
}
