import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ConfettiDemo extends StatefulWidget {
  const ConfettiDemo({super.key});

  @override
  State<ConfettiDemo> createState() => _ConfettiDemoState();
}

class _ConfettiDemoState extends State<ConfettiDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<ConfettiParticle> _particles = [];
  final int _numParticles = 100;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
      updateParticles();
    });
  }

  void createParticles(Offset startPosition) {
    _particles.clear();
    for (int i = 0; i < _numParticles; i++) {
      final direction = Offset(
        (_random.nextDouble() - 0.5) * 4,
        -_random.nextDouble() * 4 - 2,
      );
      _particles.add(
        ConfettiParticle(
          position: startPosition,
          direction: direction,
          color: Colors.primaries[_random.nextInt(Colors.primaries.length)]
              .withOpacity(1.0),
          size: _random.nextDouble() * 6 + 4,
          life: 1.0,
        ),
      );
    }
  }

  void updateParticles() {
    final delta = 1 / 60;
    bool needRepaint = false;

    for (final p in _particles) {
      if (p.life > 0) {
        p.position += p.direction;
        p.direction = Offset(
          p.direction.dx,
          p.direction.dy + 0.1,
        ); // гравитация
        p.life -= delta;
        needRepaint = true;
      }
    }

    if (!needRepaint) {
      _controller.stop();
    }
    setState(() {});
  }

  void startAnimation() {
    final box = context.findRenderObject() as RenderBox;
    final center = box.size.center(Offset.zero);
    createParticles(center);
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Кастомные фантики Flutter')),
      body: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: ConfettiPainter(_particles),
          ),
          Center(
            child: ElevatedButton(
              onPressed: startAnimation,
              child: const Text('Показать фантики'),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfettiParticle {
  Offset position;
  Offset direction;
  final Color color;
  final double size;
  double life; // от 1 (полностью видим) до 0 (исчез)

  ConfettiParticle({
    required this.position,
    required this.direction,
    required this.color,
    required this.size,
    required this.life,
  });
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;

  ConfettiPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (final p in particles) {
      if (p.life <= 0) continue;

      paint.color = p.color.withOpacity(p.life);
      canvas.drawCircle(p.position, p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) => true;
}
