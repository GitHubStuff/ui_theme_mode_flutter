import 'dart:math';

import 'package:flutter/material.dart';

class RingAndCircleWidget extends StatelessWidget {
  final double diameter;
  final Color ringColor;
  final Color selectedColor;

  const RingAndCircleWidget({
    super.key,
    required this.diameter,
    this.ringColor = Colors.black,
    this.selectedColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate ring thickness
    double ringThickness = (diameter * 0.05) < 1.5 ? 1.5 : (diameter * 0.05);

    // Calculate circle radius
    double circleRadius = (diameter - max(ringThickness * 5, 8.0)) / 2;

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
                color: ringColor, // Change color as needed
                width: ringThickness,
              ),
            ),
          ),
          // Solid circle
          Container(
            width: circleRadius * 2,
            height: circleRadius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selectedColor,
            ),
          ),
        ],
      ),
    );
  }
}
