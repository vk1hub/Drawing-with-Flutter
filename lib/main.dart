// Created by: Adi Nair, Vishal Kuttua

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const EmojiProjectApp());
}

class EmojiProjectApp extends StatelessWidget {
  const EmojiProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'emoji project',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const EmojiHomeScreen(),
    );
  }
}

class EmojiHomeScreen extends StatefulWidget {
  const EmojiHomeScreen({super.key});

  @override
  State<EmojiHomeScreen> createState() => _EmojiHomeScreenState();
}

class _EmojiHomeScreenState extends State<EmojiHomeScreen> {
  String selectedEmoji = "Heart"; // default choice

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("interactive emoji drawing")),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.lightBlueAccent, Colors.white],
          ),
        ),

        child: Column(
          children: [
            // ui buttons to pick emoji
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => selectedEmoji = "Heart"),
                  child: const Text("❤️ heart"),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => selectedEmoji = "Smiley"),
                  child: const Text("😀 smiley"),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => selectedEmoji = "Party"),
                  child: const Text("🎉 party face"),
                ), // partner's work later
              ],
            ),
            const SizedBox(height: 20),

            // drawing area
            Expanded(
              child: Center(
                child: CustomPaint(
                  painter: _getPainter(selectedEmoji),
                  size: const Size(400, 400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // choose which painter to use
  CustomPainter _getPainter(String emoji) {
    switch (emoji) {
      case "Heart":
        return HeartPainter();
      case "Smiley":
        return SmileyPainter();
      case "Party":
        return partyHatPainter(); // left for partner
      default:
        return HeartPainter();
    }
  }
}

/// heart emoji
class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;
    final path = Path();
    final width = size.width / 2;
    final height = size.height / 2;

    // draw a heart using curves
    path.moveTo(width, height + 40);
    path.cubicTo(
      width + 100,
      height - 20,
      width + 40,
      height - 120,
      width,
      height - 40,
    );
    path.cubicTo(
      width - 40,
      height - 120,
      width - 100,
      height - 20,
      width,
      height + 40,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// re-used smiley face
class SmileyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // face
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

/// ur work placeholder
class partyHatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // face
    final facePaint = Paint()..color = Colors.yellow;
    canvas.drawCircle(center, 120, facePaint);

    // eyes
    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(center.dx - 40, center.dy - 30), 12, eyePaint);
    canvas.drawCircle(Offset(center.dx + 40, center.dy - 30), 12, eyePaint);

    // mouth
    canvas.drawCircle(Offset(center.dx, center.dy + 50), 22, eyePaint);

    // party hat
    final hatPaint = Paint()..color = Colors.blue;
    final hatPath = Path();
    hatPath.moveTo(center.dx - 70, center.dy - 100);
    hatPath.lineTo(center.dx + 70, center.dy - 100);
    hatPath.lineTo(center.dx, center.dy - 200);
    hatPath.close();
    canvas.drawPath(hatPath, hatPaint);

    // saving canvas to ensure clipping on party hat
    canvas.save();
    canvas.clipPath(hatPath);

    // stripes on party hat
    final stripePaint = Paint()
      ..color = const Color.fromARGB(255, 159, 35, 26)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    // drawing lines on party hat
    for (int i = -160; i < 150; i += 25) {
      canvas.drawLine(
        Offset(center.dx + i, center.dy - 100), // Start of the line (bottom)
        Offset(center.dx + i + 70, center.dy - 200), // End of the line (top)
        stripePaint,
      );
    }

    // canvas restore to prevent clipping on party hat
    canvas.restore();

    // pom-pom on top of hat
    final pomponPaint = Paint()..color = const Color.fromARGB(255, 255, 0, 85);
    canvas.drawCircle(Offset(center.dx, center.dy - 200), 15, pomponPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
