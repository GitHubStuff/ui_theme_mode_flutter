import 'package:flutter/material.dart';

part 'mock_brightness_handler.dart';
part 'platform_brightness_handler.dart';

Map<ThemeMode, String> _themeModeNames = {
  ThemeMode.system: 'Device',
  ThemeMode.dark: 'Dark',
  ThemeMode.light: 'Light',
};

/// Extension on [ThemeMode] to convert theme mode to platform brightness.
extension ThemeModeExt on ThemeMode {
  static Brightness brightness = Brightness.light;

  set label(String value) => _themeModeNames[this] = value;
  String get label => _themeModeNames[this]!;

  /// Converts [ThemeMode] to [Brightness] based on the provided [PlatformObserver].
  Brightness toBrightness({required PlatformObserver observer}) {
    return this == ThemeMode.system
        ? observer.currentThemeMode.toBrightness(observer: observer)
        : this == ThemeMode.dark
            ? Brightness.dark
            : Brightness.light;
  }
}

/// An abstract class observing platform brightness and theme mode changes.
abstract class PlatformObserver extends WidgetsBindingObserver {
  late ThemeMode _themeMode;
  final List<void Function(ThemeMode, AppLifecycleState)> _subscribers = [];

  PlatformObserver() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  /// Returns the current theme mode.
  ThemeMode get currentThemeMode;

  /// Subscribes a listener to theme mode and app lifecycle state changes.
  void subscribe(void Function(ThemeMode, AppLifecycleState) listener) =>
      _subscribers.add(listener);

  /// Unsubscribes a listener from theme mode and app lifecycle state changes.
  void unsubscribe(void Function(ThemeMode, AppLifecycleState) listener) =>
      _subscribers.remove(listener);

  /// Provides the actual platform brightness.
  static Brightness get platformBrightness =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
}
