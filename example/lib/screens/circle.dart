import 'dart:math';

import 'package:flutter/material.dart';

class RingAndCircleWidget extends StatelessWidget {
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
    double ringThickness = (diameter * 0.05) < 1.5 ? 1.5 : (diameter * 0.05);

    // Calculate circle radius {8px or 5x ring thickness, whichever is greater}
    double circleDiameter = (diameter - max(ringThickness * 5.0, 8.0));

    return SizedBox(
      width: diameter,
      height: diameter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ring
          if (ringColor != Colors.transparent)
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ringColor,
                  width: ringThickness,
                ),
              ),
            ),
          // Solid circle
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
