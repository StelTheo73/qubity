import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

import '../components/alert/game_exit.dart';
import '../game/game.dart';
import '../game/quantum/quantum_state.dart';
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

  Future<void> _handleGameExit(bool didPop) async {
    if (didPop) {
      return;
    }

    _game.pauseEngine();
    final bool shouldPop = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const GameExitAlert();
          },
        ) ??
        false;

    if (shouldPop) {
      LevelStates.teardown(_game.remove);
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } else {
      _game.resumeEngine();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: _handleGameExit,
      child: GameWidget<QubityGame>(
        game: _game,
      ),
    );
  }
}
