import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../store/level_help_notifier.dart';
import '../button/base_button.dart';
import '../text/roboto.dart';
import 'base_overlay.dart';

class HelpWidget extends StatelessWidget {
  const HelpWidget({
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

class LevelHelpOverlay extends StatefulWidget {
  const LevelHelpOverlay({
    super.key,
    required this.gameSize,
    required this.onResume,
  });

  final Vector2 gameSize;
  final VoidCallback onResume;

  static const String overlayKey = 'level_help_overlay';
  static const int priority = 3;

  @override
  State<StatefulWidget> createState() => _LevelHelpOverlayState();
}

class _LevelHelpOverlayState extends State<LevelHelpOverlay> {
  ValueNotifier<int> indexNotifier = ValueNotifier<int>(0);
  int index = 0;
  late Widget visibleChild;
  late BaseButton visibleButton;
  late final BaseButton nextButton;
  late final BaseButton startButton;

  @override
  void initState() {
    super.initState();

    startButton = BaseButton(
      onPressed: widget.onResume,
      text: 'Resume Level',
      width: 200,
    );

    nextButton = BaseButton(
      onPressed: _loadNextSlide,
      text: 'Next Slide',
      width: 200,
    );

    setState(() {
      if (levelHelpNotifier.levelHelpMap.length > 1) {
        visibleButton = nextButton;
      } else {
        visibleButton = startButton;
      }

      visibleChild = ValueListenableBuilder<int>(
        valueListenable: indexNotifier,
        builder: (BuildContext context, int index, Widget? child) {
          return ListenableBuilder(
            listenable: levelHelpNotifier,
            builder: (
              BuildContext context,
              Widget? child,
            ) {
              return HelpWidget(
                title: levelHelpNotifier.levelHelpMap[index]['title'] ?? '',
                description:
                    levelHelpNotifier.levelHelpMap[index]['description'] ?? '',
              );
            },
          );
        },
      );
    });
  }

  void _loadNextSlide() {
    setState(() {
      indexNotifier.value = indexNotifier.value + 1;
      if (indexNotifier.value == levelHelpNotifier.levelHelpMap.length - 1) {
        visibleButton = startButton;
      }
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
          visibleButton,
        ],
      ),
    );
  }
}
