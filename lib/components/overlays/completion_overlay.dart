import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../button/base_button.dart';
import '../text/roboto.dart';

class CompletionOverlay extends StatelessWidget {
  const CompletionOverlay({
    super.key,
    required this.onExit,
    required this.gameSize,
  });

  final VoidCallback onExit;
  final Vector2 gameSize;

  static const String overlayKey = 'completion_overlay';
  static const int priority = 2;

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
                const RobotoText(
                  text: 'Congratulations!',
                  color: Palette.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                const RobotoText(
                  text: 'You have completed the game!',
                  color: Palette.black,
                  fontSize: 16,
                ),
                const SizedBox(height: 20),
                BaseButton(
                  onPressed: onExit,
                  text: 'Level Selection',
                  width: 200,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
