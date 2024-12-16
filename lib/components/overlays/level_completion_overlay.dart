import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../utils/config.dart';
import '../button/base_button.dart';
import '../score/score.dart';
import '../text/roboto.dart';
import 'base_overlay.dart';

class LevelCompletionOverlay extends StatelessWidget {
  const LevelCompletionOverlay({
    super.key,
    required this.gameSize,
    required this.loadNextLevel,
    required this.reloadLevel,
    required this.onExit,
    required this.score,
    required this.nextLevelId,
  });

  final Vector2 gameSize;
  final VoidCallback loadNextLevel;
  final VoidCallback onExit;
  final VoidCallback reloadLevel;
  final double score;
  final int nextLevelId;

  static const String overlayKey = 'level_completion_overlay';
  static const int priority = 2;

  @override
  Widget build(BuildContext context) {
    late final bool hasNextLevel;

    if (nextLevelId > Configuration.noOfLevels) {
      hasNextLevel = false;
    } else {
      hasNextLevel = true;
    }

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
          Score(
            score: score,
            starWidth: 60,
            starHeight: 60,
          ),
          const SizedBox(height: 20),
          if (hasNextLevel)
            BaseButton(
              onPressed: loadNextLevel,
              text: 'Next Level',
              width: 200,
            )
          else
            const RobotoText(
              text: 'You have completed the game!',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          const SizedBox(height: 20),
          BaseButton(
            onPressed: reloadLevel,
            text: 'Restart Level',
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
