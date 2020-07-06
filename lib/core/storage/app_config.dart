import 'package:aset_ku/core/storage/storage_value.dart';
import 'package:get_storage/get_storage.dart';

const AppConfigKey = 'AsetKuLocalStorage';

/// Supports Android, iOS, Web, Mac, Linux, and fuchsia and Windows**.
/// Can store String, int, double, Map and List
class AppConfig {
  // TODO: set to false
  static ConfigValue<bool> isDummyOn = ConfigValue('isDummyOn', true);

  // creation
  static Future setup() => GetStorage.init(AppConfigKey);
}

/// utils for app config
final GetStorage Function() configBox = () => GetStorage(AppConfigKey);

class ConfigValue<T> extends StorageValue<T> {
  ConfigValue(String key, T defaultValue) : super(key, defaultValue, configBox);
}
