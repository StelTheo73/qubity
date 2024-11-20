import 'dart:math';

import 'package:flame/components.dart';

import '../game.dart';
import '../game_utils.dart';

class Enemy extends SpriteComponent with HasGameRef<QubityGame> {
  Enemy(this.positionX, this.positionY, this.spriteImagePath)
      : super(size: Vector2(50, 50));

  String spriteImagePath;
  double positionX;
  double positionY;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    x = positionX;
    y = positionY;
    angle = pi;
    anchor = Anchor.center;
    spriteImagePath = GameUtils.extractImagePath(spriteImagePath);
    await gameRef.cacheImage(spriteImagePath);
    sprite = await gameRef.loadSprite(spriteImagePath);
  }
}
