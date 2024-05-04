import 'package:flutter/material.dart';

import 'circle.dart';

class AnimatedSelector extends StatefulWidget {
  final double diameter;
  final int buttonCount;
  final double gap;
  final Color railColor;
  final double stroke;
  const AnimatedSelector({
    super.key,
    required this.diameter,
    required this.buttonCount,
    this.gap = 1.0,
    this.railColor = Colors.black,
    this.stroke = 1.5,
  });

  @override
  State<AnimatedSelector> createState() => _AnimatedSelectorState();
}

class _AnimatedSelectorState extends State<AnimatedSelector> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final distanceBetweenButtonsAsPct =
          1.0 / ((widget.buttonCount - 1.0) / 2.0);
      // AnimatedAlign "x"-position
      final xPos = -1.0 + _selectedIndex * distanceBetweenButtonsAsPct;

      return SizedBox(
        width: double.infinity,
        height: widget.diameter,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned.fill(
              child: CustomPaint(
                painter: RailPainter(
                  widget.buttonCount,
                  iconDiameter: widget.diameter,
                  gap: widget.gap,
                  railColor: widget.railColor,
                  stroke: widget.stroke,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(widget.buttonCount, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: RingAndCircleWidget(diameter: widget.diameter),
                );
              }),
            ),
            AnimatedAlign(
              alignment: Alignment(xPos, 0),
              curve: Curves.decelerate,
              duration: const Duration(seconds: 1),
              child: RingAndCircleWidget(
                diameter: widget.diameter,
                ringColor: Colors.transparent,
                selectedColor: Colors.purple,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class RailPainter extends CustomPainter {
  final int choices;
  final double iconDiameter;
  final double gap;
  final Color railColor;
  final double stroke;

  RailPainter(
    this.choices, {
    required this.iconDiameter,
    required this.gap,
    required this.railColor,
    required this.stroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = railColor
      ..strokeWidth = stroke;

    double totalSpacing = size.width - iconDiameter * choices;
    double segmentWidth = (totalSpacing / (choices - 1)) - (2.0 * gap);

    // Draw lines between the circles
    double startX = iconDiameter + gap;
    double endX = startX + segmentWidth;
    for (int i = 1; i < choices; i++) {
      canvas.drawLine(Offset(startX, size.height / 2),
          Offset(endX, size.height / 2), paint);
      startX = endX + iconDiameter + (gap * 2);
      endX = startX + segmentWidth;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
