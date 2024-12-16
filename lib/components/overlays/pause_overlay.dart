import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../button/base_button.dart';
import 'base_overlay.dart';

class PauseOverlay extends StatelessWidget {
  const PauseOverlay({
    super.key,
    required this.onResume,
    required this.onRestart,
    required this.onExit,
    required this.gameSize,
  });

  final Vector2 gameSize;
  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onExit;

  static const String overlayKey = 'pause_overlay';
  static const int priority = 1;

  @override
  Widget build(BuildContext context) {
    return BaseOverlay(
      gameSize: gameSize,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BaseButton(
            onPressed: onResume,
            text: 'Resume',
            width: 200,
          ),
          const SizedBox(height: 10),
          BaseButton(
            onPressed: onRestart,
            text: 'Restart',
            width: 200,
          ),
          const SizedBox(height: 10),
          BaseButton(
            onPressed: onExit,
            text: 'Exit',
            width: 200,
          ),
        ],
      ),
    );
  }
}
