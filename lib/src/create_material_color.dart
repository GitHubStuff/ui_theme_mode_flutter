import 'package:flutter/material.dart';

// Function to create a MaterialColor from any color
MaterialColor createMaterialColor(Color color) {
  Map<int, Color> colorMap = {
    50: color.withOpacity(.1),
    100: color.withOpacity(.2),
    200: color.withOpacity(.3),
    300: color.withOpacity(.4),
    400: color.withOpacity(.5),
    500: color.withOpacity(.6),
    600: color.withOpacity(.7),
    700: color.withOpacity(.8),
    800: color.withOpacity(.9),
    900: color.withOpacity(1),
  };
  return MaterialColor(color.value, colorMap);
}

// Create a global variable for darkBlue
final MaterialColor darkBlue = createMaterialColor(const Color(0xFF003366));
