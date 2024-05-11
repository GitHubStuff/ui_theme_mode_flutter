import 'package:flutter/material.dart';
import 'circle.dart';

class UIAnimatedRadioGroup extends StatefulWidget {
  static const double minDiameter = 14.0;
  static const Duration defaultAnimationDuration = Duration(milliseconds: 200);
  static const Color defaultColor = Colors.black;
  static const Color defaultTravelColor = Colors.green;
  static const double defaultRailGap = 1.0;
  static const double defaultRailStroke = 1.5;
  static const Curve defaultCurve = Curves.decelerate;
  // AnimatedAlign uses -1.0 to 1.0, start is -1.0
  static const double animatedAlignStart = -1.0;

  final double circleDiameter;
  final int buttonCount;
  final Function(int) onSelected;
  final int startingIndex;
  final double railGap;
  final Color circleColor;
  final Color railColor;
  final Color ringColor;
  final Color travelColor;
  final double railStroke;
  final Duration animationDuration;
  final Curve animationCurve;

  const UIAnimatedRadioGroup({
    super.key,
    required this.buttonCount,
    required this.onSelected,
    this.animationCurve = defaultCurve,
    this.animationDuration = defaultAnimationDuration,
    this.circleColor = defaultColor,
    this.circleDiameter = minDiameter,
    this.railColor = defaultColor,
    this.railGap = defaultRailGap,
    this.railStroke = defaultRailStroke,
    this.ringColor = defaultColor,
    this.startingIndex = 0,
    this.travelColor = defaultTravelColor,
  })  : assert(circleDiameter >= minDiameter,
            'Diameter must be at least $minDiameter.'),
        assert(animationDuration >= Duration.zero,
            'Animation duration must be positive.'),
        assert(startingIndex >= 0 && startingIndex < buttonCount,
            'Starting index must be between 0 and buttonCount - 1.'),
        assert(buttonCount > 1, 'Button count must be greater than 1.');

  @override
  State<UIAnimatedRadioGroup> createState() => _UIAnimatedRadioGroupState();
}

class _UIAnimatedRadioGroupState extends State<UIAnimatedRadioGroup> {
  static const double yAlignment = 0.0;
  late int selectedIndex;
  late Color selectionColor;
  late double distanceBetweenButtonsAsPct;
  late List<Widget> circles;

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
      child: UIAnimatedRadioButton(
        diameter: widget.circleDiameter,
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
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _RailPainter(
                widget.buttonCount,
                iconDiameter: widget.circleDiameter,
                gap: widget.railGap,
                railColor: widget.railColor,
                stroke: widget.railStroke,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: circles,
        ),
        AnimatedAlign(
          alignment: Alignment(xPos, yAlignment),
          onEnd: () => setState(() => selectionColor = widget.circleColor),
          curve: widget.animationCurve,
          duration: widget.animationDuration,
          child: UIAnimatedRadioButton(
            diameter: widget.circleDiameter,
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
