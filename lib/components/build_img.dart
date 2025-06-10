import 'package:flutter/material.dart';

class BuildImg extends StatelessWidget {
  final String assetPath;

  const BuildImg({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(assetPath, filterQuality: FilterQuality.high);
  }
}
