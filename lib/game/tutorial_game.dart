import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../store/level_state_notifier.dart';
import '../store/tutorial_notifier.dart';
import '../utils/level.dart';
import 'components/tutorial_box.dart';
import 'qubity_game.dart';
import 'state/level_state.dart';

enum TutorialState {
  gate,
  register,
  shoot,
  completed,
}

class TutorialGame extends QubityGame {
  TutorialGame({required super.level});

  late final RectangleComponent gateTutorial;
  late final RectangleComponent registerTutorial;
  late final RectangleComponent shootTutorial;
  late final RectangleComponent exitTutorial;

  TutorialState tutorialState = TutorialState.gate;

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
      // super.loadTutorial(),
    ]);

    await setupGameTutorial();

    // pauseLevel(addOverlay: false);
  }

  @override
  void onTapUpCircuitGate(TapUpEvent event) {
    if (tutorialState == TutorialState.register) {
      tutorialState = TutorialState.shoot;
      remove(registerTutorial);
      add(shootTutorial);
    }
  }

  @override
  void onTapUpGate(TapUpEvent event) {
    if (tutorialState == TutorialState.gate) {
      tutorialState = TutorialState.register;
      remove(gateTutorial);
      add(registerTutorial);
    }
  }

  @override
  void onTapUpShootButton(TapUpEvent event) {
    if (tutorialState == TutorialState.shoot) {
      tutorialState = TutorialState.completed;
      remove(shootTutorial);
      add(exitTutorial);
    }
  }

  @override
  Future<void> reloadLevel() async {
    await super.reloadLevel();

    if (gateTutorial.isMounted) {
      remove(gateTutorial);
    }
    if (registerTutorial.isMounted) {
      remove(registerTutorial);
    }
    if (shootTutorial.isMounted) {
      remove(shootTutorial);
    }
    tutorialState = TutorialState.gate;
    add(gateTutorial);
  }

  @override
  void renderLevelStateOverlay(Canvas canvas) {}

  @override
  void showHelp() {
    closeOverlays();
    super.loadTutorial();
  }

  Future<void> setupGameTutorial() async {
    final Vector2 lastGatePosition =
        LevelStates.levelGateComponents.last.position;
    final Vector2 registerPosition = registerComponent.position;
    final Vector2 shootPosition = shootButton.position;

    gateTutorial = TutorialBoxComponent(
      position: Vector2(lastGatePosition.x + 120, lastGatePosition.y),
      state: TutorialState.gate,
      size: Vector2(150, 60),
    );

    registerTutorial = TutorialBoxComponent(
      position: Vector2(registerPosition.x + 250, registerPosition.y + 100),
      state: TutorialState.register,
      size: Vector2(130, 100),
    );

    shootTutorial = TutorialBoxComponent(
      position: Vector2(registerPosition.x + 250, shootPosition.y + 100),
      state: TutorialState.shoot,
      size: Vector2(130, 100),
    );

    exitTutorial = TutorialBoxComponent(
      position: Vector2(size.x / 2, size.y * 0.4),
      state: TutorialState.completed,
      size: Vector2(200, 80),
    );

    add(gateTutorial);
  }

  @override
  Future<void> triggerLevelCompletion() async {}
}
