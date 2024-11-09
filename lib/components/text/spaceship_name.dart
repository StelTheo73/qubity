import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpaceshipNameText extends StatelessWidget {
  const SpaceshipNameText({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      alignment: Alignment.center,
      child: Text(
        name,
        textAlign: TextAlign.center,
        overflow: TextOverflow.visible,
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
