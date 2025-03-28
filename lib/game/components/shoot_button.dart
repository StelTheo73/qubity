import 'package:flame/components.dart';
import 'package:flame/events.dart';

import '../../constants/assets.dart';
import '../game_utils.dart';
import '../objects/spaceship.dart';
import '../qubity_game.dart';
import '../state/level_state.dart';

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
    y = gameRef.size.y * 0.7;
    super.onLoad();
  }

  @override
  Future<void> onTapUp(TapUpEvent event) async {
    if (!gameRef.running) {
      return;
    }

    // await FlameAudio.play(Sounds.Shot.sound);

    for (final Spaceship spaceship in LevelStates.levelSpaceships) {
      spaceship.shoot();
      gameRef.increaseShotsFired();
    }
    gameRef.onTapUpShootButton(event);
  }
}
