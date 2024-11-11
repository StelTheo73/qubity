import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

import '../constants/assets.dart';
import '../utils/level.dart';
import 'game_utils.dart';
import 'objects/spaceship.dart';
import 'quantum/quantum_state.dart';

class BaseGame extends FlameGame<World>
    with TapCallbacks, HasCollisionDetection {
  BaseGame({required this.level});

  bool running = true;
  YamlMap level;

  final List<Spaceship> levelSpaceships = List<Spaceship>.empty(growable: true);
  // final Map<String, dynamic> levelStates = <String, dynamic>{};
  final List<RectangleComponent> levelStates =
      List<RectangleComponent>.empty(growable: true);

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
    final YamlList _levelStates = LevelLoader.getLevelStates(level);
    final LevelStates _levelStatesObject = LevelStates(_levelStates);
    final List<Offset> validPositions =
        _levelStatesObject.getValidPositions(size);

    for (final validPosition in validPositions) {
      final Vector2 rectangleSize = Vector2(25, 25);
      final Vector2 textBoxSize = Vector2(25, 25);
      const double textSize = 10.0;

      final stateComponent = RectangleComponent(
        position: Vector2(validPosition.dx, validPosition.dy),
        anchor: Anchor.center,
        size: rectangleSize,
        scale: Vector2(1.0, 1.0),
        paint: Paint()..color = Colors.purple,
        children: [
          TextBoxComponent(
            text: '|XY>',
            boxConfig: const TextBoxConfig(
              margins: EdgeInsets.zero,
            ),
            textRenderer: TextPaint(
              style: const TextStyle(
                color: Colors.white,
                fontSize: textSize,
              ),
            ),
            size: textBoxSize,
            position: (rectangleSize - Vector2(textSize, textSize)) / 2,
            anchor: Anchor.topLeft,
          ),
        ],
      );
      levelStates.add(stateComponent);
      await add(stateComponent);
    }
  }

  Future<void> _setupSpaceships() async {
    final Spaceship spaceship = Spaceship();
    add(spaceship);
    levelSpaceships.add(spaceship);
  }

  Future<void> _teardown() async {
    // Future.wait
    // _teardownStates
    // _teardownEnemies
    // _teardownGates
    // _teardownSpaceships
  }
}
