import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:yaml/yaml.dart';

class Game extends FlameGame<World> with TapCallbacks, HasCollisionDetection {
  Game({required this.level});

  bool running = true;
  YamlMap level;
}
