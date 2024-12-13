import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../game/game.dart';

class LevelStateOverlay extends Component with HasGameRef<QubityGame> {
  final TextPaint levelText = TextPaint(
    style: const TextStyle(
      color: Palette.secondary,
      fontSize: 16,
    ),
  );

  final TextPaint shotsFiredText = TextPaint(
    style: const TextStyle(
      color: Palette.white,
      fontSize: 16,
    ),
  );

  final TextPaint gatesUsedText = TextPaint(
    style: const TextStyle(
      color: Palette.white,
      fontSize: 16,
    ),
  );

  @override
  void render(Canvas canvas) {
    levelText.render(
      canvas,
      'Level ${gameRef.level['id']}',
      Vector2(0, 0),
    );

    shotsFiredText.render(
      canvas,
      'Shots Fired: ${gameRef.shotsFired}',
      Vector2(0, 20),
    );

    gatesUsedText.render(
      canvas,
      'Gates Used: ${gameRef.gatesUsed}',
      Vector2(20, 20),
    );
  }
}
