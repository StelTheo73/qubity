import 'dart:math';

import 'package:flame/components.dart';

import '../game.dart';
import '../game_utils.dart';

class Asteroid extends SpriteComponent with HasGameRef<QubityGame> {
  Asteroid(this.positionX, this.positionY) : super(size: Vector2(40, 40));

  double positionX;
  double positionY;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    x = positionX;
    y = positionY;
    angle = pi;
    anchor = Anchor.center;
    final String spriteImagePath = GameUtils.getAsteroidImagePath();
    await gameRef.cacheImage(spriteImagePath);
    sprite = await gameRef.loadSprite(spriteImagePath);
  }
}
