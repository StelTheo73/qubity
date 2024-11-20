import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../../utils/spaceship.dart';
import '../game.dart';
import '../game_utils.dart';

class Spaceship extends SpriteComponent with HasGameRef<QubityGame> {
  Spaceship(this.positionX, this.positionY) : super(size: Vector2(50, 50));

  late final String spriteImagePath;
  double positionX;
  double positionY;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    x = positionX;
    y = positionY;
    anchor = Anchor.center;
    spriteImagePath = GameUtils.extractImagePath(
        (await SpaceshipLoader.getSelectedSpaceship())['player'] as String);
    await gameRef.cacheImage(spriteImagePath);
    sprite = await gameRef.loadSprite(spriteImagePath);
  }

  @override
  void update(double dt) {
    super.update(dt);
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
