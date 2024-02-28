import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ui_theme_mode_flutter/ui_theme_mode_flutter.dart';
import '../main.dart';
import 'home_scaffold.dart';
import 'splash_screen.dart';

/// Enum representing the different routes in the application.
enum AppRoute {
  /// Home route which leads to the `HomeScaffold` widget.
  home(
    '/HomeScaffold',
    HomeScaffold(),
  ),

  /// Splash route which leads to the `SplashScreen` widget.
  splash(
    '/',
    SplashScreen(
      /// The first route to be navigated to after the splash screen.
      firstRoute: AppRoute.home,

      /// The widget to be displayed during the splash screen.
      //splashWidget: Spinner(),

      /// The duration of the splash screen.
      //splashScreenDuration: Duration(milliseconds: 1000),
    ),
  );

  /// The route string that identifies this route.
  final String route;

  /// The widget that should be displayed for this route.
  final Widget widget;

  /// Creates a new `AppRoute`.
  const AppRoute(this.route, this.widget);
}

/// A `Module` that provides the routes and dependencies for the application.
class AppModule extends Module {
  /// Binds the `UIThemeModeCubit` to the dependency injection container.
  @override
  void binds(i) async {
    i.addInstance<UIThemeModeCubit>(UIThemeModeCubit(
        persistedStore: onDeviceStore,
        platformObserver: PlatformBrightnessHandler()));
  }

  /// Defines the routes for the application.
  @override
  void routes(r) {
    /// Defines the splash route.
    r.child(
      AppRoute.splash.route,
      child: (_) => AppRoute.splash.widget,
      transition: TransitionType.noTransition,
    );

    /// Defines the home route.
    r.child(
      AppRoute.home.route,
      child: (_) => AppRoute.home.widget,
      transition: TransitionType.fadeIn,
    );
  }
}
