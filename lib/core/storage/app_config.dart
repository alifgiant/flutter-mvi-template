import 'package:aset_ku/core/storage/storage_value.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as path_helper;
import 'package:path_provider/path_provider.dart';

const DbKey = 'AsetKuDatabase';
const AppConfigKey = 'AsetKuLocalStorage';

class AppConfig {
  // Values
  static ConfigValue<bool> isDummyOn = ConfigValue('isDummyOn', false);

  /// creation
  static Future<Box> setup() async {
    await _initFlutter(DbKey);
    return await _openAppConfigBox();
  }
}

/// utils for app config
/// don't need to be on separate file, it's not so many
final Box Function() configBox = () => Hive.box((AppConfigKey));

class ConfigValue<T> extends StorageValue<T> {
  ConfigValue(String key, T defaultValue) : super(key, defaultValue, configBox);
}

/// Initializes Hive with the path from [getApplicationDocumentsDirectory].
/// You can provide a [subDir] where the boxes should be stored.
Future _initFlutter([String subDir]) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    var appDir = await getApplicationDocumentsDirectory();
    var path = appDir.path;
    if (subDir != null) {
      path = path_helper.join(path, subDir);
    }
    Hive.init(path);
  }
}

/// create box for app config
/// and store it so it wont be closed while app is open
Box _configBox;
Future<Box> _openAppConfigBox() async {
  // TODO: generate key & store it online
  // final key = Hive.generateSecureKey();

  // temp static key
  final key = [100, 991, 20302];

  _configBox = await Hive.openBox(
    AppConfigKey,
    encryptionCipher: HiveAesCipher(key),
  );
  return _configBox;
}
