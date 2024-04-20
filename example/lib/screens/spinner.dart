/// Displays a spinner while the app is loading.
library;

import 'package:flutter/material.dart';
import 'package:ui_theme_mode_flutter/ui_theme_mode_flutter.dart';

class Spinner extends StatelessWidget {
  const Spinner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue, // Set the background color to blue.
      body: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
        ),
      ),
    );
  }
}
