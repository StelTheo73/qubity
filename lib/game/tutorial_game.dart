import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../store/level_state_notifier.dart';
import '../store/tutorial_notifier.dart';
import '../utils/level.dart';
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
      super.loadTutorial(),
    ]);

    await setupGameTutorial();

    pauseLevel(addOverlay: false);
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
    print('Setting up tutorial');

    final Vector2 lastGatePosition =
        LevelStates.levelGateComponents.last.position;
    final Vector2 registerPosition = registerComponent.position;
    final Vector2 shootPosition = shootButton.position;

    gateTutorial = RectangleComponent(
      anchor: Anchor.center,
      position: Vector2(lastGatePosition.x + 120, lastGatePosition.y),
      size: Vector2(150, 60),
      paint: Paint()..color = Palette.primary,
      children: <Component>[
        TextBoxComponent<TextPaint>(
          text: '1. Select a gate',
          align: Anchor.center,
          textRenderer: TextPaint(
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: Palette.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          size: Vector2(150, 60),
          anchor: Anchor.topLeft,
        ),
      ],
    );

    registerTutorial = RectangleComponent(
      anchor: Anchor.center,
      position: Vector2(registerPosition.x + 250, registerPosition.y + 100),
      size: Vector2(120, 60),
      paint: Paint()..color = Palette.primary,
      children: <Component>[
        TextBoxComponent<TextPaint>(
          text: "2. Tap on a '+' icon to apply the gate to a qubit",
          align: Anchor.center,
          textRenderer: TextPaint(
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: Palette.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          size: Vector2(120, 60),
          anchor: Anchor.topLeft,
        ),
      ],
    );

    shootTutorial = RectangleComponent(
      anchor: Anchor.center,
      position: Vector2(shootPosition.x, shootPosition.y + 100),
      size: Vector2(120, 60),
      paint: Paint()..color = Palette.primary,
      children: <Component>[
        TextBoxComponent<TextPaint>(
          text: '3. Tap on the shoot button to fire the missiles',
          align: Anchor.center,
          textRenderer: TextPaint(
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: Palette.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          size: Vector2(120, 60),
          anchor: Anchor.topLeft,
        ),
      ],
    );

    exitTutorial = RectangleComponent(
      anchor: Anchor.center,
      position: Vector2(size.x / 2, size.y * 0.4),
      size: Vector2(200, 60),
      paint: Paint()..color = Palette.primary,
      children: <Component>[
        TextBoxComponent<TextPaint>(
          text:
              'Click the pause button on the top right corner to exit tutorial',
          align: Anchor.center,
          textRenderer: TextPaint(
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: Palette.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          size: Vector2(200, 60),
          anchor: Anchor.topLeft,
        ),
      ],
    );

    add(gateTutorial);
  }

  @override
  Future<void> triggerLevelCompletion() async {}
}
