import 'package:flutter/material.dart';

class CurvedSmile extends StatelessWidget {
  const CurvedSmile({
    super.key,
    required this.width,
    required this.height,
    required this.strokeWidth,
  });
  final double width;
  final double height;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: SmilePainter(strokeWidth: strokeWidth),
    );
  }
}

class SmilePainter extends CustomPainter {
  const SmilePainter({required this.strokeWidth});
  final double strokeWidth;
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final path = Path();

    // Нарисуем дугу от левого края к правому
    path.moveTo(20, size.height / 2);
    path.quadraticBezierTo(
      size.width / 2,
      size.height, // высота кривизны
      size.width - 20,
      size.height / 2,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
