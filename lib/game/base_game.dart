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

  final List<Spaceship> levelSpaceships = List<Spaceship>.empty(growable: true);
  // final Map<String, dynamic> levelStates = <String, dynamic>{};
  final List<RectangleComponent> levelStateComponents =
      List<RectangleComponent>.empty(growable: true);

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
    final LevelStates levelStatesObject = LevelStates(levelStates.keys);
    final List<RectangleComponent> stateComponents =
        levelStatesObject.getStatesComponents(size);
    await addAll(stateComponents);
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

    final Spaceship spaceship = Spaceship();
    await add(spaceship);
    // levelSpaceships.add(spaceship);
  }

  Future<void> _teardown() async {
    // Future.wait
    // _teardownStates
    // _teardownEnemies
    // _teardownGates
    // _teardownSpaceships
  }
}
