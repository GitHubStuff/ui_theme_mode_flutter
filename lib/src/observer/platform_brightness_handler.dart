part of 'platform_brightness_observer.dart';

class PlatformBrightnessHandler extends PlatformObserver {
  PlatformBrightnessHandler() : super() {
    //debugPrint('🟣 constructor $currentThemeMode');
    _themeMode = ThemeMode.system;
  }

  AppLifecycleState _lastAppLifecycleState = AppLifecycleState.hidden;

  @override
  ThemeMode get currentThemeMode =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.light
          ? ThemeMode.light
          : ThemeMode.dark;

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    // debugPrint(
    //     '🟢 didChangePlatformBrightness $currentThemeMode $_lastAppLifecycleState');
    for (var listener in _subscribers) {
      listener(_themeMode, _lastAppLifecycleState);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    //debugPrint('🟡 didChangeAppLifecycleState $state $currentThemeMode');
    _lastAppLifecycleState = state;
    for (var listener in _subscribers) {
      listener(_themeMode, state);
    }
  }
}
