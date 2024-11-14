import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../../utils/spaceship.dart';
import '../game.dart';
import '../game_utils.dart';

class Spaceship extends SpriteComponent with HasGameRef<QubityGame> {
  Spaceship() : super(size: Vector2(50, 50));

  late final String spriteImagePath;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    spriteImagePath = GameUtils.extractImagePath(
        (await SpaceshipLoader.getSelectedSpaceship())['image'] as String);
    await gameRef.cacheImage(spriteImagePath);
    sprite = await gameRef.loadSprite(spriteImagePath);
  }

  @override
  void update(double dt) {
    super.update(dt);
    final Vector2 position = gameRef.size / 2;
    x = position.x - size.x / 2;
    y = position.y - size.y / 2;
  }

  Future<void> shake() async {
    // shake effect has to be re-declared every time we want to use it,
    // because it's a one-time effect.
    // Otherwise, it will apply the effect only once.
    final MoveEffect shakeEffect = MoveEffect.by(
      Vector2(0, 5),
      ZigzagEffectController(period: 0.2),
    );
    await add(shakeEffect);
  }
}
