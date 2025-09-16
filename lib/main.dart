import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CustomPaint(
            painter: BasicShapesPainter(),
          ),
        ),
      ),
    );
  }
}

class BasicShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Determine the center of the canvas
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final squareOffset = Offset(centerX - 75, centerY - 200);
    final circleOffset = Offset(centerX + 75, centerY - 200);
    final arcOffset = Offset(centerX + 75, centerY - 50);
    final lineStart = Offset(centerX - 75, centerY - 100);
    final lineEnd = Offset(centerX - 75, centerY + 20);

    // Draw a square
    final squarePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: squareOffset, width: 60, height: 60),
      squarePaint,
    );

    // Draw a circle
    final circlePaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;
    canvas.drawCircle(circleOffset, 30, circlePaint);

    // Draw an arc
    final arcPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawArc(
      Rect.fromCenter(center: arcOffset, width: 60, height: 60),
      6.6, // start angle in radians
      2.5, // sweep angle in radians (about 120 degrees)
      false, // whether to use center
      arcPaint,
    );

    // Draw a line
    final linePaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3;
    canvas.drawLine(lineStart, lineEnd, linePaint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
