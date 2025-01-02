import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

import '../../components/overlays/level_tutorial_overlay.dart';
import '../../components/overlays/pause_overlay.dart';
import '../../game/tutorial_game.dart';
import '../../utils/config.dart';
import '../../utils/utils.dart';

final Map<String, Widget Function(BuildContext context, TutorialGame game)>
    _overlayBuilderMap =
    <String, Widget Function(BuildContext context, TutorialGame game)>{
  PauseOverlay.overlayKey: (BuildContext context, TutorialGame game) =>
      PauseOverlay(
        onResume: game.resumeLevel,
        onRestart: game.reloadLevel,
        onExit: () => game.exitLevel(context),
        onHelp: game.showHelp,
        gameSize: game.size,
      ),
  LevelTutorialOverlay.overlayKey: (BuildContext context, TutorialGame game) =>
      LevelTutorialOverlay(
        gameSize: game.size,
        onResume: game.resumeLevel,
      ),
};

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key, required this.tutorialLevel});

  final YamlMap tutorialLevel;

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  late final TutorialGame _game;
  late final Future<bool> isFullScreen;

  @override
  void initState() {
    _game = TutorialGame(level: widget.tutorialLevel);
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
            child: GameWidget<TutorialGame>(
              game: _game,
              overlayBuilderMap: _overlayBuilderMap,
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
