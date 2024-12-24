import 'dart:ui';

import 'package:flame/components.dart';

import '../store/level_state_notifier.dart';
import '../store/tutorial_notifier.dart';
import '../utils/level.dart';
import 'qubity_game.dart';
import 'state/level_state.dart';

class TutorialGame extends QubityGame {
  TutorialGame({required super.level});

  @override
  Future<void> loadTutorial() async {
    final List<Map<String, String>> tutorial =
        await LevelLoader.getLevelTutorial(levelStateNotifier.levelId);
    tutorialNotifier.setTutorialMap(tutorial);
  }

  @override
  Future<void> onLoad() async {
    await super.cacheImages();
    await super.setupParallax();

    await Future.wait(<Future<void>>[
      super.setupUI(),
      super.setupGame(),
    ]);

    await setupTutorial();
  }

  @override
  void renderLevelStateOverlay(Canvas canvas) {}

  @override
  void showHelp() {
    print('Showing help');
  }

  Future<void> setupTutorial() async {
    print('Setting up tutorial');

    final gatesPosition = LevelStates.levelGateComponents;
    print(gatesPosition);
  }

  @override
  Future<void> triggerLevelCompletion() async {}
}
