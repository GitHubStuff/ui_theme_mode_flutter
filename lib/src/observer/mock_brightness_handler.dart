// part of 'platform_brightness_observer.dart';

// class MockBrightnessHandler extends PlatformObserver {
//   late ThemeMode _currentThemeMode;
//   late AppLifecycleState _lastAppLifecycleState;

//   MockBrightnessHandler({
//     required ThemeMode brightness,
//     required AppLifecycleState state,
//   })  : _currentThemeMode = brightness,
//         _lastAppLifecycleState = state,
//         super();

//   @override
//   ThemeMode get currentThemeMode => _currentThemeMode;

//   set setAppLifecycleState(AppLifecycleState newState) {
//     if (newState != _lastAppLifecycleState) {
//       _lastAppLifecycleState = newState;
//       _notifySubscribers();
//     }
//   }

//   set setBrightness(ThemeMode newThemeMode) {
//     if (newThemeMode != _currentThemeMode) {
//       _currentThemeMode = newThemeMode;
//       _notifySubscribers();
//     }
//   }

//   /// Notifies all subscribers about the brightness or lifecycle state change.
//   void _notifySubscribers() {
//     for (var listener in _subscribers) {
//       listener(currentThemeMode, _lastAppLifecycleState);
//     }
//   }
// }
