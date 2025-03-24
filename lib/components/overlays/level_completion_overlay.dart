import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../constants/colors.dart';
import '../../l10n/app_localizations.dart';
import '../../store/current_score_notifier.dart';
import '../../store/level_state_notifier.dart';
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
      listenable: currentScoreNotifier,
      builder: (BuildContext context, Widget? child) {
        if (currentScoreNotifier.highScore) {
          return RobotoText(
            text: AppLocalizations.of(context)!.levelNewHighScore,
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
            text: AppLocalizations.of(context)!.nextLevel,
            width: 200,
            icon: Icons.arrow_forward,
            mainAxisAlignment: MainAxisAlignment.start,
          );
        }
        return RobotoText(
          text: AppLocalizations.of(context)!.gameCompleted,
          fontSize: 18,
          fontWeight: FontWeight.bold,
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
    required this.hasUnlockedSpaceship,
  });

  final Vector2 gameSize;
  final VoidCallback loadNextLevel;
  final VoidCallback onExit;
  final VoidCallback reloadLevel;
  final double score;
  final bool hasUnlockedSpaceship;

  static const String overlayKey = 'level_completion_overlay';
  static const int priority = 2;

  void _loadToast(BuildContext context) {
    toastification.show(
      context: context,
      closeOnClick: true,
      autoCloseDuration: const Duration(seconds: 5),
      showIcon: true,
      icon: const Icon(
        Icons.rocket_launch,
        color: Palette.primary,
      ),
      title: RobotoText(
        text: AppLocalizations.of(context)!.spaceshipUnlockedTitle,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      description: RobotoText(
        text: AppLocalizations.of(context)!.spaceshipUnlockedMessage,
        fontSize: 12,
        color: Palette.black,
      ),
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (BuildContext context, Animation<double> animation,
              Alignment alignment, Widget child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (hasUnlockedSpaceship) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadToast(context));
    }

    return BaseOverlay(
      gameSize: gameSize,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RobotoText(
            text: AppLocalizations.of(context)!.levelCompleted,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          const LevelCompletionScore(),
          const SizedBox(height: 5),
          const HighScoreWidget(),
          const SizedBox(height: 20),
          NextLevelWidget(
            loadNextLevel: loadNextLevel,
          ),
          const SizedBox(height: 20),
          BaseButton(
            onPressed: reloadLevel,
            text: AppLocalizations.of(context)!.restartLevel,
            width: 200,
            icon: Icons.refresh,
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          const SizedBox(height: 20),
          BaseButton(
            onPressed: onExit,
            text: AppLocalizations.of(context)!.levelSelection,
            width: 200,
            icon: Icons.format_list_numbered,
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ],
      ),
    );
  }
}
