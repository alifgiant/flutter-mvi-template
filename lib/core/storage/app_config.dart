import 'dart:convert';

import 'package:aset_ku/core/network/NetworkToken.dart';
import 'package:aset_ku/core/storage/read_write_value.dart';
import 'package:aset_ku/core/utils/serialize_utils.dart';
import 'package:get_storage/get_storage.dart';

const AppConfigKey = 'AsetKuLocalStorage';

/// Supports Android, iOS, Web, Mac, Linux, and fuchsia and Windows**.
/// Can store String, int, double, Map and List
class AppConfig {
  // TODO: set to false
  static final isDummyOn = RawValue<bool>('isDummyOn', true);
  static final token = FieldValue<NetworkToken>(
    'token',
    NetworkToken.defToken,
    (json) => NetworkToken.fromJson(json),
    (data) => NetworkToken.builJson(data),
  );

  // creation
  static Future setup() => GetStorage.init(AppConfigKey);
}

/// utils for app config
final GetStorage Function() configBox = () => GetStorage(AppConfigKey);

class RawValue<T> extends ReadWriteValue<T> {
  RawValue(String key, T defaultValue) : super(key, defaultValue, configBox);
}

class FieldValue<T> {
  final ReadWriteValue<String> _rwVal;

  final DataParser<T> parser;
  final DataEncoder<T> encoder;
  FieldValue(String key, T defaultValue, this.parser, this.encoder)
      : this._rwVal = ReadWriteValue(
          key,
          jsonEncode(encoder(defaultValue)),
          configBox,
        );

  T get val => parser(jsonDecode(_rwVal.val));

  set val(T newVal) => _rwVal.val = jsonEncode(encoder(newVal));
}
