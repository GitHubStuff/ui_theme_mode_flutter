import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../observer/platform_brightness_observer.dart';
import '../persisted_store/on_device_store.dart';

part 'ui_theme_mode_state.dart';

const _themeKey = 'theme';

/// Manages the application's theme by observing platform brightness changes
/// and persisting theme preferences.
class UIThemeModeCubit extends Cubit<UIThemeModeState> {
  static Brightness _brightness = Brightness.light;

  ThemeMode _themeMode = ThemeMode.system;
  final PlatformObserver _platformObserver;
  final OnDeviceStore _persistedStore;

  UIThemeModeCubit({
    required OnDeviceStore persistedStore,
    required PlatformObserver platformObserver,
  })  : _persistedStore = persistedStore,
        _platformObserver = platformObserver,
        super(const UIThemeModeInitial()) {
    _platformObserver.subscribe(_onBrightnessChange);
    _restoreMode();
  }

  @override
  Future<void> close() async {
    _platformObserver.unsubscribe(_onBrightnessChange);
    await _persistedStore.close();
    return super.close();
  }

  Brightness currentBrightness() => _brightness;

  void setBrightness(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.dark:
        _brightness = Brightness.dark;
        break;
      case ThemeMode.light:
        _brightness = Brightness.light;
        break;
      case ThemeMode.system:
        _brightness = MediaQuery.of(context).platformBrightness;
        break;
    }
  }

  void _onBrightnessChange(ThemeMode themeMode, AppLifecycleState state) {
    if (state != AppLifecycleState.resumed ||
        _themeMode == ThemeMode.dark ||
        _themeMode == ThemeMode.light) {
      return;
    }
    setMode = themeMode;
  }

  ThemeMode get themeMode => _themeMode;

  set setMode(ThemeMode newValue) {
    if (newValue == _themeMode) return;
    _themeMode = newValue;
    _persistThemeMode();
    emit(UIThemeModeNewState(_themeMode));
  }

  Future<void> _restoreMode() async {
    final themeModeIndex =
        _persistedStore.get(_themeKey, defaultValue: ThemeMode.system.index);
    _themeMode = ThemeMode.values[themeModeIndex];
    emit(UIThemeModeNewState(_themeMode));
  }

  Future<void> _persistThemeMode() async {
    await _persistedStore.put(_themeKey, _themeMode.index);
  }

  void setToDarkMode() => setMode = ThemeMode.dark;
  void setToLightMode() => setMode = ThemeMode.light;
  void setToSystemMode() => setMode = ThemeMode.system;

  @override
  String toString() => 'UIThemeModeCubit(themeMode: $_themeMode)';
}
