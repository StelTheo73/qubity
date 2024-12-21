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
    this.color = Palette.primary,
    this.textColor = Palette.black,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.icon,
  });

  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;
  final double fontSize;
  final Color color;
  final Color textColor;
  final MainAxisAlignment mainAxisAlignment;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: <Widget>[
            if (icon != null) Icon(icon),
            if (icon != null) const SizedBox(width: 10),
            RobotoText(
              text: text,
              textAlign: TextAlign.center,
              color: Palette.black,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
