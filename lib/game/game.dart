import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

import '../constants/assets.dart';
import 'game_utils.dart';
import 'objects/spaceship.dart';

class QubityGame extends FlameGame<World>
    with TapCallbacks, HasCollisionDetection {
  QubityGame({required this.level});

  bool running = true;
  YamlMap level;

  final List<Spaceship> spaceships = List<Spaceship>.empty(growable: true);

  Future<void> onLoad() async {
    print('loading game');
    print('level info: $level');
    await _setup();
    await super.onLoad();
  }

  void update(double dt) {
    super.update(dt);
  }

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
      _setupStates(),
      _setupParallax(),
    ]);

    await Future.wait(<Future<void>>[
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

  Future<void> _setupStates() async {}

  Future<void> _setupSpaceships() async {
    final Spaceship spaceship = Spaceship();
    add(spaceship);
    spaceships.add(spaceship);
  }
}
