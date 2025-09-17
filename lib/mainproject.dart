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
      body: Column(
        children: [
          // ui buttons to pick emoji
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () => setState(() => selectedEmoji = "Heart"),
                  child: const Text("❤️ heart")),
              ElevatedButton(
                  onPressed: () => setState(() => selectedEmoji = "Smiley"),
                  child: const Text("😀 smiley")),
              ElevatedButton(
                  onPressed: () => setState(() => selectedEmoji = "Party"),
                  child: const Text("🎉 party face")), // partner’s work later
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
        return PlaceholderPainter(); // left for partner
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
    path.cubicTo(width + 100, height - 20, width + 40, height - 120, width, height - 40);
    path.cubicTo(width - 40, height - 120, width - 100, height - 20, width, height + 40);

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
class PlaceholderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(center, 100, paint);

    final textPainter = TextPainter(
      text: const TextSpan(
        text: "Rizz",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(center.dx - 60, center.dy - 10));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
