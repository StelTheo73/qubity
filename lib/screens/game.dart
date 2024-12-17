import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

import '../components/overlays/level_completion_overlay.dart';
import '../components/overlays/pause_overlay.dart';
import '../game/game.dart';
import '../utils/config.dart';

final Map<String, Widget Function(BuildContext context, QubityGame game)>
    _overlayBuilderMap =
    <String, Widget Function(BuildContext context, QubityGame game)>{
  PauseOverlay.overlayKey: (BuildContext context, QubityGame game) =>
      PauseOverlay(
        onResume: game.resumeLevel,
        onRestart: game.reloadLevel,
        onExit: () => game.exitLevel(context),
        gameSize: game.size,
      ),
  LevelCompletionOverlay.overlayKey: (BuildContext context, QubityGame game) =>
      LevelCompletionOverlay(
        onExit: () => game.exitLevel(context),
        loadNextLevel: game.loadNextLevel,
        reloadLevel: game.reloadLevel,
        gameSize: game.size,
        score: game.score,
        newHighScore: game.newHighScore,
      ),
};

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

    if (!_game.running) {
      _game.resumeLevel();
    } else {
      _game.pauseLevel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: _handleGameExit,
      child: GameWidget<QubityGame>(
        game: _game,
        overlayBuilderMap: _overlayBuilderMap,
      ),
    );
  }
}
