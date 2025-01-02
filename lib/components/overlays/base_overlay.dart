import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class BaseOverlay extends StatelessWidget {
  const BaseOverlay({
    super.key,
    required this.child,
    required this.gameSize,
  });

  final Vector2 gameSize;
  final Widget child;

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
            child: child,
          ),
        ),
      ],
    );
  }
}
