import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_theme_mode_flutter/ui_theme_mode_flutter.dart';

main() {
  group('Convert Strings to ThemeMode:', () {
    test('translate returns correct ThemeMode for known strings', () {
      for (ThemeMode themeMode in ThemeMode.values) {
        expect(themeMode, ThemeModeExtension.from(string: themeMode.name));
      }
    });
    test('translate returns unknown for unknown strings', () {
      expect(
          () => ThemeModeExtension.from(string: 'unknown'), throwsStateError);
    });
  });
}
