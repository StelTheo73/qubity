import 'package:flame/components.dart';

import '../../constants/assets.dart';
import '../game_utils.dart';

class SpriteIcons {
  static late Sprite add;

  static Future<void> init(
    Future<Sprite> Function(String path) loadSprite,
  ) async {
    final String addSpritePath = GameUtils.extractImagePath(addButtonPath);
    add = await loadSprite(addSpritePath);
  }
}
