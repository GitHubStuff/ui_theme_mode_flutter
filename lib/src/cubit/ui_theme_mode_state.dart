// Importing the 'theme_manager_cubit.dart' file.
part of 'ui_theme_mode_cubit.dart';

/// An immutable class that represents the state of the theme manager.
@immutable
sealed class UIThemeModeState extends Equatable {
  /// The current mode of the theme manager.
  final ThemeMode themeMode;

  /// Creates a new instance of [UIThemeModeState].
  const UIThemeModeState(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

/// A class that represents the initial state of the theme manager.
class UIThemeModeInitial extends UIThemeModeState {
  /// Creates a new instance of [UIThemeModeInitial].
  const UIThemeModeInitial() : super(ThemeMode.system);
}

/// A class that represents a new state of the theme manager.
class UIThemeModeNewState extends UIThemeModeState {
  /// Creates a new instance of [UIThemeModeNewState].
  const UIThemeModeNewState(super.themeMode);
}
