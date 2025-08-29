import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HeartParticles extends StatefulWidget {
  const HeartParticles({super.key});

  @override
  State<HeartParticles> createState() => _BalloonParticlesState();
}

class _BalloonParticlesState extends State<HeartParticles> with SingleTickerProviderStateMixin {
  late final List<HeartParticle> _particles;
  late final AnimationController _controller;
  Size? _screenSize;
  final _random = Random();
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.pink,
    Colors.purple,
    Colors.yellow,
  ];

  double get width => _screenSize?.width ?? 400;
  double get height => _screenSize?.height ?? 800;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenSize = MediaQuery.of(context).size;
    });

    _initParticles(35);

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.addListener(_update);

    _controller.loop();
  }

  @override
  void dispose() {
    _controller.removeListener(_update);
    _controller.dispose();
    super.dispose();
  }

  Color _getRandomColor() {
    return _colors[_random.nextInt(_colors.length)];
  }

  void _initParticles(int n) {
    final List<HeartParticle> particles = [];
    for (int i = 0; i < n; i++) {
      particles.add(_createRandomParticle());
    }

    _particles = particles;
  }

  HeartParticle _createRandomParticle() {
    final w = 35.0;
    final x = (_random.nextDouble() * width);
    // max height + 400, min = height - 100
    // formula: min + (max - min)
    final y = (height - 100) + (_random.nextDouble() * 500);
    return HeartParticle(x: x, y: y, width: w, height: w, color: _getRandomColor());
  }

  // Updates UI
  void _update() {
    for (int i = 0; i < _particles.length; i++) {
      _particles[i].y -= 5;

      // If the heart is out of the page remove it and add new one
      if (_particles[i].y <= 0) {
        _particles.removeAt(i);
        _particles.add(_createRandomParticle());
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: HeartPainter(particles: _particles),
    );
  }
}

class HeartPainter extends CustomPainter {
  final List<HeartParticle> particles;

  const HeartPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.style = PaintingStyle.fill;

    // Draw heart
    for (final heart in particles) {
      final x = heart.x;
      final y = heart.y;
      final w = heart.width;
      final h = heart.height;
      final Path path = Path();
      path.moveTo(x + (w * 0.5), y + (h * 0.4));
      path.cubicTo(x + (w * 0.2), y + (h * 0.1), x + (-0.25 * w), y + (h * 0.6), x + (0.5 * w), y + h);
      path.moveTo(x + (0.5 * w), y + (h * 0.4));
      path.cubicTo(x + (0.8 * w), y + (h * 0.1), x + (1.25 * w), y + (h * 0.6), x + (0.5 * w), y + h);
      path.close();

      paint.color = heart.color.withValues(alpha: 0.75);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class HeartParticle {
  final double x;
  double y;
  final double width;
  final double height;
  final Color color;

  HeartParticle({required this.x, required this.y, required this.width, required this.height, required this.color});
}
