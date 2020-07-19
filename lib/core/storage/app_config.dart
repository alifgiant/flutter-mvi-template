import 'dart:convert';

import 'package:aset_ku/core/network/NetworkToken.dart';
import 'package:aset_ku/core/storage/get_storage_wrapper.dart';
import 'package:aset_ku/core/storage/read_write_value.dart';
import 'package:aset_ku/core/utils/serialize_utils.dart';
import 'package:get/get.dart';

/// Utils for app config
final GetStorageWrapper configBox = Get.find<GetStorageWrapper>();
const AppConfigKey = 'AsetKuLocalStorage';

/// Supports Android, iOS, Web, Mac, Linux, and fuchsia and Windows.
/// Can store String, int, double, Map and List
class AppConfig {
  // TODO: set to false
  static final isDummyOn = true.value('isDummyOn');

  static final token = FieldValue<NetworkToken>(
    'token',
    NetworkToken.defToken,
    (json) => NetworkToken.fromJson(json),
    (data) => data.toJson(),
  );

  // creation & clearing
  static Future<bool> setup() => configBox.create(AppConfigKey);
  static Future clear() => configBox.retrieve(AppConfigKey).erase();
}

/// can only use primitive type (int, String, bool, char, double)
class PrimitiveValue<T> extends ReadWriteValue<T> {
  PrimitiveValue(
    String key,
    T defaultValue,
  ) : super(key, defaultValue, () => configBox.retrieve(AppConfigKey));
}

extension PrimitiveData<T> on T {
  ReadWriteValue<T> value(String valueKey, {T defVal}) {
    return PrimitiveValue(valueKey, defVal ?? this);
  }
}

class FieldValue<T> extends GetSet<T> {
  final PrimitiveValue<String> _rwVal;

  final DataParser<T> parser;
  final DataEncoder<T> encoder;
  FieldValue(String key, T defaultValue, this.parser, this.encoder)
      : this._rwVal = PrimitiveValue(key, jsonEncode(encoder(defaultValue)));

  @override
  T get val => parser(jsonDecode(_rwVal.val));

  @override
  set val(T newVal) => _rwVal.val = jsonEncode(encoder(newVal));
}
