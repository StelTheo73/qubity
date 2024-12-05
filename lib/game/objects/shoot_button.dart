import 'package:flame/components.dart';
import 'package:flame/events.dart';

import '../../constants/assets.dart';
import '../game.dart';
import '../game_utils.dart';
import '../state/level_state.dart';
import 'spaceship.dart';

class ShootButton extends SpriteComponent
    with HasGameRef<QubityGame>, TapCallbacks {
  ShootButton();

  @override
  Future<void> onLoad() async {
    final String spriteImagePath = GameUtils.extractImagePath(shootButtonPath);
    sprite = await gameRef.loadSprite(spriteImagePath);
    size = Vector2(70, 70);
    anchor = Anchor.center;
    x = gameRef.size.x * 0.8;
    y = gameRef.size.y * 0.9;
    super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    for (final Spaceship spaceship in LevelStates.levelSpaceships) {
      spaceship.shoot();
    }
  }
}
