import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../constants/assets.dart';
import '../game.dart';
import '../game_utils.dart';

class Missile extends PositionComponent
    with HasGameRef<QubityGame>, CollisionCallbacks {
  Missile({
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2(10, 30),
          anchor: Anchor.center,
        );

  late final SpriteComponent spriteComponent;
  final double _speed = 300.0;
  final Vector2 _velocity = Vector2(1, 0)..rotate(3 * pi / 2);

  @override
  Future<void> onLoad() async {
    await add(RectangleHitbox());
    _velocity.scaleTo(_speed);

    final String spriteImagePath = GameUtils.extractImagePath(missilePath);
    final Sprite sprite = await gameRef.loadSprite(spriteImagePath);
    spriteComponent = SpriteComponent(
      anchor: Anchor.center,
      sprite: sprite,
      size: size,
    );

    add(spriteComponent);
    super.onLoad();
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);
    position.add(_velocity * dt);
    if (gameRef.isPositionOutOfBounds(position)) {
      removeFromParent();
    }
  }
}
