import 'package:flutter/material.dart';

class AnimatedSelector extends StatefulWidget {
  final int choices;

  const AnimatedSelector({super.key, required this.choices});

  @override
  State<AnimatedSelector> createState() => _AnimatedSelectorState();
}

class _AnimatedSelectorState extends State<AnimatedSelector> {
  double _selectedIndex = 0.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;
      double iconDiameter = 40; // Diameter of the circle icon
      double iconCenter = 25.0; // Center of the circle icon
      double totalSpacing = maxWidth - iconDiameter * widget.choices;
      double segmentWidth = totalSpacing / (widget.choices - 1);
      double x = ((iconDiameter / 2.0 + iconCenter / 2.0) +
              (_selectedIndex * (iconDiameter + segmentWidth))) /
          (maxWidth * 2.0);

      return SizedBox(
        width: double.infinity,
        height: 60,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned.fill(
              child: CustomPaint(
                painter: RailPainter(widget.choices),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(widget.choices, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index.toDouble();
                    });
                  },
                  child: const Icon(Icons.radio_button_unchecked, size: 40),
                );
              }),
            ),
            AnimatedAlign(
              alignment: Alignment(-1 + x, 0),
              curve: Curves.decelerate,
              duration: const Duration(seconds: 1),
              child: Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
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

  RailPainter(this.choices);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 4;

    double iconDiameter = 40; // Diameter of the circle icon
    double totalSpacing = size.width - iconDiameter * choices;
    double segmentWidth = totalSpacing / (choices - 1);

    // Draw lines between the circles
    double startX = iconDiameter;
    double endX = startX + segmentWidth;
    for (int i = 1; i < choices; i++) {
      canvas.drawLine(Offset(startX, size.height / 2),
          Offset(endX, size.height / 2), paint);
      startX = endX + 1.0 + iconDiameter + 1.0;
      endX = startX + segmentWidth;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
