import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:qartvm/qartvm.dart';
import 'package:yaml/yaml.dart';

import '../constants/assets.dart';
import '../utils/level.dart';
import 'game_utils.dart';
import 'objects/spaceship.dart';
import 'quantum/quantum_bits.dart';
import 'quantum/quantum_state.dart';

class BaseGame extends FlameGame<World>
    with TapCallbacks, HasCollisionDetection {
  BaseGame({required this.level});

  bool running = true;
  YamlMap level;
  late QRegister gameRegister;

  final List<Spaceship> levelSpaceships = List<Spaceship>.empty(growable: true);

  @override
  Future<void> onLoad() async {
    print('loading game');
    print('level info: $level');
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

  Future<void> _cacheGameImages() async {
    await cacheImage(GameUtils.extractImagePath(parallaxBigStarsPath));
    await cacheImage(GameUtils.extractImagePath(parallaxSmallStarsPath));
  }

  Future<void> _setup() async {
    await _cacheGameImages();

    await Future.wait(<Future<void>>[
      _setupParallax(),
    ]);

    await Future.wait(<Future<void>>[
      _setupStates(),
      _setupEnemies(),
      _setupGates(),
      _setupSpaceships(),
    ]);
  }

  Future<void> _setupEnemies() async {}

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

  Future<void> _setupStates() async {
    final YamlMap levelStates = LevelLoader.getLevelStates(level);
    LevelStates.validLevelStates.clear();
    LevelStates.levelStatePositions.clear();
    LevelStates.levelStateComponents.clear();
    LevelStates.setupLevelStates(size, levelStates.keys);
    await addAll(LevelStates.levelStateComponents);
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
    for (final String state in gameRegister.amplitudes.keys) {
      final Complex amp = gameRegister.amplitudes[state]!;
      final double real = amp.re;
      final double imaginary = amp.im;

      String stateString = '';

      if (real > 0) {
        stateString = '|$state>';
      } else if (real < 0) {
        stateString = '-|$state>';
      } else if (imaginary < 0) {
        stateString = '-i|$state>';
      } else if (imaginary > 0) {
        stateString = 'i|$state>';
      }

      if (stateString.isNotEmpty) {
        LevelStates.validLevelStates[stateString] = true;
      }
    }

    for (final String state in LevelStates.validLevelStates.keys) {
      if (!LevelStates.validLevelStates[state]!) {
        continue;
      }

      final Offset position = LevelStates.levelStatePositions[state] as Offset;

      final Spaceship spaceship = Spaceship(
        position.dx,
        position.dy - LevelStates.stateComponentDimension * 1.5,
      );
      levelSpaceships.add(spaceship);
    }

    await addAll(levelSpaceships);
  }

  Future<void> _teardown() async {
    LevelStates.validLevelStates.clear();
    LevelStates.levelStatePositions.clear();

    // ignore: prefer_foreach
    for (final Spaceship spaceship in levelSpaceships) {
      remove(spaceship);
    }
    levelSpaceships.clear();

    // ignore: prefer_foreach
    for (final RectangleComponent component
        in LevelStates.levelStateComponents) {
      remove(component);
    }
    LevelStates.levelStateComponents.clear();

    // Future.wait
    // _teardownStates
    // _teardownEnemies
    // _teardownGates
    // _teardownSpaceships
  }
}
