import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart' show Modular;

/// A splash screen widget that displays a splash image and navigates to the first route after a delay.
class SplashScreen extends StatelessWidget {
  /// The widget to display as the splash image. If this is null, a `SizedBox.shrink()` is used instead.
  final Widget splashWidget;

  /// The first route to navigate to after the splash screen.
  final String firstRoute;

  /// The duration to wait before navigating from the splash screen to the first route.
  final Duration splashScreenDuration;

  /// Creates a new splash screen.
  ///
  /// The [firstRoute] argument must not be null.
  const SplashScreen({
    super.key,
    required this.firstRoute,
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
      Modular.to.pushReplacementNamed(firstRoute);
    });
    return splashWidget;
  }
}
