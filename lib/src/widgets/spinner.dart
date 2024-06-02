/// Displays a spinner while the app is loading.
library;

import 'package:flutter/material.dart';
import 'package:ui_shared/ui_shared.dart';

class Spinner extends StatelessWidget {
  const Spinner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to blue.
      body: Center(
        child: OSEnum.getAppSpinner,
      ),
    );
  }
}
