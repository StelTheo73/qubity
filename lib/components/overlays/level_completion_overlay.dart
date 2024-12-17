import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../state/high_score_notifier.dart';
import '../../state/level_state_notifier.dart';
import '../../utils/config.dart';
import '../button/base_button.dart';
import '../score/score.dart';
import '../text/roboto.dart';
import 'base_overlay.dart';

class HighScoreWidget extends StatelessWidget {
  const HighScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: highScoreNotifier,
      builder: (BuildContext context, Widget? child) {
        if (highScoreNotifier.highScore) {
          return const RobotoText(
            text: 'New High Score!',
            fontSize: 12,
            fontWeight: FontWeight.bold,
          );
        }
        return const SizedBox();
      },
    );
  }
}

class NextLevelWidget extends StatelessWidget {
  const NextLevelWidget({super.key, required this.loadNextLevel});

  final VoidCallback loadNextLevel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: levelStateNotifier,
      builder: (BuildContext context, Widget? child) {
        if (levelStateNotifier.nextLevelId <= Configuration.noOfLevels) {
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
    );
  }
}

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: levelStateNotifier,
      builder: (BuildContext context, Widget? child) {
        return Score(
          levelId: levelStateNotifier.levelId,
          starWidth: 60,
          starHeight: 60,
        );
      },
    );
  }
}

class LevelCompletionOverlay extends StatelessWidget {
  const LevelCompletionOverlay({
    super.key,
    required this.gameSize,
    required this.loadNextLevel,
    required this.reloadLevel,
    required this.onExit,
    required this.score,
  });

  final Vector2 gameSize;
  final VoidCallback loadNextLevel;
  final VoidCallback onExit;
  final VoidCallback reloadLevel;
  final double score;

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
          const ScoreWidget(),
          const SizedBox(height: 5),
          const HighScoreWidget(),
          const SizedBox(height: 20),
          NextLevelWidget(
            loadNextLevel: loadNextLevel,
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
