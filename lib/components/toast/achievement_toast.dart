import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../../components/text/roboto.dart';
import '../../constants/colors.dart';
import '../../l10n/app_localizations.dart';

class AchievementToast {
  const AchievementToast(this.context);

  final BuildContext context;

  void show() {
    toastification.show(
      closeOnClick: true,
      autoCloseDuration: const Duration(seconds: 5),
      showIcon: true,
      icon: const Icon(Icons.rocket_launch, color: Palette.primary),
      title: RobotoText(
        text: AppLocalizations.of(context)!.spaceshipUnlockedTitle,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      description: RobotoText(
        text: AppLocalizations.of(context)!.spaceshipUnlockedMessage,
        fontSize: 12,
        color: Palette.black,
      ),
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Alignment alignment,
            Widget child,
          ) => FadeTransition(opacity: animation, child: child),
    );
  }
}
