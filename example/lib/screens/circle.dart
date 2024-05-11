import 'dart:math';

import 'package:flutter/material.dart';

class UIAnimatedRadioButton extends StatelessWidget {
  static const double minRingThickness = 1.5;
  static const double defaultRingPadding = 8.0;
  final double diameter;
  final Color ringColor;
  final Color circleColor;

  const UIAnimatedRadioButton({
    super.key,
    required this.diameter,
    this.ringColor = Colors.black,
    this.circleColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    final double ringThickness = _calculateRingThickness();
    final double circleDiameter = _calculateCircleDiameter(ringThickness);

    return SizedBox(
      width: diameter,
      height: diameter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildRing(ringThickness),
          _buildInnerCircle(circleDiameter),
        ],
      ),
    );
  }

  ///Minial thickness or 5% of the diameter
  double _calculateRingThickness() => max(minRingThickness, diameter * 0.05);

  double _calculateCircleDiameter(double ringThickness) =>
      diameter - max(ringThickness * 5, defaultRingPadding);

  Widget _buildRing(double thickness) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: ringColor,
            width: thickness,
          ),
        ),
      );

  Widget _buildInnerCircle(double diameter) => Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: circleColor,
        ),
      );
}
