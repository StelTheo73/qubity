import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../button/base_button.dart';
import '../text/roboto.dart';
import 'base_overlay.dart';

class LevelCompletionOverlay extends StatelessWidget {
  const LevelCompletionOverlay({
    super.key,
    required this.onExit,
    required this.loadNextLevel,
    required this.gameSize,
  });

  final Vector2 gameSize;
  final VoidCallback onExit;
  final VoidCallback loadNextLevel;

  static const String overlayKey = 'level_completion_overlay';
  static const int priority = 2;

  @override
  Widget build(BuildContext context) {
    return BaseOverlay(
      gameSize: gameSize,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const RobotoText(
            text: 'Level Completed!',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          BaseButton(
            onPressed: loadNextLevel,
            text: 'Next Level',
            width: 200,
          ),
          const SizedBox(height: 20),
          BaseButton(
            onPressed: onExit,
            text: 'Level Selection',
            width: 200,
          ),
        ],
      ),
    );
  }
}
