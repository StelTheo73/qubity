import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../button/base_button.dart';
import 'base_overlay.dart';

class PauseOverlay extends StatelessWidget {
  const PauseOverlay({
    super.key,
    required this.onResume,
    required this.onRestart,
    required this.onExit,
    required this.gameSize,
    required this.onHelp,
  });

  final Vector2 gameSize;
  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onExit;
  final VoidCallback onHelp;

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
            text: AppLocalizations.of(context)!.resume,
            width: 200,
          ),
          const SizedBox(height: 10),
          BaseButton(
            onPressed: onHelp,
            text: AppLocalizations.of(context)!.help,
            width: 200,
          ),
          const SizedBox(height: 10),
          BaseButton(
            onPressed: onRestart,
            text: AppLocalizations.of(context)!.restart,
            width: 200,
          ),
          const SizedBox(height: 10),
          BaseButton(
            onPressed: onExit,
            text: AppLocalizations.of(context)!.exit,
            width: 200,
          ),
        ],
      ),
    );
  }
}
