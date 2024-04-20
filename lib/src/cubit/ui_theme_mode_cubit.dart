import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nosql_dart/nosql_dart.dart';

import '../observer/platform_brightness_observer.dart';

part 'ui_theme_mode_state.dart';

const _themeKey = 'theme';

class UIThemeModeCubit extends Cubit<UIThemeModeState> {
  final PlatformObserver _platformObserver;
  final OnDeviceStore _persistedStore;

  static UIThemeModeCubit? _instance;

  static Brightness brightness = _instance!.getBrightness;

  UIThemeModeCubit._internal(this._platformObserver, this._persistedStore)
      : super(const UIThemeModeInitial());

  factory UIThemeModeCubit({
    required PlatformObserver platformObserver,
    required OnDeviceStore persistedStore,
  }) {
    _instance ??= UIThemeModeCubit._internal(platformObserver, persistedStore)
      .._initialize();
    return _instance!;
  }

  @override
  Future<void> close() async {
    _platformObserver.unsubscribe(_onBrightnessChange);
    await _persistedStore.close();
    return super.close();
  }

  void _initialize() async {
    _platformObserver.subscribe(_onBrightnessChange);
    await _restoreMode();
  }

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  set themeMode(ThemeMode newThemeMode) {
    if (newThemeMode != _themeMode) {
      _themeMode = newThemeMode;
      _persistThemeMode();
      emit(UIThemeModeNewState(_themeMode));
    }
  }

  void setToDarkMode() => themeMode = ThemeMode.dark;
  void setToLightMode() => themeMode = ThemeMode.light;
  void setToDeviceMode() => themeMode = ThemeMode.system;

  void _onBrightnessChange(ThemeMode themeMode, AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && themeMode == ThemeMode.system) {
      themeMode = themeMode;
    }
  }

  Brightness get getBrightness =>
      themeMode.toBrightness(observer: _platformObserver);

  Future<void> _restoreMode() async {
    final themeModeIndex = await _persistedStore.get(
      _themeKey,
      defaultValue: ThemeMode.system.index,
    );
    themeMode = ThemeMode.values[themeModeIndex];
  }

  Future<void> _persistThemeMode() async {
    await _persistedStore.put(_themeKey, _themeMode.index);
  }
}
