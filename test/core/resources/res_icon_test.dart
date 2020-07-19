import 'dart:math';

import 'package:aset_ku/core/resources/res_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

main() {
  final generator = Random();
  MapEntry<String, IconData Function()> randomIcon() {
    final entries = ResIcon.icons.entries.toList();
    final randomInt = generator.nextInt(entries.length);
    return entries[randomInt];
  }

  test('check all icon is valid', () {
    for (final entry in ResIcon.icons.entries) {
      assert(entry.key is String);
      expect(entry.value(), isNotNull);
    }
  });

  group('icon data getter', () {
    test('null key icon will return null', () {
      // when
      final icon = null;

      // execute
      final res = ResIcon.get(icon);

      // then
      expect(res, isNull);
    });

    test('empty key icon will return defaults icon', () {
      // when
      final icon = '';
      final defIcon = ResIcon.get('defaults');
      assert(defIcon != null);

      // execute
      final res = ResIcon.get(icon);

      // then
      assert(res == defIcon);
    });

    test('knonwn key icon will return an icon', () {
      // when
      final icon = randomIcon();

      // execute
      final res = ResIcon.get(icon.key);

      // given
      assert(res == icon.value());
    });

    test('unknonwn key icon will return defaults icon', () {
      // when
      final icon = 'belidaging';
      final defIcon = ResIcon.get('defaults');
      assert(defIcon != null);

      // execute
      final res = ResIcon.get(icon);

      // then
      assert(res == LineAwesomeIcons.times);
    });
  });

  group('icon widget creator', () {
    test('null key icon will return an icon', () {
      // when
      final icon = null;

      // execute
      final res = ResIcon.ico(icon);

      // then
      expect(res, isNull);
    });

    test('empty key icon will return defaults icon', () {
      // when
      final icon = '';
      final defIcon = ResIcon.get('defaults');
      assert(defIcon != null);

      // execute
      final res = ResIcon.ico(icon);

      // then
      assert(res.icon == defIcon);
    });

    test('knonwn key icon will return an icon', () {
      // when
      final icon = randomIcon();

      // execute
      final res = ResIcon.ico(icon.key);

      // given
      assert(res.icon == icon.value());
    });

    test('unknonwn key icon will return defaults icon', () {
      // when
      final icon = 'belidaging';
      final defIcon = ResIcon.get('defaults');
      assert(defIcon != null);

      // execute
      final res = ResIcon.ico(icon);

      // then
      assert(res.icon == LineAwesomeIcons.times);
    });
  });
}
