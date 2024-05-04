import 'dart:math';

import 'package:flutter/material.dart';

class RingAndCircleWidget extends StatelessWidget {
  static const double minRingThickness = 1.5;
  static const double defaultRingPadding = 8.0;
  final double diameter;
  final Color ringColor;
  final Color circleColor;

  const RingAndCircleWidget({
    super.key,
    required this.diameter,
    this.ringColor = Colors.black,
    this.circleColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate ring thickness
    double ringThickness = ((diameter * 0.05) < minRingThickness)
        ? minRingThickness
        : (diameter * 0.05);

    // Calculate circle radius {8px or 5x ring thickness, whichever is greater}
    double circleDiameter =
        (diameter - max(ringThickness * 5.0, defaultRingPadding));

    return SizedBox(
      width: diameter,
      height: diameter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ring
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ringColor,
                width: ringThickness,
              ),
            ),
          ),
          // Solid center circle
          Container(
            width: circleDiameter,
            height: circleDiameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: circleColor,
            ),
          ),
        ],
      ),
    );
  }
}
