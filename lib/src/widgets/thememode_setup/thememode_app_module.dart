part of 'thememode_setup.dart';

const String _homeScreenRoute = '/themed_home_screen_v1r873';

/// A `Module` that provides the routes and dependencies for the application.
class ThemeAppModule extends Module {
  static bool hasSplashScreenDisplayed = false;
  final Widget homeScreen;
  final Widget splashWidget;
  final Duration splashScreenDuration;
  ThemeAppModule({
    required this.homeScreen,
    required this.splashWidget,
    required this.splashScreenDuration,
  });

  /// Binds the `UIThemeModeCubit` to the dependency injection container.
  @override
  void binds(i) {
    i.addInstance(UIThemeModeCubit.persisted());
  }

  /// Defines the routes for the application.
  @override
  void routes(r) {
    /// Defines the splash route.
    r.child(
      Modular.initialRoute,
      child: (_) => hasSplashScreenDisplayed
          ? homeScreen
          : SplashScreen(
              splashWidget: splashWidget,
              splashScreenDuration: splashScreenDuration,
            ),
      transition: TransitionType.noTransition,
    );

    /// Defines the home route.
    r.child(
      _homeScreenRoute,
      child: (_) => homeScreen,
      transition: TransitionType.fadeIn,
    );
  }
}
