part of 'ui_thememode_cubit.dart';

@immutable
sealed class UIThemeModeState extends Equatable {
  final ThemeMode themeMode;
  const UIThemeModeState({required this.themeMode});
  @override
  List<Object?> get props => [themeMode, runtimeType];
}

class CubitConnectNoSql extends UIThemeModeState {
  const CubitConnectNoSql(ThemeMode themeMode) : super(themeMode: themeMode);
}

class CubitError extends UIThemeModeState {
  final NoSqlError error;
  const CubitError(this.error) : super(themeMode: ThemeMode.system);
}

class CubitInitial extends UIThemeModeState {
  const CubitInitial(ThemeMode themeMode) : super(themeMode: themeMode);
}

class CubitThemeSet extends UIThemeModeState {
  const CubitThemeSet(ThemeMode mode) : super(themeMode: mode);
}
