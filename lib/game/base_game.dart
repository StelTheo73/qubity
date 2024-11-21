import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:qartvm/qartvm.dart';
import 'package:yaml/yaml.dart';

import '../constants/assets.dart';
import '../constants/gates.dart';
import '../utils/level.dart';
import 'game_utils.dart';
import 'objects/spaceship.dart';
import 'state/bits_state.dart';
import 'state/level_state.dart';

class BaseGame extends FlameGame<World>
    with TapCallbacks, HasCollisionDetection {
  BaseGame({required this.level});

  bool running = true;
  YamlMap level;
  late QRegister gameRegister;

  @override
  Future<void> onLoad() async {
    await _setup();
    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  Future<void> cacheImage(String imagePath) async {
    await images.load(imagePath);
  }

  Future<void> _cacheGateImages() async {
    for (final Map<String, dynamic> gate in gatesMap.values) {
      await cacheImage(GameUtils.extractImagePath(gate['image']! as String));
    }
  }

  Future<void> _cacheParallaxImages() async {
    await cacheImage(GameUtils.extractImagePath(parallaxBigStarsPath));
    await cacheImage(GameUtils.extractImagePath(parallaxSmallStarsPath));
  }

  Future<void> _setup() async {
    await _cacheParallaxImages();

    await Future.wait(<Future<void>>[
      _setupParallax(),
      _cacheGateImages(),
    ]);

    await Future.wait(<Future<void>>[
      _setupStates(),
      _setupTargets(),
      _setupGates(),
      _setupSpaceships(),
    ]);
  }

  Future<void> _setupGates() async {}

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

  Future<void> _setupSpaceships() async {
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
    final String targetImagePath = LevelLoader.getLevelTargetImage(level);
    LevelStates.levelTargetComponents.clear();
    LevelStates.createLevelTargets(levelTargets, targetImagePath);
    await addAll(LevelStates.levelTargetComponents);
    await addAll(LevelStates.levelEnemies);
  }

  Future<void> teardown() async {
    LevelStates.teardown(remove);

    // Future.wait
    // _teardownStates
    // _teardownEnemies
    // _teardownGates
    // _teardownSpaceships
  }
}
