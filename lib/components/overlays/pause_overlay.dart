import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../button/base_button.dart';

class PauseOverlay extends StatelessWidget {
  const PauseOverlay({
    super.key,
    required this.onResume,
    required this.onRestart,
    required this.onExit,
    required this.gameSize,
  });

  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onExit;
  final Vector2 gameSize;

  static const String overlayKey = 'pause_overlay';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: gameSize.x,
          height: gameSize.y,
          color: Palette.black.withOpacity(0.5),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Palette.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: gameSize.x * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BaseButton(
                  onPressed: onResume,
                  text: 'Resume',
                  width: 150,
                ),
                const SizedBox(height: 10),
                BaseButton(
                  onPressed: onRestart,
                  text: 'Restart',
                  width: 150,
                ),
                const SizedBox(height: 10),
                BaseButton(
                  onPressed: onExit,
                  text: 'Exit',
                  width: 150,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
