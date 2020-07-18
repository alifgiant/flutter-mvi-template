import 'package:aset_ku/core/storage/app_config.dart';
import 'package:aset_ku/core/utils/service/framework_service_locator.dart';
import 'package:aset_ku/feature/utils/feature_service_locator.dart';
import 'package:aset_ku/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFrSl extends Mock implements FrameworkServiceLocator {}

class MockFeSL extends Mock implements FeatureServiceLocator {}

class MockConfig extends Mock implements AppConfig {}

void main() {
  test('main function setup', () async {
    // given
    final mockFrSl = MockFrSl();
    final mockFeSL = MockFeSL();
    final mockConfig = MockConfig();
    final root = Container();

    // when
    app.main(
      frSl: mockFrSl,
      feSl: mockFeSL,
      appConfig: mockConfig,
      root: root,
    );

    verify(mockFrSl.setupFrameworkLocator(any));
    verify(mockFeSL.setupFeatureLocator());
    verify(mockConfig.setup());
  });
}
