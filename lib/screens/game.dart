import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

import '../game/game.dart';
import '../utils/config.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.initialLevel});

  final YamlMap initialLevel;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final QubityGame _game;

  @override
  void initState() {
    _game = QubityGame(level: widget.initialLevel);
    _game.debugMode = Configuration.debugMode;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget<QubityGame>(
      game: _game,
    );
  }
}
