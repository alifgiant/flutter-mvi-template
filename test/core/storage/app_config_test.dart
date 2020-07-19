import 'dart:math';

import 'package:aset_ku/core/network/NetworkToken.dart';
import 'package:aset_ku/core/storage/app_config.dart';
import 'package:aset_ku/core/storage/read_write_value.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mock_data/mock_data.dart';

import '../../mocks/test_framework_service_locator.dart';

main() {
  TestFrameworkServiceLocator().setupFrameworkLocator(Get);

  test('AppConfig storage default value is correct', () {
    assert(AppConfig.isDummyOn.val == true);
    assert(AppConfig.token.val == NetworkToken.defToken);
  });

  test('AppConfig storage read/write value is correct', () {
    final String token = mockString();

    AppConfig.isDummyOn.validateReadWite();
    AppConfig.token.validateReadWite(NetworkToken(token));
  });

  test('AppConfig storage clear value is correct', () {
    AppConfig.isDummyOn.validateReadWite();
    AppConfig.clear();

    assert(AppConfig.isDummyOn.val == AppConfig.isDummyOn.defaultValue);
  });

  test('.val() default value is correct', () {
    final age = 100.val('age', getBox: () => configBox.retrieve(AppConfigKey));
    assert(age.val == 100);
  });
}

extension TestGetSet<T> on GetSet<T> {
  T forgeData<T>(T defVal) {
    if (T == String) {
      return mockString() as T;
    } else if (T == int) {
      return mockInteger() as T;
    } else if (T == bool) {
      return Random().nextBool() as T;
    } else if (T == DateTime) {
      return mockDate() as T;
    } else if (T == double) {
      return Random().nextDouble() as T;
    } else {
      return defVal;
    }
  }

  void setVal([T defVal]) {
    this.val = forgeData(defVal);
  }

  void validateReadWite([T defVal]) {
    final T data = forgeData(defVal);
    this.val = data;
    assert(this.val == data);
  }
}
