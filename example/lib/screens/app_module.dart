import 'package:flutter_modular/flutter_modular.dart';
import 'package:ui_theme_mode_flutter/ui_theme_mode_flutter.dart';
import '../main.dart';
import 'home_scaffold.dart';
import 'splash_screen.dart';

/// A `Module` that provides the routes and dependencies for the application.
class AppModule extends Module {
  /// Binds the `UIThemeModeCubit` to the dependency injection container.
  @override
  void binds(i) async {
    i.addSingleton(
      () => UIThemeModeCubit(
        persistedStore: onDeviceStore,
        platformObserver: PlatformBrightnessHandler(),
      ),
    );
  }

  /// Defines the routes for the application.
  @override
  void routes(r) {
    /// Defines the splash route.
    r.child(
      Modular.initialRoute,
      child: (_) => const SplashScreen(firstRoute: HomeScaffold.route),
      transition: TransitionType.noTransition,
    );

    /// Defines the home route.
    r.child(
      HomeScaffold.route,
      child: (_) => const HomeScaffold(),
      transition: TransitionType.fadeIn,
    );
  }
}
