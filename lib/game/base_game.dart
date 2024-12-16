import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qartvm/qartvm.dart';
import 'package:yaml/yaml.dart';

import '../components/overlays/completion_overlay.dart';
import '../components/overlays/level_state_overlay.dart';
import '../components/overlays/pause_overlay.dart';
import '../constants/assets.dart';
import '../constants/colors.dart';
import '../utils/level.dart';
import 'components/menu_button.dart';
import 'components/shoot_button.dart';
import 'game_utils.dart';
import 'objects/gate.dart';
import 'objects/register.dart';
import 'objects/sprites.dart';
import 'state/bits_state.dart';
import 'state/level_state.dart';

class BaseGame extends FlameGame<World>
    with TapCallbacks, HasCollisionDetection {
  BaseGame({required this.level});

  // State
  // -----
  int asteroidHits = 0;
  int gatesUsed = 0;
  int shotsFired = 0;

  bool running = true;
  YamlMap level;

  // Components
  // ----------
  late LevelStateOverlay levelStateOverlay;
  late QRegister gameRegister;
  late PauseButton pauseButton;
  late RegisterComponent registerComponent;
  late RestartButton restartButton;
  late ShootButton shootButton;

  GateComponent? selectedGate;

  // Public Methods
  // --------------

  @override
  Future<void> onLoad() async {
    await _cacheImages();
    await _setupParallax();

    await Future.wait(<Future<void>>[
      _setupUI(),
      _setup(),
    ]);
    await super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    levelStateOverlay.render(
      canvas,
      level['id'] as int,
      shotsFired,
      gatesUsed,
    );
  }

  Future<void> cacheImage(String imagePath) async {
    await images.load(imagePath);
  }

  void exitLevel(BuildContext context) {
    teardown();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> loadNextLevel() async {
    pauseLevel(addOverlay: false);
    final int nextLevelId = (level['id'] as int) + 1;
    try {
      final YamlMap nextLevel = await LevelLoader.getLevelById(nextLevelId);
      level = nextLevel;
    } catch (error) {
      overlays.add(
        CompletionOverlay.overlayKey,
        priority: CompletionOverlay.priority,
      );
      return;
    }
    await reloadLevel();
  }

  void pauseLevel({bool addOverlay = true}) {
    pauseEngine();
    running = false;
    addOverlay &&
        overlays.add(
          PauseOverlay.overlayKey,
          priority: PauseOverlay.priority,
        );
  }

  void resumeLevel() {
    resumeEngine();
    running = true;
    overlays.remove(PauseOverlay.overlayKey);
  }

  Future<void> reloadLevel() async {
    await teardown();
    await _setup();
  }

  Future<void> sleep(int milliseconds) async {
    await Future<void>.delayed(Duration(milliseconds: milliseconds));
  }

  Future<void> teardown() async {
    LevelStates.teardown(removeAll, children);
    selectedGate = null;
    remove(registerComponent);
  }

  // Private Methods
  // ---------------

  Future<void> _cacheImages() async {
    await Future.wait(<Future<void>>[
      SpriteIcons.init(loadSprite),
      cacheImage(GameUtils.extractImagePath(explosionPath)),
      cacheImage(GameUtils.extractImagePath(parallaxBigStarsPath)),
      cacheImage(GameUtils.extractImagePath(parallaxSmallStarsPath)),
    ]);
  }

  Future<void> _setup() async {
    if (!running) {
      resumeLevel();
    }
    asteroidHits = 0;
    gatesUsed = 0;
    shotsFired = 0;

    await _setupStates();
    await _setupRegister();

    await Future.wait(<Future<void>>[
      _setupGates(),
      _setupSpaceships(),
      _setupTargets(),
    ]);
  }

  Future<void> _setupGates() async {
    final YamlList levelGates = LevelLoader.getLevelGates(level);
    // levelGates..insert(, element) TODO insert I gate
    LevelStates.createLevelGates(size, levelGates);
    await addAll(LevelStates.levelGateComponents);
  }

  Future<void> _setupParallax() async {
    late final ParallaxComponent<FlameGame<World>> parallax;
    final Vector2 parallaxBaseVelocity = Vector2(0, -25);
    final Map<String, double> layersMeta = <String, double>{
      GameUtils.extractImagePath(parallaxBigStarsPath): 1.0,
      GameUtils.extractImagePath(parallaxSmallStarsPath): 1.5,
    };

    final Iterable<Future<ParallaxLayer>> layers = layersMeta.entries.map(
      (MapEntry<String, double> layer) => loadParallaxLayer(
        ParallaxImageData(layer.key),
        velocityMultiplier: Vector2(1.0, layer.value),
        repeat: ImageRepeat.repeat,
      ),
    );

    parallax = ParallaxComponent<FlameGame<World>>(
      parallax: Parallax(
        await Future.wait(layers),
        baseVelocity: parallaxBaseVelocity,
      ),
    );

    await add(parallax);
  }

  Future<void> _setupRegister() async {
    final YamlList initialQubits = level['initial'] as YamlList;
    final List<Qbit> initialQubitsList = initialQubits
        .map(
          (dynamic qubit) => CreateQBit.createQBit(
            qubit[0] as String,
            qubit[1] as String,
          ),
        )
        .toList();

    gameRegister = QRegister(initialQubitsList);
    registerComponent = RegisterComponent(size, gameRegister);

    await add(registerComponent);
  }

  Future<void> _setupSpaceships() async {
    LevelStates.createSpaceshipPositions(gameRegister);
    LevelStates.createLevelSpaceships();

    await addAll(LevelStates.levelSpaceships);
  }

  Future<void> _setupStates() async {
    final YamlMap levelStates = LevelLoader.getLevelStates(level);
    LevelStates.validLevelStates.clear();
    LevelStates.levelStatePositions.clear();
    LevelStates.levelStateComponents.clear();
    LevelStates.setupLevelStates(size, levelStates.keys);
    await addAll(LevelStates.levelStateComponents);
  }

  Future<void> _setupTargets() async {
    final YamlList levelTargets = LevelLoader.getLevelTargets(level);
    LevelStates.levelTargetComponents.clear();
    LevelStates.createLevelTargets(levelTargets);
    await addAll(LevelStates.levelTargetComponents);
    await addAll(LevelStates.levelEnemies);
  }

  Future<void> _setupUI() async {
    levelStateOverlay = LevelStateOverlay();
    shootButton = ShootButton();
    pauseButton = PauseButton();
    restartButton = RestartButton();
    await addAll(<Component>[
      shootButton,
      pauseButton,
      restartButton,
    ]);
  }
}
