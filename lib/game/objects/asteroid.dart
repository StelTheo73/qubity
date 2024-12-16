import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flame/sprite.dart';

import '../game.dart';
import '../game_utils.dart';
import 'missile.dart';

class Asteroid extends SpriteComponent
    with HasGameRef<QubityGame>, CollisionCallbacks {
  Asteroid(this.positionX, this.positionY) : super(size: Vector2(40, 40));

  double positionX;
  double positionY;

  final double animationDuration = 0.5;

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
    add(CircleHitbox());
  }

  @override
  Future<void> onCollision(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) async {
    super.onCollision(intersectionPoints, other);
    if (other is Missile) {
      _explosionAnimation();
      removeFromParent();
      other.removeFromParent();
    }
    await gameRef
        .sleep((2 * animationDuration * 1000).toInt())
        .then((_) => gameRef.asteroidHits++);
  }

  void _explosionAnimation() {
    parent!.add(
      ParticleSystemComponent(
        particle: AcceleratedParticle(
          lifespan: animationDuration,
          position: position,
          child: SpriteAnimationParticle(
            size: Vector2(100, 100),
            animation: _getExplosionAnimation(),
          ),
        ),
      ),
    );
  }

  SpriteAnimation _getExplosionAnimation() {
    const int columns = 3;
    const int rows = 3;
    const int frames = rows * columns;
    final SpriteSheet spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: gameRef.images.fromCache('rest/explosion.png'),
      columns: columns,
      rows: rows,
    );
    final List<Sprite> sprites = List<Sprite>.generate(
      frames,
      spriteSheet.getSpriteById,
    );
    return SpriteAnimation.spriteList(sprites, stepTime: 0.1);
  }
}
