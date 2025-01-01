import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RobotoText extends StatelessWidget {
  const RobotoText({
    super.key,
    required this.text,
    this.color = Colors.orange,
    this.fontSize = 10,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.overflow = TextOverflow.clip,
  });

  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: text
          .split(r'\n')
          .map(
            (String line) => Text(
              line,
              textAlign: textAlign,
              overflow: overflow,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: color,
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.normal,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
