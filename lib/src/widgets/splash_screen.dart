import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart' show Modular;

import '../../ui_theme_mode_flutter.dart';

/// A splash screen widget that displays a splash image and navigates to the first route after a delay.
class SplashScreen extends StatelessWidget {
  /// The widget to display as the splash image. If this is null, a `SizedBox.shrink()` is used instead.
  final Widget splashWidget;

  /// The duration to wait before navigating from the splash screen to the first route.
  final Duration splashScreenDuration;

  /// Creates a new splash screen.
  const SplashScreen({
    super.key,
    this.splashWidget = const SizedBox.shrink(),
    this.splashScreenDuration = Duration.zero,
  });

  /// Builds the widget tree for this widget.
  @override
  Widget build(BuildContext context) {
    return _splashWidget(context);
  }

  Widget _splashWidget(BuildContext context) {
    Future.delayed(splashScreenDuration, () {
      ThemeAppModule.hasSplashScreenDisplayed = true;
      Modular.to.pushNamed('/');
    });
    return splashWidget;
  }
}
