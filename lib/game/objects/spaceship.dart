import 'package:flame/components.dart';

import '../game.dart';

class Spaceship extends SpriteComponent with HasGameRef<Game> {
  Spaceship() : super(size: Vector2(50, 50)) {}
}
