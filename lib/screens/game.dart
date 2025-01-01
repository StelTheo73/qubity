import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

import '../components/overlays/level_completion_overlay.dart';
import '../components/overlays/level_help_overlay.dart';
import '../components/overlays/level_tutorial_overlay.dart';
import '../components/overlays/pause_overlay.dart';
import '../game/qubity_game.dart';
import '../utils/config.dart';
import '../utils/utils.dart';

final Map<String, Widget Function(BuildContext context, QubityGame game)>
    _overlayBuilderMap =
    <String, Widget Function(BuildContext context, QubityGame game)>{
  PauseOverlay.overlayKey: (BuildContext context, QubityGame game) =>
      PauseOverlay(
        onResume: game.resumeLevel,
        onRestart: game.reloadLevel,
        onExit: () => game.exitLevel(context),
        onHelp: game.showHelp,
        gameSize: game.size,
      ),
  LevelCompletionOverlay.overlayKey: (BuildContext context, QubityGame game) =>
      LevelCompletionOverlay(
        onExit: () => game.exitLevel(context),
        loadNextLevel: game.loadNextLevel,
        reloadLevel: game.reloadLevel,
        gameSize: game.size,
        score: game.score,
        hasUnlockedSpaceship: game.hasUnlockedSpaceship,
      ),
  LevelHelpOverlay.overlayKey: (BuildContext context, QubityGame game) =>
      LevelHelpOverlay(
        gameSize: game.size,
        onResume: game.resumeLevel,
      ),
  LevelTutorialOverlay.overlayKey: (BuildContext context, QubityGame game) =>
      LevelTutorialOverlay(
        gameSize: game.size,
        onResume: game.resumeLevel,
      ),
};

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.initialLevel});

  final YamlMap initialLevel;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final QubityGame _game;
  late final Future<bool> isFullScreen;

  @override
  void initState() {
    _game = QubityGame(level: widget.initialLevel);
    _game.debugMode = Configuration.debugMode;
    super.initState();
    setState(() {
      isFullScreen = enterFullScreen();
    });
  }

  Future<bool> enterFullScreen() async {
    await Utils.enterFullScreen();
    return true;
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
    return FutureBuilder<bool>(
      future: isFullScreen,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && (snapshot.data ?? false)) {
          return PopScope(
            canPop: false,
            onPopInvoked: _handleGameExit,
            child: GameWidget<QubityGame>(
              game: _game,
              overlayBuilderMap: _overlayBuilderMap,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
