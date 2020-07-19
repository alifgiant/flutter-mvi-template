import 'package:get_storage/get_storage.dart';

typedef StorageFactory = GetStorage Function();

abstract class GetSet<T> {
  T get val;
  set val(T newVal);
}

/// it will be available from GetStorage lib
// ignore: coverage
class ReadWriteValue<T> extends GetSet<T> {
  final String key;
  final T defaultValue;
  final StorageFactory getBox;
  final EncodeObject encoder;

  ReadWriteValue(
    this.key,
    this.defaultValue, [
    this.getBox,
    this.encoder,
  ]);

  GetStorage _getRealBox() => getBox?.call() ?? GetStorage();

  @override
  T get val => _getRealBox().read(key) ?? defaultValue;
  @override
  set val(T newVal) => _getRealBox().write(key, newVal, encoder);
}

/// it will be available from GetStorage lib
// ignore: coverage
extension Data<T> on T {
  ReadWriteValue<T> val(
    String valueKey, {
    StorageFactory getBox,
    T defVal,
  }) {
    return ReadWriteValue(valueKey, defVal ?? this, getBox);
  }
}
