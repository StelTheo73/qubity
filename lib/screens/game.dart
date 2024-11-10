import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

import '../game/game.dart';
import '../utils/config.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key, required this.level});

  YamlMap level;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final QubityGame _game;

  @override
  void initState() {
    _game = QubityGame(level: widget.level);
    _game.debugMode = Configuration.debugMode;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: _game,
    );
  }
}
