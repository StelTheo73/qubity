import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../button/base_button.dart';
import '../text/roboto.dart';
import 'base_overlay.dart';

class GameCompletionOverlay extends StatelessWidget {
  const GameCompletionOverlay({
    super.key,
    required this.onExit,
    required this.gameSize,
  });

  final VoidCallback onExit;
  final Vector2 gameSize;

  static const String overlayKey = 'game_completion_overlay';
  static const int priority = 2;

  @override
  Widget build(BuildContext context) {
    return BaseOverlay(
      gameSize: gameSize,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const RobotoText(
            text: 'Congratulations!',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10),
          const RobotoText(
            text: 'You have completed the game!',
            color: Palette.black,
            fontSize: 16,
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
