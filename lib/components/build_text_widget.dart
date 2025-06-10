import 'package:flutter/material.dart';

class TextBuild extends StatelessWidget {
  const TextBuild({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
