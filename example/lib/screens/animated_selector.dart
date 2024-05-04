import 'package:flutter/material.dart';
import 'circle.dart';

class AnimatedSelector extends StatefulWidget {
  final double diameter;
  final int buttonCount;
  final int startingIndex;
  final Function(int) onSelected;
  final double railGap;
  final Color circleColor;
  final Color railColor;
  final Color ringColor;
  final Color travelColor;
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
  })  : assert(diameter >= 14.0, 'Diameter must be at least 14.0.'),
        assert(animationDuration >= Duration.zero,
            'Animation duration must be positive.'),
        assert(startingIndex >= 0 && startingIndex < buttonCount,
            'Starting index must be between 0 and buttonCount - 1.'),
        assert(buttonCount > 1, 'Button count must be greater than 1.');

  @override
  State<AnimatedSelector> createState() => _AnimatedSelectorState();
}

class _AnimatedSelectorState extends State<AnimatedSelector> {
  late int selectedIndex;
  late Color selectionColor;
  late double distanceBetweenButtonsAsPct;
  late List<Widget> circles;
  final double yOffset = 0.0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.startingIndex;
    selectionColor = widget.circleColor;
    distanceBetweenButtonsAsPct = 2.0 / (widget.buttonCount - 1.0);
    circles = List.generate(widget.buttonCount, (index) => _buildCircle(index));
  }

  Widget _buildCircle(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          widget.onSelected(index);
          selectionColor = widget.travelColor;
        });
      },
      child: RingAndCircleWidget(
        diameter: widget.diameter,
        ringColor: widget.ringColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final xPos = -1.0 + selectedIndex * distanceBetweenButtonsAsPct;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: _RailPainter(
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
          children: circles,
        ),
        AnimatedAlign(
          alignment: Alignment(xPos, yOffset),
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

class _RailPainter extends CustomPainter {
  final int choices;
  final double iconDiameter;
  final double gap;
  final Color railColor;
  final double stroke;

  List<Offset> startPoints = [];
  List<Offset> endPoints = [];

  _RailPainter(this.choices,
      {required this.iconDiameter,
      required this.gap,
      required this.railColor,
      required this.stroke});

  /// One time calculation of the start and end points of the rail
  void _calculatePoints(Size size) {
    if (startPoints.isNotEmpty) return;

    final totalSpacing = size.width - iconDiameter * choices;

    final segmentWidth = (totalSpacing / (choices - 1)) - (2.0 * gap);

    double startX = iconDiameter + gap;

    for (int i = 1; i < choices; i++) {
      double endX = startX + segmentWidth;
      startPoints.add(Offset(startX, 0));
      endPoints.add(Offset(endX, 0));
      startX = endX + iconDiameter + (gap * 2);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    debugPrint('PAINTING');

    /// Cache the points
    _calculatePoints(size);
    final paint = Paint()
      ..color = railColor
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < startPoints.length; i++) {
      canvas.drawLine(startPoints[i].translate(0, size.height / 2),
          endPoints[i].translate(0, size.height / 2), paint);
    }
  }

  @override
  bool shouldRepaint(_RailPainter oldDelegate) => false;
}
