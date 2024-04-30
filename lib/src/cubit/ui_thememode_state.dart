part of 'ui_thememode_cubit.dart';

@immutable
sealed class UIThemeModeState extends Equatable {
  final ThemeMode themeMode;
  final Brightness brightness;
  UIThemeModeState({
    required this.themeMode,
  }) : brightness = themeMode.brightness;
  @override
  List<Object?> get props => [themeMode, brightness, runtimeType];
}

class CubitConnectNoSql extends UIThemeModeState {
  CubitConnectNoSql(ThemeMode themeMode) : super(themeMode: themeMode);
}

class CubitError extends UIThemeModeState {
  final NoSqlError error;
  CubitError(this.error) : super(themeMode: ThemeMode.system);
}

class CubitInitial extends UIThemeModeState {
  CubitInitial(ThemeMode themeMode) : super(themeMode: themeMode);
}

class CubitThemeSet extends UIThemeModeState {
  CubitThemeSet(ThemeMode mode) : super(themeMode: mode);
}
