import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../text/roboto.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.width,
    this.height = 50,
    this.fontSize = 16,
  });

  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.secondary,
          foregroundColor: Palette.black,
        ),
        onPressed: onPressed,
        child: TextRoboto(
          text: text,
          textAlign: TextAlign.center,
          color: Palette.black,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
