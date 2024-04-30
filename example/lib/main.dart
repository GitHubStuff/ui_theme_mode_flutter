import 'package:flutter/material.dart';
import 'package:ui_theme_mode_flutter/ui_theme_mode_flutter.dart';

import 'screens/home_scaffold.dart';

/// The main function of the application.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(const ThemeModeSetup(homeScreen: HomeScaffold()));
}
