import 'package:flutter/material.dart';

import 'circle.dart';

const double _yOffset = 0.0;

class AnimatedSelector extends StatefulWidget {
  final double diameter;
  final int buttonCount;
  final int startingIndex;
  final Function(int) onSelected;

  /// Pixel gap between the rail and the circle
  final double railGap;
  final Color circleColor;

  ///Color of lines between the circles
  final Color railColor;

  ///Color of the circle
  final Color ringColor;

  ///Color of the circle when it is moving
  final Color travelColor;

  /// Stroke width of the lines between the circles
  final double railStroke;
  final Duration animationDuration;
  const AnimatedSelector({
    super.key,
    required this.buttonCount,
    required this.onSelected,
    this.animationDuration = const Duration(milliseconds: 200),
    this.circleColor = Colors.black,
    this.diameter = 18,
    this.railColor = Colors.black,
    this.railGap = 1.0,
    this.railStroke = 1.5,
    this.ringColor = Colors.black,
    this.startingIndex = 0,
    this.travelColor = Colors.green,
  })  : assert(diameter >= 14.0, 'diameter must be >= to 14.0'),
        assert(animationDuration >= Duration.zero,
            'animationDuration must be > Duration.zero'),
        assert(startingIndex >= 0 && startingIndex < buttonCount,
            'startingIndex[$startingIndex] must be >= 0 and < $buttonCount'),
        assert(buttonCount > 1, 'buttonCount must be > 1');

  @override
  State<AnimatedSelector> createState() => _AnimatedSelectorState();
}

class _AnimatedSelectorState extends State<AnimatedSelector> {
  int _selectedIndex = 0;
  late Color selectionColor;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.startingIndex;
    selectionColor = widget.circleColor;
  }

  @override
  Widget build(BuildContext context) {
    final distanceBetweenButtonsAsPct =
        1.0 / ((widget.buttonCount - 1.0) / 2.0);
    // AnimatedAlign "x"-position (must be -1 to +1 inclusive)
    final xPos = -1.0 + _selectedIndex * distanceBetweenButtonsAsPct;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: RailPainter(
              widget.buttonCount,
              iconDiameter: widget.diameter,
              gap: widget.railGap,
              railColor: widget.railColor,
              stroke: widget.railStroke,
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
                    widget.onSelected(index);
                    selectionColor = widget.travelColor;
                  });
                },
                child: RingAndCircleWidget(
                  diameter: widget.diameter,
                  ringColor: widget.ringColor,
                ));
          }),
        ),
        AnimatedAlign(
          alignment: Alignment(xPos, _yOffset),
          onEnd: () => setState(() => selectionColor = widget.circleColor),
          curve: Curves.decelerate,
          duration: widget.animationDuration,
          child: RingAndCircleWidget(
            diameter: widget.diameter,
            ringColor: Colors.transparent,
            circleColor: selectionColor,
          ),
        ),
      ],
    );
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
      ..strokeWidth = stroke.toDouble();

    final totalSpacing = size.width - iconDiameter * choices;
    final segmentWidth = (totalSpacing / (choices - 1)) - (2.0 * gap);

    // Draw lines between the circles
    double startX = iconDiameter + gap;
    double endX = startX + segmentWidth;
    for (int i = 1; i < choices; i++) {
      canvas.drawLine(Offset(startX.toDouble(), size.height / 2),
          Offset(endX, size.height / 2), paint);
      startX = endX + iconDiameter + (gap * 2);
      endX = startX + segmentWidth;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
