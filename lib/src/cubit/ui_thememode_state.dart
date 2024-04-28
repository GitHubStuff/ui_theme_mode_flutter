part of 'ui_thememode_cubit.dart';

@immutable
sealed class UIThemeModeState extends Equatable {
  final ThemeMode themeMode;
  const UIThemeModeState({required this.themeMode});
  @override
  List<Object?> get props => [themeMode];
}

class UIThemeModeInitial extends UIThemeModeState {
  const UIThemeModeInitial() : super(themeMode: ThemeMode.system);
}

class UIThemeModeSet extends UIThemeModeState {
  const UIThemeModeSet(ThemeMode mode) : super(themeMode: mode);
}

class UIThemeModeError extends UIThemeModeState {
  final String message;
  const UIThemeModeError(this.message) : super(themeMode: ThemeMode.system);
}
