import 'package:aset_ku/core/utils/service/framework_service_locator.dart';
import 'package:aset_ku/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFrSl extends Mock implements FrameworkServiceLocator {}

void main() {
  test('main function setup', () async {
    // given
    final mockFrSl = MockFrSl();
    final root = Container();

    // when
    app.main(frSl: mockFrSl, root: root);

    verify(mockFrSl.setupFrameworkLocator(any));
  });
}
