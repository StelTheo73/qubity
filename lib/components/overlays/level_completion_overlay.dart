import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../state/level_state_notifier.dart';
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
    required this.newHighScore,
  });

  final Vector2 gameSize;
  final VoidCallback loadNextLevel;
  final VoidCallback onExit;
  final VoidCallback reloadLevel;
  final double score;
  final bool newHighScore;

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
          Score(
            score: score,
            starWidth: 60,
            starHeight: 60,
          ),
          const SizedBox(height: 5),
          if (newHighScore)
            const RobotoText(
              text: 'New High Score!',
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          const SizedBox(height: 20),
          ListenableBuilder(
            listenable: levelStateNotifier,
            builder: (BuildContext context, Widget? child) {
              late final bool hasNextLevel;

              if (levelStateNotifier.nextLevelId > Configuration.noOfLevels) {
                hasNextLevel = false;
              } else {
                hasNextLevel = true;
              }

              if (hasNextLevel) {
                return BaseButton(
                  onPressed: loadNextLevel,
                  text: 'Next Level',
                  width: 200,
                );
              }
              return const RobotoText(
                text: 'You have completed the game!',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              );
            },
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
