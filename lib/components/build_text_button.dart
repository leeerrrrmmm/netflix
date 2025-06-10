import 'package:flutter/material.dart';

class BuildTextButton extends StatelessWidget {
  final String? fontFamily;
  final double fontSize;
  final Color? textColor;
  final FontWeight fontWeight;
  final String text;
  final void Function() onTap;

  const BuildTextButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    this.textColor,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
