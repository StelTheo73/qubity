import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../store/tutorial_notifier.dart';
import '../button/base_button.dart';
import '../text/roboto.dart';
import 'base_overlay.dart';

class TutorialWidget extends StatelessWidget {
  const TutorialWidget({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RobotoText(
          text: title,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 10),
        RobotoText(
          text: description,
          fontSize: 16,
          color: Palette.black,
        ),
      ],
    );
  }
}

class LevelTutorialOverlay extends StatefulWidget {
  const LevelTutorialOverlay({
    super.key,
    required this.gameSize,
    required this.onResume,
  });

  final Vector2 gameSize;
  final VoidCallback onResume;

  static const String overlayKey = 'level_tutorial_overlay';
  static const int priority = 3;

  @override
  State<StatefulWidget> createState() => _LevelTutorialOverlayState();
}

class _LevelTutorialOverlayState extends State<LevelTutorialOverlay> {
  late Widget visibleChild;

  @override
  void initState() {
    super.initState();

    if (tutorialNotifier.tutorialMap.isEmpty) {
      widget.onResume();
      return;
    }

    setState(() {
      visibleChild = ListenableBuilder(
          listenable: tutorialNotifier,
          builder: (
            BuildContext context,
            Widget? child,
          ) {
            return TutorialWidget(
              title: tutorialNotifier.tutorialMap[0]['title'] ?? '',
              description: tutorialNotifier.tutorialMap[0]['description'] ?? '',
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseOverlay(
      gameSize: widget.gameSize,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          visibleChild,
          const SizedBox(height: 10),
          BaseButton(
            onPressed: widget.onResume,
            text: 'Close',
            width: 200,
          ),
        ],
      ),
    );
  }
}
