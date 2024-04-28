import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  static ThemeMode from({required String string}) {
    for (ThemeMode themeMode in ThemeMode.values) {
      if (themeMode.name == string.toLowerCase()) return themeMode;
    }
    throw StateError('ThemeMode not found');
  }
}
