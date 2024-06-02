import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_theme_mode_flutter/ui_theme_mode_flutter.dart';

import 'screens/home_scaffold.dart';

/// The main function of the application.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(const ThemeModeSetup(
    initialScreen: HomeScaffold(),
    moduleBindings: [],
    routes: [],
    splashWidget: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Starting...'),
            Gap(15.0),
            CircularProgressIndicator.adaptive(),
          ],
        ),
      ),
    ),
    splashScreenDuration: Duration(seconds: 2),
  ));
}
