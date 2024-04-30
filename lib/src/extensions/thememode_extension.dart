import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  static ThemeMode from({required String string}) {
    for (ThemeMode themeMode in ThemeMode.values) {
      if (themeMode.name == string.toLowerCase()) return themeMode;
    }
    throw StateError('ThemeMode not found');
  }

  Brightness get brightness {
    switch (this) {
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness;
    }
  }
}
