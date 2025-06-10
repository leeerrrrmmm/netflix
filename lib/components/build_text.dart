import 'package:flutter/material.dart';

class BuildText extends StatelessWidget {
  final String? fontFamily;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final String text;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const BuildText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    this.color,
    this.fontFamily,
    this.textAlign,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: overflow,
      textAlign: textAlign,
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}
