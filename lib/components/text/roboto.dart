import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextRoboto extends StatelessWidget {
  const TextRoboto({
    required this.text,
    this.color = Colors.orange,
    this.fontSize = 10,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.overflow = TextOverflow.clip,
    super.key,
  });

  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
