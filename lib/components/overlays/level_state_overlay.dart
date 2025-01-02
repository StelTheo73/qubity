import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';

class LevelStateOverlay {
  final TextPaint _levelText = TextPaint(
    style: GoogleFonts.roboto(
      textStyle: const TextStyle(
        color: Palette.primary,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  final TextPaint _shotsFiredText = TextPaint(
    style: GoogleFonts.roboto(
      textStyle: const TextStyle(
        color: Palette.white,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  final TextPaint _gatesUsedText = TextPaint(
    style: GoogleFonts.roboto(
      textStyle: const TextStyle(
        color: Palette.white,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  void render(Canvas canvas, int levelId, int shotsFired, int gatesUsed) {
    _levelText.render(
      canvas,
      'Level $levelId',
      Vector2(15, 20),
      anchor: Anchor.centerLeft,
    );

    _shotsFiredText.render(
      canvas,
      'Shots Fired: $shotsFired',
      Vector2(100, 0),
    );

    _gatesUsedText.render(
      canvas,
      'Gates Used: $gatesUsed',
      Vector2(100, 20),
    );
  }
}
