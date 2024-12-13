import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.width,
  });

  final VoidCallback onPressed;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.secondary,
          foregroundColor: Palette.black,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
