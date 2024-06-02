part of 'thememode_setup.dart';

class ModularRouting {
  final String route;
  final ModularChild child;
  final TransitionType? transition;

  ModularRouting({
    required this.route,
    required this.child,
    this.transition,
  });
}
