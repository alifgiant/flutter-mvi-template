import 'package:get_storage/get_storage.dart';

class StorageValue<T> {
  final String key;
  final T defaultValue;
  final GetStorage Function() getBox;

  StorageValue(this.key, this.defaultValue, this.getBox);

  T get val => getBox().read(key) ?? defaultValue;
  set val(T newValue) => getBox().write(key, newValue);
}
