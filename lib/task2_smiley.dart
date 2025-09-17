// names: Adi Nair + Vishal Kuttua

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const EmojiApp());
}

class EmojiApp extends StatelessWidget {
  const EmojiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'emoji drawing demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const EmojiHomeScreen(),
    );
  }
}

class EmojiHomeScreen extends StatelessWidget {
  const EmojiHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("emoji drawing app")),
      body: Center(
        child: CustomPaint(
          painter: SmileyPainter(),
          size: const Size(400, 400), // canvas size
        ),
      ),
    );
  }
}

class SmileyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // face circle
    final facePaint = Paint()..color = Colors.yellow;
    canvas.drawCircle(center, 120, facePaint);

    // eyes
    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(center.dx - 40, center.dy - 30), 15, eyePaint);
    canvas.drawCircle(Offset(center.dx + 40, center.dy - 30), 15, eyePaint);

    // smile arc
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: 80),
      0.1 * pi,
      0.8 * pi,
      false,
      smilePaint,
    );

    // cheeks
    final cheekPaint = Paint()..color = Colors.pinkAccent;
    canvas.drawCircle(Offset(center.dx - 70, center.dy + 20), 20, cheekPaint);
    canvas.drawCircle(Offset(center.dx + 70, center.dy + 20), 20, cheekPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
