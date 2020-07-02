import 'package:hive/hive.dart';

class StorageValue<T> {
  final String key;
  final T defaultValue;
  final Box Function() getBox;

  StorageValue(this.key, this.defaultValue, this.getBox);

  T get val => getBox().get(key, defaultValue: defaultValue);
  set val(T newValue) => getBox().put(key, newValue);
}
