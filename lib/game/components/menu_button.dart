import 'package:flame/components.dart';
import 'package:flame/events.dart';

import '../../constants/assets.dart';
import '../game.dart';
import '../game_utils.dart';

abstract class MenuButton extends SpriteComponent
    with HasGameRef<QubityGame>, TapCallbacks {
  MenuButton(String spriteImagePath) {
    this.spriteImagePath = GameUtils.extractImagePath(spriteImagePath);
  }

  static final Vector2 menuButtonSize = Vector2(50, 50);
  static const int menuButtonMarginRight = 10;
  late final String spriteImagePath;
  late final double positionX;
  late final double positionY;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(spriteImagePath);
    size = menuButtonSize;
    anchor = Anchor.topRight;
    super.onLoad();
  }
}

class PauseButton extends MenuButton {
  PauseButton() : super(pauseButtonPath);

  @override
  Future<void> onLoad() async {
    x = gameRef.size.x - MenuButton.menuButtonMarginRight;
    y = 0;
    super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (!gameRef.running) {
      gameRef.resumeLevel();
    } else {
      gameRef.pauseLevel();
    }
  }
}

class RestartButton extends MenuButton {
  RestartButton() : super(restartButtonPath);

  @override
  Future<void> onLoad() async {
    x = gameRef.size.x -
        MenuButton.menuButtonSize.x -
        MenuButton.menuButtonMarginRight * 2;
    y = 0;
    super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    gameRef.reloadLevel();
  }
}
