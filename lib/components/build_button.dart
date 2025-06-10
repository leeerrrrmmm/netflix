import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  final String? fontFamily;
  final double fontSize;
  final Color? color;
  final Color? textColor;
  final FontWeight fontWeight;
  final String text;
  final void Function() onTap;

  const BuildButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.textColor,
    this.color,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        width: double.infinity,
        height: 56,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontFamily: fontFamily,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
